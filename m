From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Add an
 interface to override its functions
Date: Tue, 15 Oct 2013 16:22:30 +0800
Message-ID: <20131015082229.GA18714@MrMyself>
References: <1381823360-8672-1-git-send-email-b42378@freescale.com>
 <525CF814.6090403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id E364426030A
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 10:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525CF814.6090403@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On Tue, Oct 15, 2013 at 10:08:52AM +0200, Lars-Peter Clausen wrote:
> On 10/15/2013 09:49 AM, Nicolin Chen wrote:
> > Each implementation of gerneric pcm dmaengine has been naturally
> > limited by the pre-defined gerneric functions. Thus add an extra
> > interface for user to create a backdoor so that they can override
> > those fixed functions for some uncommon requirements: using on-chip
> > memory for DMA buffers and accordingly different mmap function for
> > example, while at the meantime, they can continue to benifit from
> > the concise and wise generic pcm dmaengine.
> > 
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> 
> We do have the dmaengine pcm helper functions (sound/core/pcm_dmaengine.c)
> and the generic dmaengine pcm ASoC driver
> (sound/soc/soc-generic-dmaengine-pcm.c). The generic dmaengine pcm ASoC
> driver uses the dmaengine pcm helper functions, but it is not the only user
> of them. So your patch breaks all other users of the helper functions.
> 
> The helper functions are designed in a way that you can either wrap them in
> your own pcm driver driver or not use them at all. E.g. take a look at
> sound/soc/omap/omap-pcm.c on how to overwrite specific functions.
> 
> - Lars

If this modification to sound/core/pcm_dmaengine.c is not fair,
what about moving the modification to soc-gerneric-dmaengine-pcm.c?

For example, instead of using snd_dmaengine_pcm_trigger() directly
in gerneric soc dmaengine driver, we create a new one inside gerneric
soc dmaengine driver and check the override:

static int snd_soc_dmaengine_pcm_trigger(substream, cmd) {
	if (config->driver->ops->trigger)
		return config->driver->ops->trigger(substream, cmd);
		
	return snd_dmaengine_pcm_trigger(substream, cmd);
}

Since it happens inside generic dmaengine pcm ASoC driver, it won't break
those helper functions.

I'm trying this just because I hope generic dmaengine can be more flexible
Admittedly, using helper functions might be more plausible way in current
ASoC structure. However, there might be so much change for an generic soc
dmaengine implementation even if it just wants to override one single func.

Thank you,
Nicolin Chen


> 
> > ---
> >  include/sound/dmaengine_pcm.h         | 13 +++++++++++++
> >  sound/core/pcm_dmaengine.c            | 25 +++++++++++++++++++++++++
> >  sound/soc/soc-generic-dmaengine-pcm.c | 30 ++++++++++++++++++------------
> >  3 files changed, 56 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> > index f11c35c..a6e9d04 100644
> > --- a/include/sound/dmaengine_pcm.h
> > +++ b/include/sound/dmaengine_pcm.h
> > @@ -33,6 +33,18 @@ snd_pcm_substream_to_dma_direction(const struct snd_pcm_substream *substream)
> >  		return DMA_DEV_TO_MEM;
> >  }
> >  
> > +struct dmaengine_pcm {
> > +	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
> > +	const struct snd_dmaengine_pcm_config *config;
> > +	struct snd_soc_platform platform;
> > +	unsigned int flags;
> > +};
> > +
> > +static inline struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
> > +{
> > +	return container_of(p, struct dmaengine_pcm, platform);
> > +}
> > +
> >  int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
> >  	const struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config);
> >  int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
> > @@ -123,6 +135,7 @@ struct snd_dmaengine_pcm_config {
> >  			struct snd_pcm_substream *substream);
> >  	dma_filter_fn compat_filter_fn;
> >  
> > +	const struct snd_soc_platform_driver *driver;
> >  	const struct snd_pcm_hardware *pcm_hardware;
> >  	unsigned int prealloc_buffer_size;
> >  };
> > diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> > index aa924d9..d78a67e 100644
> > --- a/sound/core/pcm_dmaengine.c
> > +++ b/sound/core/pcm_dmaengine.c
> > @@ -186,8 +186,14 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
> >  int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> >  {
> >  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> >  	int ret;
> >  
> > +	if (config->driver->ops->trigger)
> > +		return config->driver->ops->trigger(substream, cmd);
> > +
> >  	switch (cmd) {
> >  	case SNDRV_PCM_TRIGGER_START:
> >  		ret = dmaengine_pcm_prepare_and_submit(substream);
> > @@ -224,6 +230,13 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
> >  snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream *substream)
> >  {
> >  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> > +
> > +	if (config->driver->ops->pointer)
> > +		return config->driver->ops->pointer(substream);
> > +
> >  	return bytes_to_frames(substream->runtime, prtd->pos);
> >  }
> >  EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
> > @@ -238,11 +251,17 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
> >  snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
> >  {
> >  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> >  	struct dma_tx_state state;
> >  	enum dma_status status;
> >  	unsigned int buf_size;
> >  	unsigned int pos = 0;
> >  
> > +	if (config->driver->ops->pointer)
> > +		return config->driver->ops->pointer(substream);
> > +
> >  	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
> >  	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
> >  		buf_size = snd_pcm_lib_buffer_bytes(substream);
> > @@ -341,6 +360,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
> >  int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
> >  {
> >  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> > +
> > +	if (config->driver->ops->close)
> > +		return config->driver->ops->close(substream);
> >  
> >  	kfree(prtd);
> >  
> > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> > index e29ec3c..6e66c53 100644
> > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> > @@ -24,18 +24,6 @@
> >  
> >  #include <sound/dmaengine_pcm.h>
> >  
> > -struct dmaengine_pcm {
> > -	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
> > -	const struct snd_dmaengine_pcm_config *config;
> > -	struct snd_soc_platform platform;
> > -	unsigned int flags;
> > -};
> > -
> > -static struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
> > -{
> > -	return container_of(p, struct dmaengine_pcm, platform);
> > -}
> > -
> >  /**
> >   * snd_dmaengine_pcm_prepare_slave_config() - Generic prepare_slave_config callback
> >   * @substream: PCM substream
> > @@ -75,9 +63,13 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >  	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> >  	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> >  	struct dma_slave_config slave_config;
> >  	int ret;
> >  
> > +	if (config->driver->ops->hw_params)
> > +		return config->driver->ops->hw_params(substream, params);
> > +
> >  	if (pcm->config->prepare_slave_config) {
> >  		ret = pcm->config->prepare_slave_config(substream, params,
> >  				&slave_config);
> > @@ -96,9 +88,13 @@ static int dmaengine_pcm_open(struct snd_pcm_substream *substream)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >  	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> >  	struct dma_chan *chan = pcm->chan[substream->stream];
> >  	int ret;
> >  
> > +	if (config->driver->ops->open)
> > +		return config->driver->ops->open(substream);
> > +
> >  	ret = snd_soc_set_runtime_hwparams(substream,
> >  				pcm->config->pcm_hardware);
> >  	if (ret)
> > @@ -118,6 +114,13 @@ static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
> >  
> >  static void dmaengine_pcm_free(struct snd_pcm *pcm)
> >  {
> > +	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
> > +	struct dmaengine_pcm *dma_pcm = soc_platform_to_pcm(rtd->platform);
> > +	const struct snd_dmaengine_pcm_config *config = dma_pcm->config;
> > +
> > +	if (config->driver->pcm_free)
> > +		return config->driver->pcm_free(pcm);
> > +
> >  	snd_pcm_lib_preallocate_free_for_all(pcm);
> >  }
> >  
> > @@ -145,6 +148,9 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
> >  	unsigned int i;
> >  	int ret;
> >  
> > +	if (config->driver->pcm_new)
> > +		return config->driver->pcm_new(rtd);
> > +
> >  	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> >  		substream = rtd->pcm->streams[i].substream;
> >  		if (!substream)
> > 
> 
> 
