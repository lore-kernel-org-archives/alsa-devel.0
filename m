From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: soc-compress: add a config
 item	for soc-compress
Date: Tue, 13 Oct 2015 12:31:39 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229C5C7E@SHSMSX101.ccr.corp.intel.com>
References: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
 <1444727464-10385-2-git-send-email-yang.jie@intel.com>
 <s5hk2qrkta5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 55406261A3B
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:31:51 +0200 (CEST)
In-Reply-To: <s5hk2qrkta5.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, October 13, 2015 5:33 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: soc-compress: add a config
> item for soc-compress
> 
> On Tue, 13 Oct 2015 11:11:03 +0200,
> Jie Yang wrote:
> >
> > We don't always need soc-compress in soc, here add a config item
> > SND_SOC_COMPRESS, please add 'select SND_SOC_COMPRESS' to driver
> > Kconfig when it is needed.
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
> 
> Maybe better to provide a dummy function returning an error when this isn't
> enabled.

But I remember that you mentioned(comment to v2 on June 15th) that you 
don't like dummy function:

'A dummy function in such a case has both merit and demerit.  The demerit is
that you won't get errors if the driver really wants the compress support but
just forgot to select the dependency.

Takashi'

> 
> Also, as a namespace issue, we usually keep snd_ prefix for exported
> functions.
 
OK, let me change it to snd_xxx.

> 
> 
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
> 
> No need for default n.  It's default.
 
Okay.

> 
> 
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
> 
> This can be simplified like
> 
> snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
I tried this as you have mentioned before, but it seems can't work properly
when CONFIG_SND_SOC_COMPRESS is set to 'm'.
Not clear why it happen yet. :(

> 
> 
> >  ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
> >  snd-soc-core-objs += soc-topology.o
> 
> Oh, this is also... Make another patch :)
> 
> 
> > diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c index
> > 025c38f..a672d9c 100644
> > --- a/sound/soc/soc-compress.c
> > +++ b/sound/soc/soc-compress.c
> > @@ -703,3 +703,4 @@ compr_err:
> >  	kfree(compr);
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(soc_new_compress);
> 
> When you're creating a new exported function, don't forget to give a proper
> documentation in the function comment.

Vinod also comment/mention this, OK, will add it. 

~Keyon

> 
> 
> thanks,
> 
> Takashi
