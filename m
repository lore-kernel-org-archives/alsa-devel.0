From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 24/44] fireworks: Add MIDI interface
Date: Thu, 03 Apr 2014 23:20:03 +0200
Message-ID: <533DD083.10506@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-25-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-25-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This commit adds a functionality to capture/playback MIDI messages.
>
> When no AMDTP streams are running, this driver starts AMDTP stream for MIDI
> stream at current sampling rate.
>
> +++ b/sound/firewire/fireworks/fireworks_midi.c
> +static int midi_capture_open(struct snd_rawmidi_substream *substream)
> +{
> +	struct snd_efw *efw = substream->rmidi->private_data;
> +
> +	efw->capture_substreams++;

The MIDI .open callback is not synchronized with the PCM callbacks;
this might race and must be protected with a mutex.


Regards,
Clemens

------------------------------------------------------------------------------
