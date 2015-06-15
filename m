From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Mon, 15 Jun 2015 14:46:23 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DD8D264F0D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 16:46:28 +0200 (CEST)
In-Reply-To: <s5h4mm9gi8h.wl-tiwai@suse.de>
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
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 15, 2015 10:27 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> At Mon, 15 Jun 2015 14:15:40 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Monday, June 15, 2015 7:34 PM
> > > To: Jie, Yang
> > > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam
> > > R; vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang,
> > > Vivian
> > > Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config item
> > > for soc- compress
> > >
> > > At Mon, 15 Jun 2015 11:20:44 +0800,
> > > Jie Yang wrote:
> > > >
> > > > We don't always need soc-compress in soc, here add a config item
> > > > SND_SOC_COMPRESS, please add 'select SND_SOC_COMPRESS' to
> driver
> > > > Kconfig when it is needed.
> > > >
> > > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > > ---
> > > >  include/sound/soc.h     | 7 +++++++
> > > >  sound/soc/Kconfig       | 5 ++++-
> > > >  sound/soc/Makefile      | 3 ++-
> > > >  sound/soc/intel/Kconfig | 1 +
> > > >  4 files changed, 14 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/sound/soc.h b/include/sound/soc.h index
> > > > 93df8bf..cc1cd4f 100644
> > > > --- a/include/sound/soc.h
> > > > +++ b/include/sound/soc.h
> > > > @@ -440,7 +440,14 @@ int snd_soc_platform_read(struct
> > > snd_soc_platform
> > > > *platform,  int snd_soc_platform_write(struct snd_soc_platform
> *platform,
> > > >  					unsigned int reg, unsigned int val);
> > > int soc_new_pcm(struct
> > > > snd_soc_pcm_runtime *rtd, int num);
> > > > +#if IS_ENABLED(CONFIG_SND_SOC_COMPRESS)
> > > >  int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
> > > > +#else
> > > > +static inline int soc_new_compress(struct snd_soc_pcm_runtime
> > > > +*rtd, int num) {
> > > > +       return -EPERM;
> > > > +}
> > > > +#endif
> > >
> > > A dummy function in such a case has both merit and demerit.  The
> > > demerit is that you won't get errors if the driver really wants the
> > > compress support but just forgot to select the dependency.
> >
> > Here I used -EPERM to return and tell caller that compress operation
> > is not permitted, does it make sense, Takashi?
> 
> The question is whether a runtime error is the best option.  A runtime error
> won't be caught by build tests but only when actually running by a user.
 
Unfortunately, here cpu_dai->driver->compress_dai is a runtime value,
which means we need compress API when it is true. Seems it is not easy
to decide it at compile stage?

> 
> > Or can you suggest a better solution, according to this specific case?
> 
> Well, there are several ways, obviously (e.g. give the preprocessor error if
> CONFIG_SND_SOC_COMPRESS is enabled).  But I'm not sure what is the best
 
Do you mean giving error, when CONFIG_SND_SOC_COMPRESS is disabled but
the driver wants the compress support at the same time?

As I stated above, it's not easy to detect whether the driver wants the compress
support, at the preprocessor/compile stage. :(

~Keyon

> to fit, too.  It's rather a matter of taste.
> 
> 
> Takashi
> 
> > Thanks,
> > ~Keyon
> > >
> > >
> > > Takashi
> > >
> > > >  struct snd_pcm_substream *snd_soc_get_dai_substream(struct
> > > snd_soc_card *card,
> > > >  		const char *dai_link, int stream); diff --git
> > > > a/sound/soc/Kconfig b/sound/soc/Kconfig index
> > > > e2828e1..a124759 100644
> > > > --- a/sound/soc/Kconfig
> > > > +++ b/sound/soc/Kconfig
> > > > @@ -9,7 +9,6 @@ menuconfig SND_SOC
> > > >  	select SND_JACK if INPUT=y || INPUT=SND
> > > >  	select REGMAP_I2C if I2C
> > > >  	select REGMAP_SPI if SPI_MASTER
> > > > -	select SND_COMPRESS_OFFLOAD
> > > >  	---help---
> > > >
> > > >  	  If you want ASoC support, you should say Y here and also to
> > > > the @@
> > > > -30,6 +29,10 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
> > > >  	bool
> > > >  	select SND_DMAENGINE_PCM
> > > >
> > > > +config SND_SOC_COMPRESS
> > > > +	tristate
> > > > +	select SND_COMPRESS_OFFLOAD
> > > > +
> > > >  # All the supported SoCs
> > > >  source "sound/soc/adi/Kconfig"
> > > >  source "sound/soc/atmel/Kconfig"
> > > > diff --git a/sound/soc/Makefile b/sound/soc/Makefile index
> > > > a0e1ee6..184c1e6 100644
> > > > --- a/sound/soc/Makefile
> > > > +++ b/sound/soc/Makefile
> > > > @@ -1,6 +1,7 @@
> > > >  snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o
> > > > soc-utils.o -snd-soc-core-objs += soc-pcm.o soc-compress.o
> > > > soc-io.o soc-devres.o soc-ops.o
> > > > +snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
> > > >  snd-soc-core-objs += soc-topology.o
> > > > +snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
> > > >
> > > >  ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
> > > >  snd-soc-core-objs += soc-generic-dmaengine-pcm.o diff --git
> > > > a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig index
> > > > 791953f..e559174 100644
> > > > --- a/sound/soc/intel/Kconfig
> > > > +++ b/sound/soc/intel/Kconfig
> > > > @@ -12,6 +12,7 @@ config SND_MFLD_MACHINE
> > > >
> > > >  config SND_SST_MFLD_PLATFORM
> > > >  	tristate
> > > > +	select SND_SOC_COMPRESS
> > > >
> > > >  config SND_SST_IPC
> > > >  	tristate
> > > > --
> > > > 1.9.1
> > > >
> >
