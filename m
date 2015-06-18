From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 18 Jun 2015 16:44:51 +0530
Message-ID: <20150618111451.GH28601@localhost>
References: <1432892521.2732.14.camel@loki> <20150529131753.GA339@asus>
 <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150616205053.GA323@asus> <1434532575.2471.13.camel@loki>
 <20150617213410.GA907@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E436260588
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 13:13:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150617213410.GA907@asus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 17, 2015 at 11:34:10PM +0200, Michele Curti wrote:
> On Wed, Jun 17, 2015 at 10:16:15AM +0100, Liam Girdwood wrote:
> > On Tue, 2015-06-16 at 22:50 +0200, Michele Curti wrote:
> > > On Mon, Jun 15, 2015 at 06:04:28PM +0100, Liam Girdwood wrote:
> > > > 
> > > > We are also a little suspicious that this laptop is using SSP1 for the
> > > > I2S audio connection to the codec. The bad news is that the FW used by
> > > > this BYT ADSP driver does not support the SSP1 port. It's hard coded to
> > > > use SSP0 (Jarrko, please correct the port numbering if it's wrong).
> > > > There are going to be no further releases of this FW.
> > > > 
> > > > However, the other upstream BYT ADSP driver from Vinod's team is going
> > > > to support the other SSP ports. It currently only supports SSP0, but I
> > > > believe that a new FW will be released soon that will support SSP1.
> > > > Vinod do you know the new FW release date ?
> > > > 
> > > > Michele, can you change your machine driver to use the Vinods BYT DSP
> > > > PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> > > > the current FW release from Vinod too. That way you should be ready to
> > > > integrate the new FW when it is released. Please also CC Vinod on any
> > > > issues you have getting the FW to boot using the new driver/FW.
> > > >
> > > 
> > > Sure!
> > > 
> > > A note, without enabling the config option SND_SOC_INTEL_SST the driver
> > > will not compile/install but it seems strange because when doing a 
> > > menuconfig the machine driver option is available even if the 
> > > SND_SOC_INTEL_SST option is not selcted (I copied the Kconfig part 
> > > from the SND_SOC_INTEL_BYTCR_RT5640_MACH one).
Only selecting the SND_SOC_INTEL_BYTCR_RT5640_MACH should do, rest is auto
selected

> > 
> > Is the BYTCR_RT5640 building for you ? This driver family uses the
> > SND_SST_MFLD_PLATFORM instead of the SND_SOC_INTEL_SST platform.
> 
> Mmmh.. indeed no.. I tried with a clean linux-next, doing a make clean and
> selecting the SND_SOC_INTEL_BYTCR_RT5640_MACH option using menuconfig:
> 
> [zio@asus linux-next]$ grep BYTCR_RT5640 .config
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> [zio@asus linux-next]$ grep SND_SST_MFLD_PLATFORM .config
> CONFIG_SND_SST_MFLD_PLATFORM=m
> [zio@asus linux-next]$ 
> 
> But when I do a make the driver don't compile
> 
> [zio@asus linux-next]$ ls sound/soc/intel/boards/*.o
> ls: cannot access sound/soc/intel/boards/*.o: No such file or directory
> 
> And when I do a make install the only (sound) installed modules are
> 
>   INSTALL sound/core/snd-compress.ko
>   INSTALL sound/core/snd-pcm.ko
>   INSTALL sound/core/snd-timer.ko
>   INSTALL sound/core/snd.ko
>   INSTALL sound/soc/codecs/snd-soc-rl6231.ko
>   INSTALL sound/soc/codecs/snd-soc-rt5640.ko
>   INSTALL sound/soc/intel/atom/snd-soc-sst-mfld-platform.ko
>   INSTALL sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko
>   INSTALL sound/soc/intel/atom/sst/snd-intel-sst-core.ko
>   INSTALL sound/soc/snd-soc-core.ko
>   INSTALL sound/soundcore.ko
>   DEPMOD  4.1.0-rc8-next-20150617-asus
I am using Marks next

$ grep BYTCR_RT5640 .config
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
$ grep SND_SST_MFLD_PLATFORM .config
CONFIG_SND_SST_MFLD_PLATFORM=m
$ ls sound/soc/intel/boards/*.o
sound/soc/intel/boards/built-in.o      sound/soc/intel/boards/skl_rt286.o
sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.o
sound/soc/intel/boards/bytcr_rt5640.o
sound/soc/intel/boards/snd-soc-skl_rt286.o

So these did get built for me

-- 
~Vinod
