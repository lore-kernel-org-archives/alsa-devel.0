From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix WM8994/58 3D stereo control
	definitions
Date: Tue, 21 Dec 2010 10:20:26 +0000
Message-ID: <1292926826.3296.5.camel@odin>
References: <1292856528-19435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C42010397B
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 11:20:30 +0100 (CET)
Received: by wyi11 with SMTP id 11so3651894wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 02:20:29 -0800 (PST)
In-Reply-To: <1292856528-19435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 14:48 +0000, Mark Brown wrote:
> Cut'n'paste in the register names.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index af104ac..e1a775b 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -869,15 +869,15 @@ SOC_SINGLE_TLV("SPKR DAC1 Volume", WM8994_SPKMIXR_ATTENUATION,
>  
>  SOC_SINGLE_TLV("AIF1DAC1 3D Stereo Volume", WM8994_AIF1_DAC1_FILTERS_2,
>  	       10, 15, 0, wm8994_3d_tlv),
> -SOC_SINGLE("AIF1DAC1 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
> +SOC_SINGLE("AIF1DAC1 3D Stereo Switch", WM8994_AIF1_DAC1_FILTERS_2,
>  	   8, 1, 0),
>  SOC_SINGLE_TLV("AIF1DAC2 3D Stereo Volume", WM8994_AIF1_DAC2_FILTERS_2,
>  	       10, 15, 0, wm8994_3d_tlv),
>  SOC_SINGLE("AIF1DAC2 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
>  	   8, 1, 0),
> -SOC_SINGLE_TLV("AIF2DAC 3D Stereo Volume", WM8994_AIF1_DAC1_FILTERS_2,
> +SOC_SINGLE_TLV("AIF2DAC 3D Stereo Volume", WM8994_AIF2_DAC_FILTERS_2,
>  	       10, 15, 0, wm8994_3d_tlv),
> -SOC_SINGLE("AIF2DAC 3D Stereo Switch", WM8994_AIF1_DAC2_FILTERS_2,
> +SOC_SINGLE("AIF2DAC 3D Stereo Switch", WM8994_AIF2_DAC_FILTERS_2,
>  	   8, 1, 0),
>  };
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
