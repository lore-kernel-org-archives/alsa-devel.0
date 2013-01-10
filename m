From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: Oops in
 sound/usb/pcm.c:match_endpoint_audioformats() in current -git
Date: Thu, 10 Jan 2013 20:45:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301102038560.1321@xoschi>
References: <50EE7A94.60409@kernel.dk> <s5hobgx72zf.wl%tiwai@suse.de>
 <50EEB8D2.2030702@kernel.dk> <s5hsj696tgw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE582616EE
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 20:45:10 +0100 (CET)
Received: by mail-bk0-f50.google.com with SMTP id jf3so541783bkc.23
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 11:45:10 -0800 (PST)
In-Reply-To: <s5hsj696tgw.wl%tiwai@suse.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 10 Jan 2013, Takashi Iwai wrote:

> At Thu, 10 Jan 2013 13:49:22 +0100,
> Jens Axboe wrote:
> > 
> > Here it is, it's from the one introducing the audioformat lookup.
> > Confirmed that 3.8-rc3 with this backed out works fine, too. So should
> > be fairly confident in that result.

> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Fix NULL dereference by access to
>  non-existing substream
> 
> The commit [0d9741c0: ALSA: usb-audio: sync ep init fix for
> audioformat mismatch] introduced the correction of parameters to be
> set for sync EP.  But since the new code assumes that the sync EP is
> always paired with the data EP of another direction, it triggers Oops
> when a device only with a single direction is used.

Yes - sorry, I didn't consider this at all.

> This patch adds a proper check of sync EP type and the presence of the
> paired substream for avoiding the crash.
> 
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/pcm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index c659310..21c0001 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -511,6 +511,17 @@ static int configure_sync_endpoint(struct snd_usb_substream *subs)
>  	struct snd_usb_substream *sync_subs =
>  		&subs->stream->substream[subs->direction ^ 1];
>  
> +	if (subs->sync_endpoint->type != SND_USB_ENDPOINT_TYPE_DATA ||
> +	    !subs->stream) {
> +		ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
> +						  subs->pcm_format,
> +						  subs->channels,
> +						  subs->period_bytes,
> +						  subs->cur_rate,
> +						  subs->cur_audiofmt,
> +						  NULL);
> +	}
> +

I think you want to return here, no?



Jens, could you please send me the device's descriptors (lsusb -v)?
I'd like to take a closer look at this.

Cheers,
Eldad
