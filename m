From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/7] WM8580 updates
Date: Sat, 14 Aug 2010 11:45:46 +0100
Message-ID: <1281782746.3394.117.camel@odin>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A321124484
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 12:45:49 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3659877wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 03:45:49 -0700 (PDT)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-13 at 20:33 +0100, Mark Brown wrote:
> This batch of patches should get the sample ratio selection for the
> WM8580 based on the configured sysclk correct, and also fixes a few
> random other things.
> 
> The configuration of the ADC clocking (which is slaved to the DAC
> clocking) is still not ideal - userspace has to configure playback at
> the sample rate to be used prior to starting a record - but this needs
> some more thought at the framework level since this is essentially the
> same problem we have when multiple DAIs run over one physical interface
> using TDM.  Ideally we'd solve the more general problem.
> 
> Mark Brown (7):
>       ASoC: Add a bit of resource unwinding in the S3C IISv4 driver
>       ASoC: Convert WM8580 hw_params to use snd_soc_update_bits()
>       ASoC: Remove unused rate selection bitmasks from WM8580
>       ASoC: Automatically calculate clock ratio for WM8580
>       ASoC: Implement BCLK rate selection for WM8580
>       ASoC: Fix inverted WM8580 capture mute control
>       ASoC: Automatically manage WM8580 DAC OSR
> 
>  sound/soc/codecs/wm8580.c           |  144 +++++++++++++++++++++++++---------
>  sound/soc/codecs/wm8580.h           |   14 ++--
>  sound/soc/s3c24xx/s3c64xx-i2s-v4.c  |   11 +++
>  sound/soc/s3c24xx/smdk64xx_wm8580.c |    9 +-
>  4 files changed, 128 insertions(+), 50 deletions(-)

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
