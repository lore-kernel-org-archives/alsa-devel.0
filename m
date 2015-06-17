From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Wed, 17 Jun 2015 23:34:10 +0200
Message-ID: <20150617213410.GA907@asus>
References: <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150616205053.GA323@asus> <1434532575.2471.13.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 09A352604E2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 23:34:15 +0200 (CEST)
Received: by wicnd19 with SMTP id nd19so4546345wic.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 14:34:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434532575.2471.13.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Koul, Vinod" <vinod.koul@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 17, 2015 at 10:16:15AM +0100, Liam Girdwood wrote:
> On Tue, 2015-06-16 at 22:50 +0200, Michele Curti wrote:
> > On Mon, Jun 15, 2015 at 06:04:28PM +0100, Liam Girdwood wrote:
> > > 
> > > We are also a little suspicious that this laptop is using SSP1 for the
> > > I2S audio connection to the codec. The bad news is that the FW used by
> > > this BYT ADSP driver does not support the SSP1 port. It's hard coded to
> > > use SSP0 (Jarrko, please correct the port numbering if it's wrong).
> > > There are going to be no further releases of this FW.
> > > 
> > > However, the other upstream BYT ADSP driver from Vinod's team is going
> > > to support the other SSP ports. It currently only supports SSP0, but I
> > > believe that a new FW will be released soon that will support SSP1.
> > > Vinod do you know the new FW release date ?
> > > 
> > > Michele, can you change your machine driver to use the Vinods BYT DSP
> > > PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> > > the current FW release from Vinod too. That way you should be ready to
> > > integrate the new FW when it is released. Please also CC Vinod on any
> > > issues you have getting the FW to boot using the new driver/FW.
> > >
> > 
> > Sure!
> > 
> > A note, without enabling the config option SND_SOC_INTEL_SST the driver
> > will not compile/install but it seems strange because when doing a 
> > menuconfig the machine driver option is available even if the 
> > SND_SOC_INTEL_SST option is not selcted (I copied the Kconfig part 
> > from the SND_SOC_INTEL_BYTCR_RT5640_MACH one).
> 
> Is the BYTCR_RT5640 building for you ? This driver family uses the
> SND_SST_MFLD_PLATFORM instead of the SND_SOC_INTEL_SST platform.

Mmmh.. indeed no.. I tried with a clean linux-next, doing a make clean and
selecting the SND_SOC_INTEL_BYTCR_RT5640_MACH option using menuconfig:

[zio@asus linux-next]$ grep BYTCR_RT5640 .config
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
[zio@asus linux-next]$ grep SND_SST_MFLD_PLATFORM .config
CONFIG_SND_SST_MFLD_PLATFORM=m
[zio@asus linux-next]$ 

But when I do a make the driver don't compile

[zio@asus linux-next]$ ls sound/soc/intel/boards/*.o
ls: cannot access sound/soc/intel/boards/*.o: No such file or directory

And when I do a make install the only (sound) installed modules are

  INSTALL sound/core/snd-compress.ko
  INSTALL sound/core/snd-pcm.ko
  INSTALL sound/core/snd-timer.ko
  INSTALL sound/core/snd.ko
  INSTALL sound/soc/codecs/snd-soc-rl6231.ko
  INSTALL sound/soc/codecs/snd-soc-rt5640.ko
  INSTALL sound/soc/intel/atom/snd-soc-sst-mfld-platform.ko
  INSTALL sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko
  INSTALL sound/soc/intel/atom/sst/snd-intel-sst-core.ko
  INSTALL sound/soc/snd-soc-core.ko
  INSTALL sound/soundcore.ko
  DEPMOD  4.1.0-rc8-next-20150617-asus

> 
> > 
> > So I think I'm missing something...  The two "upstream BYT ADSP drivers"
> > are mutually exclusive?  I see mixed outputs like
> > [    2.209494] sst-acpi 80860F28:00: No matching ASoC machine driver found
> > followed by output of the machine driver that tries to bind cpu and codec 
> > dais..
> 
> Yes, both BYT ADSP driver are mutually exclusive. They both work with
> the same HW but target different FW ABIs and capabilities.
>

Ok, thanks!

So now I'll disable the SND_SOC_INTEL_SST option and will try to get the
machine driver compile and install ;)

Michele
