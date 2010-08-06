From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix inverted mute controls for WM8580
Date: Fri, 06 Aug 2010 18:46:06 +0100
Message-ID: <1281116766.3077.87.camel@odin>
References: <1281115309-25070-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BCBB910395E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:46:07 +0200 (CEST)
Received: by wwb17 with SMTP id 17so5083792wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 10:46:07 -0700 (PDT)
In-Reply-To: <1281115309-25070-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, stable@kernel.org, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-06 at 18:21 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: stable@kernel.org
> ---
>  sound/soc/codecs/wm8580.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> This one really ought to get pushed for 2.6.36.
> 
> diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
> index c3571ee..72deeab 100644
> --- a/sound/soc/codecs/wm8580.c
> +++ b/sound/soc/codecs/wm8580.c
> @@ -269,9 +269,9 @@ SOC_DOUBLE("DAC2 Invert Switch", WM8580_DAC_CONTROL4,  2, 3, 1, 0),
>  SOC_DOUBLE("DAC3 Invert Switch", WM8580_DAC_CONTROL4,  4, 5, 1, 0),
>  
>  SOC_SINGLE("DAC ZC Switch", WM8580_DAC_CONTROL5, 5, 1, 0),
> -SOC_SINGLE("DAC1 Switch", WM8580_DAC_CONTROL5, 0, 1, 0),
> -SOC_SINGLE("DAC2 Switch", WM8580_DAC_CONTROL5, 1, 1, 0),
> -SOC_SINGLE("DAC3 Switch", WM8580_DAC_CONTROL5, 2, 1, 0),
> +SOC_SINGLE("DAC1 Switch", WM8580_DAC_CONTROL5, 0, 1, 1),
> +SOC_SINGLE("DAC2 Switch", WM8580_DAC_CONTROL5, 1, 1, 1),
> +SOC_SINGLE("DAC3 Switch", WM8580_DAC_CONTROL5, 2, 1, 1),
>  
>  SOC_DOUBLE("ADC Mute Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 0),
>  SOC_SINGLE("ADC High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
