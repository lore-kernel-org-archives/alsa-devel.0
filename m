From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 13 Oct 2015 12:15:21 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229C5C60@SHSMSX101.ccr.corp.intel.com>
References: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
 <1444727464-10385-2-git-send-email-yang.jie@intel.com>
 <1444728328.7124.8.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A8A40261A2F
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:15:31 +0200 (CEST)
In-Reply-To: <1444728328.7124.8.camel@loki>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Girdwood, Liam R
> Sent: Tuesday, October 13, 2015 5:25 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Koul, Vinod
> Subject: Re: [PATCH v3 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> + Vinod,
> 
> On Tue, 2015-10-13 at 17:11 +0800, Jie Yang wrote:
> > We don't always need soc-compress in soc, here add a config item
> > SND_SOC_COMPRESS, please add 'select SND_SOC_COMPRESS' to driver
> > Kconfig when it is needed.
> 
> We will need to identify the existing upstream compress users and add this
> option to their Kconfig as part of this patch.

Have checked that there is only one user(sst-mfld-platform-pcm.c ) for it,
and it's Kconfig change already in this patch.

~Keyon

> 
> Liam
> 
> >
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > ---
> >  include/sound/soc-dai.h                      | 2 +-
> >  include/sound/soc.h                          | 2 ++
> >  sound/soc/Kconfig                            | 6 +++++-
> >  sound/soc/Makefile                           | 6 +++++-
> >  sound/soc/intel/Kconfig                      | 1 +
> >  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
> >  sound/soc/soc-compress.c                     | 1 +
> >  sound/soc/soc-core.c                         | 4 ++--
> >  8 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h index
> > 2df96b1..238200f 100644
> > --- a/include/sound/soc-dai.h
> > +++ b/include/sound/soc-dai.h
> > @@ -214,7 +214,7 @@ struct snd_soc_dai_driver {
> >  	int (*suspend)(struct snd_soc_dai *dai);
> >  	int (*resume)(struct snd_soc_dai *dai);
> >  	/* compress dai */
> > -	bool compress_dai;
> > +	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
> >  	/* DAI is also used for the control bus */
> >  	bool bus_control;
> >
> > diff --git a/include/sound/soc.h b/include/sound/soc.h index
> > 470f208..623ce0c 100644
> > --- a/include/sound/soc.h
> > +++ b/include/sound/soc.h
> > @@ -452,7 +452,9 @@ int snd_soc_platform_read(struct
> snd_soc_platform
> > *platform,  int snd_soc_platform_write(struct snd_soc_platform *platform,
> >  					unsigned int reg, unsigned int val);
> int soc_new_pcm(struct
> > snd_soc_pcm_runtime *rtd, int num);
> > +#if IS_ENABLED(CONFIG_SND_SOC_COMPRESS)
> >  int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
> > +#endif
> >
> >  struct snd_pcm_substream *snd_soc_get_dai_substream(struct
> snd_soc_card *card,
> >  		const char *dai_link, int stream);
> > diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig index
> > 7de792b..20b3069 100644
> > --- a/sound/soc/Kconfig
> > +++ b/sound/soc/Kconfig
> > @@ -9,7 +9,6 @@ menuconfig SND_SOC
> >  	select SND_JACK if INPUT=y || INPUT=SND
> >  	select REGMAP_I2C if I2C
> >  	select REGMAP_SPI if SPI_MASTER
> > -	select SND_COMPRESS_OFFLOAD
> >  	---help---
> >
> >  	  If you want ASoC support, you should say Y here and also to the @@
> > -30,6 +29,11 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
> >  	bool
> >  	select SND_DMAENGINE_PCM
> >
> > +config SND_SOC_COMPRESS
> > +	tristate
> > +	select SND_COMPRESS_OFFLOAD
> > +	default n
> > +
> >  config SND_SOC_TOPOLOGY
> >  	bool
> >
> > diff --git a/sound/soc/Makefile b/sound/soc/Makefile index
> > af0a571..a3a1505 100644
> > --- a/sound/soc/Makefile
> > +++ b/sound/soc/Makefile
> > @@ -1,5 +1,9 @@
> >  snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o
> > soc-utils.o -snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o
> > soc-devres.o soc-ops.o
> > +snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
> > +
> > +ifneq ($(CONFIG_SND_SOC_COMPRESS),)
> > +snd-soc-core-objs += soc-compress.o
> > +endif
> >
> >  ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
> >  snd-soc-core-objs += soc-topology.o
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig index
> > 05fde5e6e..221e3bd 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -12,6 +12,7 @@ config SND_MFLD_MACHINE
> >
> >  config SND_SST_MFLD_PLATFORM
> >  	tristate
> > +	select SND_SOC_COMPRESS
> >
> >  config SND_SST_IPC
> >  	tristate
> > diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > index 5e9c316..cb1dd50 100644
> > --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > @@ -512,7 +512,7 @@ static struct snd_soc_dai_driver
> > sst_platform_dai[] = {  },  {
> >  	.name = "compress-cpu-dai",
> > -	.compress_dai = 1,
> > +	.compress_new = soc_new_compress,
> >  	.ops = &sst_compr_dai_ops,
> >  	.playback = {
> >  		.stream_name = "Compress Playback", diff --git
> > a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c index
> > 025c38f..a672d9c 100644
> > --- a/sound/soc/soc-compress.c
> > +++ b/sound/soc/soc-compress.c
> > @@ -703,3 +703,4 @@ compr_err:
> >  	kfree(compr);
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(soc_new_compress);
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c index
> > 3b471f9..24b0960 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -1370,9 +1370,9 @@ static int soc_probe_link_dais(struct
> snd_soc_card *card, int num, int order)
> >  		soc_dpcm_debugfs_add(rtd);
> >  #endif
> >
> > -	if (cpu_dai->driver->compress_dai) {
> > +	if (cpu_dai->driver->compress_new) {
> >  		/*create compress_device"*/
> > -		ret = soc_new_compress(rtd, num);
> > +		ret = cpu_dai->driver->compress_new(rtd, num);
> >  		if (ret < 0) {
> >  			dev_err(card->dev, "ASoC: can't create
> compress %s\n",
> >  					 dai_link->stream_name);
> 
