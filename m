From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] ALSA: usb-audio: Fix missing autopm
 for MIDI input
Date: Mon, 03 Dec 2012 21:47:48 +0100
Message-ID: <50BD0FF4.50301@ladisch.de>
References: <1354531738-22046-1-git-send-email-tiwai@suse.de>
 <1354531738-22046-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E50D626169D
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 21:48:11 +0100 (CET)
In-Reply-To: <1354531738-22046-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Banks <amoebae@gmail.com>, alsa-devel@alsa-project.org, Olivier MATZ <zer0@droids-corp.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The commit [88a8516a: ALSA: usbaudio: implement USB autosuspend] added
> the support of autopm for USB MIDI output, but it didn't take the MIDI
> input into account.
>
> This patch adds the following for fixing the autopm:
> - Manage the URB start at the first MIDI input stream open, instead of
>   the time of instance creation
> - Move autopm code to the common substream_open()
> - Make snd_usbmidi_input_start/_stop() more robust and add the running
>   state check
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ...
> +static int substream_open(struct snd_rawmidi_substream *substream, int dir,
> +			  int open)
>  {
>  	struct snd_usb_midi* umidi = substream->rmidi->private_data;
>  	struct snd_kcontrol *ctl;
> +	int err;
>
>  	down_read(&umidi->disc_rwsem);
>  	if (umidi->disconnected) {
>  		up_read(&umidi->disc_rwsem);
> +		return open ? -ENODEV : 0;
>  	}
>
>  	mutex_lock(&umidi->mutex);
>  	if (open) {
> +		if (!umidi->opened[0] && !umidi->opened[1]) {
> +			err = usb_autopm_get_interface(umidi->iface);
> +			umidi->autopm_reference = err >= 0;
> +			if (err < 0 && err != -EACCES) {
> +				up_read(&umidi->disc_rwsem);
> +				return -EIO;

umidi->mutex is still held here.

Otherwise, for both patches:
Reviewd-by: Clemens Ladisch <clemens@ladisch.de>
Tested-by: Clemens Ladisch <clemens@ladisch.de>


Regards,
Clemens
