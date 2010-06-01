From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ALSA/NUC900: Fix some codes according
 to Liam for nuc900 alsa driver.
Date: Tue, 01 Jun 2010 10:04:57 +0100
Message-ID: <1275383097.3060.7.camel@odin>
References: <4C0474F3.3050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8BE210397A
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 11:05:02 +0200 (CEST)
Received: by wyb32 with SMTP id 32so955793wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 02:05:01 -0700 (PDT)
In-Reply-To: <4C0474F3.3050503@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-06-01 at 10:48 +0800, Wan ZongShun wrote:
> Dear Liam & Mark,
> 
> This patch is to fix some codes according to
> Liam for nuc900 alsa driver.
> 
> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

The changes here looks fine. Can you resend and add a summary of the
changes to the commit message. It's also good practice to split into a
new patch for every issue you are fixing, i.e. in this case I would have
one patch for the AC97 delays and another patch for the PCM_TX removal.

Thanks

Liam

> 
> ---
>  sound/soc/nuc900/nuc900-ac97.c  |   20 +++++---------------
>  sound/soc/nuc900/nuc900-auido.h |    4 ----
>  sound/soc/nuc900/nuc900-pcm.c   |   18 ++++++++++--------
>  3 files changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> index f7b44e0..5b864f9 100644
> --- a/sound/soc/nuc900/nuc900-ac97.c
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -149,7 +149,7 @@ static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
>  	val |= AC_W_RES;
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> 
> -	udelay(1000);
> +	udelay(100);
> 
>  	val = nuc900_checkready();
>  	if (!!val)
> @@ -170,40 +170,30 @@ static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
>  	val |= ACTL_RESET_BIT;
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> 
> -	udelay(1000);
> -
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
>  	val &= (~ACTL_RESET_BIT);
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> 
> -	udelay(1000);
> -
>  	/* reset AC-link interface */
> 
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
>  	val |= AC_RESET;
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> 
> -	udelay(1000);
> -
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
>  	val &= ~AC_RESET;
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> 
> -	udelay(1000);
> -
>  	/* cold reset AC 97 */
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
>  	val |= AC_C_RES;
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> 
> -	udelay(1000);
> -
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
>  	val &= (~AC_C_RES);
>  	AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> 
> -	udelay(1000);
> +	udelay(100);
> 
>  	mutex_unlock(&ac97_mutex);
> 
> @@ -222,7 +212,7 @@ static int nuc900_ac97_trigger(struct snd_pcm_substream
> *substream,
>  				int cmd, struct snd_soc_dai *dai)
>  {
>  	struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> -	int ret, stype = SUBSTREAM_TYPE(substream);
> +	int ret;
>  	unsigned long val, tmp;
> 
>  	ret = 0;
> @@ -231,7 +221,7 @@ static int nuc900_ac97_trigger(struct snd_pcm_substream
> *substream,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  		val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> -		if (PCM_TX == stype) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  			tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
>  			tmp |= (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);
>  			AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> @@ -254,7 +244,7 @@ static int nuc900_ac97_trigger(struct snd_pcm_substream
> *substream,
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  		val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> -		if (PCM_TX == stype) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  			tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
>  			tmp &= ~(SLOT3_VALID | SLOT4_VALID);
>  			AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> diff --git a/sound/soc/nuc900/nuc900-auido.h b/sound/soc/nuc900/nuc900-auido.h
> index 95ac4ef..3038f51 100644
> --- a/sound/soc/nuc900/nuc900-auido.h
> +++ b/sound/soc/nuc900/nuc900-auido.h
> @@ -96,10 +96,6 @@
>  #define RESET_PRSR		0x00
>  #define AUDIO_WRITE(addr, val)	__raw_writel(val, addr)
>  #define AUDIO_READ(addr)	__raw_readl(addr)
> -#define PCM_TX			0
> -#define PCM_RX			1
> -#define SUBSTREAM_TYPE(substream) \
> -	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)
> 
>  struct nuc900_audio {
>  	void __iomem *mmio;
> diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
> index 32a503c..445a180 100644
> --- a/sound/soc/nuc900/nuc900-pcm.c
> +++ b/sound/soc/nuc900/nuc900-pcm.c
> @@ -47,7 +47,7 @@ static int nuc900_dma_hw_params(struct snd_pcm_substream
> *substream,
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct nuc900_audio *nuc900_audio = runtime->private_data;
> -	unsigned long flags, stype = SUBSTREAM_TYPE(substream);
> +	unsigned long flags;
>  	int ret = 0;
> 
>  	spin_lock_irqsave(&nuc900_audio->lock, flags);
> @@ -57,8 +57,9 @@ static int nuc900_dma_hw_params(struct snd_pcm_substream
> *substream,
>  		return ret;
> 
>  	nuc900_audio->substream = substream;
> -	nuc900_audio->dma_addr[stype] = runtime->dma_addr;
> -	nuc900_audio->buffersize[stype] = params_buffer_bytes(params);
> +	nuc900_audio->dma_addr[substream->stream] = runtime->dma_addr;
> +	nuc900_audio->buffersize[substream->stream] =
> +						params_buffer_bytes(params);
> 
>  	spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> 
> @@ -72,7 +73,7 @@ static void nuc900_update_dma_register(struct
> snd_pcm_substream *substream,
>  	struct nuc900_audio *nuc900_audio = runtime->private_data;
>  	void __iomem *mmio_addr, *mmio_len;
> 
> -	if (SUBSTREAM_TYPE(substream) == PCM_TX) {
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		mmio_addr = nuc900_audio->mmio + ACTL_PDSTB;
>  		mmio_len = nuc900_audio->mmio + ACTL_PDST_LENGTH;
>  	} else {
> @@ -167,18 +168,19 @@ static int nuc900_dma_prepare(struct snd_pcm_substream
> *substream)
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct nuc900_audio *nuc900_audio = runtime->private_data;
> -	unsigned long flags, val, stype = SUBSTREAM_TYPE(substream);;
> +	unsigned long flags, val;
> 
>  	spin_lock_irqsave(&nuc900_audio->lock, flags);
> 
>  	nuc900_update_dma_register(substream,
> -		nuc900_audio->dma_addr[stype], nuc900_audio->buffersize[stype]);
> +				nuc900_audio->dma_addr[substream->stream],
> +				nuc900_audio->buffersize[substream->stream]);
> 
>  	val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> 
>  	switch (runtime->channels) {
>  	case 1:
> -		if (PCM_TX == stype) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  			val &= ~(PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
>  			val |= PLAY_RIGHT_CHNNEL;
>  		} else {
> @@ -188,7 +190,7 @@ static int nuc900_dma_prepare(struct snd_pcm_substream
> *substream)
>  		AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
>  		break;
>  	case 2:
> -		if (PCM_TX == stype)
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  			val |= (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
>  		else
>  			val |= (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
