From: Eric Nelson <eric@nelint.com>
Subject: Re: [PATCH 0/6] ASoC: sgtl5000: fix use of regulators and internal
 LDO
Date: Tue, 7 Jun 2016 12:49:23 +0200
Message-ID: <5756A6B3.3030601@nelint.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for taking this up Clemens.

On 06/07/2016 01:14 AM, Clemens Gruber wrote:
> This patch set addresses a structural problem in the handling of
> regulators for VDDIO, VDDA, and VDDD in the SGTL5000 driver.
> 
> The first two of these power rails must be powered on prior to any I2C
> communication, and yet the regulators were tied to the codec, which is
> instantiated only after a fair amount of I2C communication takes place.
> 
> In other words, these regulators could never have function, and we can
> surmise that no user of this driver has switched power supply rails
> connected to them.
> 
> The third power rail (VDDD) can be derived internally (by using I2C
> registers) though the data sheet says that if an external VDDD is used,
> it should be enabled before MCLK is started and I2C activity begins.
> 
> [I rebased Eric's patches from Feb 2015, fixed a few warnings, URLs,
>  etc. and squashed two patches into one. - Clemens]
> 

Thanks also for fixing up my e-mail address (since I'm no longer at
Boundary Devices).

> Clemens Gruber (1):
>   ASoC: sgtl5000: Remove misleading comment
> 
> Eric Nelson (5):
>   ASoC: sgtl5000: Fix regulator support
>   ASoC: sgtl5000: Write all default registers
>   ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults
>   ASoC: sgtl5000: Disable internal PLL early
>   ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF
> 
>  sound/soc/codecs/sgtl5000.c | 421 +++++++++++---------------------------------
>  sound/soc/codecs/sgtl5000.h |   2 +
>  2 files changed, 102 insertions(+), 321 deletions(-)
> 
