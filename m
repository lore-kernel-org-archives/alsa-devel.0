From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: writing an alsa driver
Date: Fri, 19 Jun 2015 13:24:39 +0530
Message-ID: <20150619075439.GI28601@localhost>
References: <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150616205053.GA323@asus> <1434532575.2471.13.camel@loki>
 <20150617213410.GA907@asus> <20150618111451.GH28601@localhost>
 <20150618184739.GA5434@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6FE26053B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 09:53:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150618184739.GA5434@asus>
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

On Thu, Jun 18, 2015 at 08:47:40PM +0200, Michele Curti wrote:
> On Thu, Jun 18, 2015 at 04:44:51PM +0530, Vinod Koul wrote:
> > On Wed, Jun 17, 2015 at 11:34:10PM +0200, Michele Curti wrote:
> > > On Wed, Jun 17, 2015 at 10:16:15AM +0100, Liam Girdwood wrote:
> > > > On Tue, 2015-06-16 at 22:50 +0200, Michele Curti wrote:
> > > > > A note, without enabling the config option SND_SOC_INTEL_SST the driver
> > > > > will not compile/install but it seems strange because when doing a 
> > > > > menuconfig the machine driver option is available even if the 
> > > > > SND_SOC_INTEL_SST option is not selcted (I copied the Kconfig part 
> > > > > from the SND_SOC_INTEL_BYTCR_RT5640_MACH one).
> > Only selecting the SND_SOC_INTEL_BYTCR_RT5640_MACH should do, rest is auto
> > selected
> > 
> > > > 
> > > > Is the BYTCR_RT5640 building for you ? This driver family uses the
> > > > SND_SST_MFLD_PLATFORM instead of the SND_SOC_INTEL_SST platform.
> > > 
> > > Mmmh.. indeed no.. I tried with a clean linux-next, doing a make clean and
> > > selecting the SND_SOC_INTEL_BYTCR_RT5640_MACH option using menuconfig:
> > > 
> > > [zio@asus linux-next]$ grep BYTCR_RT5640 .config
> > > CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> > > [zio@asus linux-next]$ grep SND_SST_MFLD_PLATFORM .config
> > > CONFIG_SND_SST_MFLD_PLATFORM=m
> > > [zio@asus linux-next]$ 
> > > 
> > > But when I do a make the driver don't compile
> > > 
> > > [zio@asus linux-next]$ ls sound/soc/intel/boards/*.o
> > > ls: cannot access sound/soc/intel/boards/*.o: No such file or directory
> > > 
> > > And when I do a make install the only (sound) installed modules are
> > > 
> > >   INSTALL sound/core/snd-compress.ko
> > >   INSTALL sound/core/snd-pcm.ko
> > >   INSTALL sound/core/snd-timer.ko
> > >   INSTALL sound/core/snd.ko
> > >   INSTALL sound/soc/codecs/snd-soc-rl6231.ko
> > >   INSTALL sound/soc/codecs/snd-soc-rt5640.ko
> > >   INSTALL sound/soc/intel/atom/snd-soc-sst-mfld-platform.ko
> > >   INSTALL sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko
> > >   INSTALL sound/soc/intel/atom/sst/snd-intel-sst-core.ko
> > >   INSTALL sound/soc/snd-soc-core.ko
> > >   INSTALL sound/soundcore.ko
> > >   DEPMOD  4.1.0-rc8-next-20150617-asus
> > I am using Marks next
> > 
> > $ grep BYTCR_RT5640 .config
> > CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> > $ grep SND_SST_MFLD_PLATFORM .config
> > CONFIG_SND_SST_MFLD_PLATFORM=m
> > $ ls sound/soc/intel/boards/*.o
> > sound/soc/intel/boards/built-in.o      sound/soc/intel/boards/skl_rt286.o
> > sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.o
> > sound/soc/intel/boards/bytcr_rt5640.o
> > sound/soc/intel/boards/snd-soc-skl_rt286.o
> > 
> > So these did get built for me
> > 
> 
> Mh, maybe the CONFIG_SND_SOC_INTEL_SST is selected?
> 
> I'm looking at the sound/soc/intel/Makefile content:
> 
> # Core support
> obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
> 
> # Platform Support
> obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
> obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
> obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
> 
> # Machine support
> obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
> 
> Does this last line mean that nothing under the 'boards' folder will 
> compile if the CONFIG_SND_SOC_INTEL_SST option is not enabled?
> 
> Tried to replace the line with
> obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += boards/
> and the machine driver builds and installs
> 
> I'll try to add a CONFIG_SND_SOC_INTEL_BOARDS selected by both
> CONFIG_SND_SOC_INTEL_SST and CONFIG_SND_SST_MFLD_PLATFORM :)
Yes you are right, that does cause the issue, we need to get the board to
get included, so I am able to reproduce this.

Also I saw you patch, I dont this we need to add a new symbol as boards is
the one where one should select the machine and allow other symbold to be
auto selected, so better to do this

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 3853ec2ddbc7..6de5d5cd3280 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/

 # Machine support
-obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
+obj-$(CONFIG_SND_SOC) += boards/

With thhis machine compiles, can you please verify at your end. Also I think
we should remove the prompt for SND_SOC_INTEL_SST, this should be selected
by respective driver

I will send patches to fix all these

Thanks for reporting

-- 
~Vinod
