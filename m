From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [BUGFIX PATCH] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Fri, 23 Nov 2012 07:59:56 +0100
Message-ID: <20655.7916.566188.590202@ipc1.ka-ro>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
	<20121123020517.GJ4385@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123020517.GJ4385@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown writes:
> On Thu, Nov 22, 2012 at 01:31:06PM +0100, Lothar Wa=C3=9Fmann wrote:
>=20
> >  obj-$(CONFIG_SND_SOC_IMX_PCM) +=3D snd-soc-imx-pcm.o
> >  snd-soc-imx-pcm-y :=3D imx-pcm.o
> > -snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_FIQ) +=3D imx-pcm-fiq.o
> > -snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_DMA) +=3D imx-pcm-dma.o
> > +ifneq ($(CONFIG_SND_SOC_IMX_PCM_FIQ),)
> > +	snd-soc-imx-pcm-objs +=3D imx-pcm-fiq.o
> > +endif
> > +ifneq ($(CONFIG_SND_SOC_IMX_PCM_DMA),)
> > +	snd-soc-imx-pcm-objs +=3D imx-pcm-dma.o
> > +endif
>=20
> What is the actual bug here?  This fix doesn't look obviously right, =
and
> if we do need to move to -objs for some reason then the block ought t=
o
> be in the -objs section of the Makefile.
>
As I mentioned in the part of my email that you didn't quote, if the
sound driver is being compiled as module, the files imx-pcm-fiq.c or
imx-pcm-dma.c which should be compiled as part of imx-pcm.o will not
be touched by the compiler:
CONFIG_SND_SOC_IMX_PCM=3Dm
CONFIG_SND_SOC_IMX_PCM_DMA=3Dm
CONFIG_SND_SOC_IMX_AUDMUX=3Dm
CONFIG_SND_SOC_IMX_SGTL5000=3Dm
  GEN     /usr/local/src/arm/projects/imx53/Release/rel-next/.build-snd=
-bugfix/Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
#
# configuration written to .config
#
  GEN     /projects/imx53/Release/rel-next/.build-snd-bugfix/Makefile
  CHK     include/generated/uapi/linux/version.h
  Using /usr/local/src/arm/projects/imx53/Release/rel-next/linux-next a=
s source for kernel
  CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /usr/local/src/arm/projects/imx53/Release/rel-next/linux-next=
/scripts/checksyscalls.sh
  LD      sound/core/built-in.o
  CC [M]  sound/core/compress_offload.o
  LD      sound/soc/built-in.o
  CC [M]  sound/soc/soc-core.o
  CC [M]  sound/soc/soc-dapm.o
  CC [M]  sound/soc/soc-jack.o
  CC [M]  sound/core/memalloc.o
  CC [M]  sound/core/pcm.o
  CC [M]  sound/soc/soc-cache.o
  CC [M]  sound/core/pcm_native.o
  CC [M]  sound/core/pcm_lib.o
  CC [M]  sound/soc/soc-utils.o
  CC [M]  sound/core/pcm_timer.o
  CC [M]  sound/soc/soc-pcm.o
  CC [M]  sound/soc/soc-compress.o
  CC [M]  sound/soc/soc-io.o
  CC [M]  sound/soc/soc-dmaengine-pcm.o
  CC [M]  sound/core/pcm_misc.o
  CC [M]  sound/core/pcm_memory.o
  CC [M]  sound/core/timer.o
  LD      sound/soc/codecs/built-in.o
  CC [M]  sound/soc/codecs/sgtl5000.o
  LD      sound/soc/fsl/built-in.o
  CC [M]  sound/soc/fsl/fsl_ssi.o
  CC [M]  sound/soc/fsl/fsl_utils.o
  CC [M]  sound/soc/fsl/imx-audmux.o
  LD [M]  sound/soc/codecs/snd-soc-sgtl5000.o
  CC [M]  sound/soc/fsl/imx-pcm.o
  CC [M]  sound/soc/fsl/imx-sgtl5000.o
  LD [M]  sound/soc/snd-soc-core.o
  LD [M]  sound/core/snd-timer.o
  LD [M]  sound/core/snd-hrtimer.o
  LD [M]  sound/core/snd-pcm.o
  LD [M]  sound/core/snd-page-alloc.o
  LD [M]  sound/core/snd-compress.o
  LD [M]  sound/soc/fsl/snd-soc-fsl-ssi.o
  LD [M]  sound/soc/fsl/snd-soc-fsl-utils.o
  LD [M]  sound/soc/fsl/snd-soc-imx-audmux.o
  LD [M]  sound/soc/fsl/snd-soc-imx-pcm.o
  LD [M]  sound/soc/fsl/snd-soc-imx-sgtl5000.o
  LD      sound/built-in.o


With the following config:
CONFIG_SND_SOC_IMX_PCM=3Dy
CONFIG_SND_SOC_IMX_PCM_DMA=3Dy
CONFIG_SND_SOC_IMX_AUDMUX=3Dy
CONFIG_SND_SOC_IMX_SGTL5000=3Dy
  GEN     /usr/local/src/arm/projects/imx53/Release/rel-next/.build-snd=
-bugfix/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  GEN     /usr/local/src/arm/projects/imx53/Release/rel-next/.build-snd=
-bugfix/Makefile
  CHK     include/generated/uapi/linux/version.h
  Using /usr/local/src/arm/projects/imx53/Release/rel-next/linux-next a=
s source for kernel
  CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /usr/local/src/arm/projects/imx53/Release/rel-next/linux-next=
/scripts/checksyscalls.sh
  CC      sound/soc/soc-core.o
  CC      sound/soc/soc-dapm.o
  CC      sound/soc/soc-jack.o
  CC      sound/soc/soc-cache.o
  CC      sound/soc/soc-utils.o
  CC      sound/soc/soc-pcm.o
  CC      sound/soc/soc-compress.o
  CC      sound/soc/soc-io.o
  CC      sound/soc/soc-dmaengine-pcm.o
  LD      sound/soc/atmel/built-in.o
  LD      sound/soc/au1x/built-in.o
  LD      sound/soc/blackfin/built-in.o
  LD      sound/soc/cirrus/built-in.o
  CC      sound/soc/codecs/sgtl5000.o
  LD      sound/soc/davinci/built-in.o
  LD      sound/soc/dwc/built-in.o
  CC      sound/soc/fsl/fsl_ssi.o
  LD      sound/soc/generic/built-in.o
  LD      sound/soc/jz4740/built-in.o
  LD      sound/soc/kirkwood/built-in.o
  LD      sound/soc/mid-x86/built-in.o
  LD      sound/soc/mxs/built-in.o
  LD      sound/soc/nuc900/built-in.o
  LD      sound/soc/omap/built-in.o
  CC      sound/soc/fsl/fsl_utils.o
  LD      sound/soc/pxa/built-in.o
  LD      sound/soc/s6000/built-in.o
  LD      sound/soc/samsung/built-in.o
  LD      sound/soc/sh/built-in.o
  LD      sound/soc/tegra/built-in.o
  CC      sound/soc/fsl/imx-audmux.o
  LD      sound/soc/txx9/built-in.o
  CC      sound/soc/fsl/imx-pcm.o
  LD      sound/soc/ux500/built-in.o
  CC      sound/soc/fsl/imx-pcm-dma.o
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  LD      sound/soc/codecs/snd-soc-sgtl5000.o
  LD      sound/soc/codecs/built-in.o
  CC      sound/soc/fsl/imx-sgtl5000.o
  LD      sound/soc/snd-soc-core.o
  LD      sound/soc/fsl/snd-soc-fsl-ssi.o
  LD      sound/soc/fsl/snd-soc-fsl-utils.o
  LD      sound/soc/fsl/snd-soc-imx-audmux.o
  LD      sound/soc/fsl/snd-soc-imx-pcm.o
  LD      sound/soc/fsl/snd-soc-imx-sgtl5000.o
  LD      sound/soc/fsl/built-in.o
  LD      sound/soc/built-in.o


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
