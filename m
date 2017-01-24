From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
Date: Tue, 24 Jan 2017 11:36:58 +0000
Message-ID: <20170124113658.GW16020@dell>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
 <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <283c0e48-55e2-6516-369d-91dc72d12f73-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jan 2017, Arnaud Pouliquen wrote:
> On 01/24/2017 09:22 AM, Lee Jones wrote:
> > On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:
> > 
> >> DFSDM hardware IP can be used at the same time for ADC sigma delta
> > 
> > Same time as what?
> DFSDM is used for ADC acquisition (through IIO) but also PDM microphone
> capture (through ASOC).
> > 
> >> conversion and audio PDM microphone.
> >> MFD driver is in charge of configuring IP registers and managing IP clocks.
> >> For this it exports an API to handles filters and channels resources.
> > 
> > This looks like an ADC driver?  What is it that makes it an MFD?
> Yes it a kind of ADC but that supports 2 features audio and iio.
> So it has to support 2 features based on 2 separate Frameworks.

I'm still unsure why it needs to live in MFD.

By the looks of it, this driver needs to move into IIO and you need to
call into it from ASoC.

> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
> >> ---
> >>  drivers/mfd/Kconfig             |   11 +
> >>  drivers/mfd/Makefile            |    2 +
> >>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
> >>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
> >>  5 files changed, 1601 insertions(+)
> >>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
> >>  create mode 100644 drivers/mfd/stm32-dfsdm.c
> >>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index c6df644..4bb660b 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -1607,6 +1607,17 @@ config MFD_STW481X
> >>  	  in various ST Microelectronics and ST-Ericsson embedded
> >>  	  Nomadik series.
> >>  
> >> +config MFD_STM32_DFSDM
> >> +	tristate "ST Microelectronics STM32 DFSDM"
> >> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> >> +	select MFD_CORE
> >> +	select REGMAP
> >> +	select REGMAP_MMIO
> >> +	help
> >> +	  Select this option to enable the STM32 Digital Filter
> >> +	  for Sigma Delta Modulators (DFSDM) driver used
> >> +	  in various STM32 series.
> >> +
> >>  menu "Multimedia Capabilities Port drivers"
> >>  	depends on ARCH_SA1100
> > 
> > [...]
> > 
> 
> Regards
> Arnaud

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
