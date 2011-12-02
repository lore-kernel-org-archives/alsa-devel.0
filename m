From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 2/3] sound/soc/lapis: add machine driver
Date: Fri, 2 Dec 2011 21:09:34 +0900
Message-ID: <CANKRQng5OzqjiQ81OUH+2Aet8DAM198s6B=_1FuASnd19BU26w@mail.gmail.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-2-git-send-email-tomoya.rohm@gmail.com>
	<20111121113433.GD3784@opensource.wolfsonmicro.com>
	<CANKRQnjdS1NvcGLa=S1M0D4U_NV3+JR1E4YfAV7Ziq-fE2LQgg@mail.gmail.com>
	<20111202114638.GI8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111202114638.GI8245@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Dec 02, 2011 at 02:33:59PM +0900, Tomoya MORINAGA wrote:
>> 2011/11/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> > This needs to come after you add the base platform support in the series
>> > - clearly this won't work without the CPU side drivers it depends on.
>
>> Most of the chipset drivers for Intel Atom E6xx series have already
>> accepted by upstream.
>> e.g. i2c-eg20t, pch_dma, pch_uart, spi-topcliff-pch, ml-ioh-gpio, etc...
>
> The CPU side audio drivers are not there - there seemed to be some quite
> serious review issues with those.
>
Let me clarify your saying.
Does the above "audio drivers" mean i2s (of south bridge) driver or HD
audio (of north bridge) or another?

Thanks,
tomoya
