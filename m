From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Bug 46011] Capture of sound from USB connected
 audio card (UGM96) doesn't work in 3.5.1 - kernel bug generated: scheduling
 while atomic
Date: Thu, 16 Aug 2012 12:28:13 +0200
Message-ID: <502CCB3D.3070506@gmail.com>
References: <bug-46011-47592@https.bugzilla.kernel.org/>
 <20120815103121.D4D5211FC6C@bugzilla.kernel.org> <502B7B5B.1030808@gmail.com>
 <s5htxw4xwt7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DFBD26537D
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 11:58:31 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so771000bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 03:28:17 -0700 (PDT)
In-Reply-To: <s5htxw4xwt7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15.08.2012 12:40, Takashi Iwai wrote:
>>> Could you try the patch below?

Clemens, the patch below fixes a "sleeping while atomic" bug in the USB
audio driver, but it raises a new "not enough bandwidth" issue, which
might even be unreleated.

I currently don't see the root cause here, but I might be blind. Do you
have any idea?


Thanks,
Daniel


> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Fix scheduling-while-atomic bug in PCM
>  capture stream
> 
> A PCM capture stream on usb-audio causes a scheduling-while-atomic
> BUG, as reported in the bugzilla entry below.  It's because
> snd_usb_endpoint_start() is called at first at trigger START for a
> capture stream, and this function contains the left-over EP
> deactivation codes.  The problem doesn't happen for a playback stream
> because the function is called at PCM prepare time, which can sleep.
> 
> This patch fixes the BUG by moving the EP deactivation code into the
> PCM prepare callback.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=46011
> Cc: <stable@vger.kernel.org> [v3.5+]
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/endpoint.c | 4 ----
>  sound/usb/pcm.c      | 3 +++
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 0f647d2..c411812 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -821,10 +821,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
>  	if (++ep->use_count != 1)
>  		return 0;
>  
> -	/* just to be sure */
> -	deactivate_urbs(ep, 0, 1);
> -	wait_clear_urbs(ep);
> -
>  	ep->active_mask = 0;
>  	ep->unlink_mask = 0;
>  	ep->phase = 0;
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index a1298f3..62ec808 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -544,6 +544,9 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>  	subs->last_frame_number = 0;
>  	runtime->delay = 0;
>  
> +	/* clear the pending deactivation on the target EPs */
> +	deactivate_endpoints(subs);
> +
>  	/* for playback, submit the URBs now; otherwise, the first hwptr_done
>  	 * updates for all URBs would happen at the same time when starting */
>  	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
> 
