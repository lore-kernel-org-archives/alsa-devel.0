From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: PCM states and snd_pcm_drain()
Date: Tue, 22 May 2012 09:22:56 +0100
Message-ID: <201205220922.56829.gineera@aspect135.co.uk>
References: <201205201825.30623.gineera@aspect135.co.uk>
	<s5h4nr9alox.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
	[62.24.128.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 83953104250
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 10:24:48 +0200 (CEST)
In-Reply-To: <s5h4nr9alox.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 21 May 2012 11:10, you wrote:
> At Sun, 20 May 2012 18:25:30 +0100,
>
> Alan Horstmann wrote:
> > Can snd_pcm_drain() be safely called on a non-running stream -
> > particularly one in SND_PCM_STATE_XRUN?  I can demonstrate lock-ups (on
> > rather old Alsa versions, though) when _drain is called on a stream in
> > Xrun but it does seem to vary between hardwares.
>
> Hm, that's odd.  At least there should be no lock up in the core code.
> Are you running the recent kernel?

Oh certainly not - sorry, I hadn't intended this post to be interpreted as a 
bug report, since I'm evaluating issues that arise (with Portaudio, again) on 
Alsa versions back to 1.0.12!  This showed up on the older ones.  I haven't 
precisely tracked it down since it is easy (and necessary) to work around.

> > However, the docs at:
> >
> > http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
> >
> > suggest that it should be fine.
>
> The snd_pcm_drop() calls simply ignore streams other than RUNNING,
> PREPARE and PAUSED.  So, it's basically safe.

Thanks, that is what I had wanted to check - it is expected to be handled OK.

> OTOH, it'd be better to drop XRUN streams to SETUP after this call,
> and there should be sane state checks at the beginning.
> I committed the patch below to my tree now.
>

Just one comment below

> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm - Add proper state checks to snd_pcm_drain()
>
> The handling for some PCM states is missing for snd_pcm_drain().
> At least, XRUN streams should be simply dropped to SETUP, and a few
> initial invalid states should be rejected.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 3fe99e6..53b5ada 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1360,7 +1360,14 @@ static int snd_pcm_prepare(struct snd_pcm_substream
> *substream,
>
>  static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream, int
> state) {
> -	substream->runtime->trigger_master = substream;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	switch (runtime->status->state) {
> +	case SNDRV_PCM_STATE_OPEN:
> +	case SNDRV_PCM_STATE_DISCONNECTED:
> +	case SNDRV_PCM_STATE_SUSPENDED:
> +		return -EBADFD;

I noticed the check for SNDRV_PCM_STATE_OPEN is already in the main 
snd_pcm_drain() function further down; is it better to add the others there?

Thanks for your assistance.

Alan
