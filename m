From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Wed, 02 Nov 2011 11:26:37 +0100
Message-ID: <4EB11ADD.2090701@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D095B24615
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 11:25:41 +0100 (CET)
In-Reply-To: <1320063030-3502-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> +void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
> +{
> +	if (snd_usb_endpoint_implict_feedback_sink(ep) && ep->use_count > 0) {
>  		...
> +		for (i = 0; i < ep->nurbs; i++)
> +			if (!test_and_set_bit(i, &ep->active_mask)) {
> +				out_urb = ep->urb[i].urb;
> +				break;
> +			}
> +
> +		if (!out_urb) {
> +			snd_printk(KERN_ERR "Unable to find an urb for playback (nurbs %d)\n",
> +				   ep->nurbs);

AFAICS the driver tries for all URBS to be queued at all times.
So if the HC driver completes a sync URB before the corresponding
playback URB, it may be possible for this error to happen.


Regards,
Clemens
