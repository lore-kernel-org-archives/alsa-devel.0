From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] ASoC: Implement WM8962 DMIC support
Date: Mon, 25 Apr 2011 12:33:14 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04973BBB5B@HQMAIL01.nvidia.com>
References: <1303758905-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1303758905-5638-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 96A1C24513
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 21:34:25 +0200 (CEST)
In-Reply-To: <1303758905-5638-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Monday, April 25, 2011 1:15 PM:
>...
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2468,6 +2468,7 @@ SND_SOC_DAPM_INPUT("IN3R"),
>  SND_SOC_DAPM_INPUT("IN4L"),
>  SND_SOC_DAPM_INPUT("IN4R"),
>  SND_SOC_DAPM_INPUT("Beep"),
> +SND_SOC_DAPM_INPUT("DMICDAT"),
> 
>  SND_SOC_DAPM_MICBIAS("MICBIAS", WM8962_PWR_MGMT_1, 1, 0),
> 
> @@ -2487,6 +2488,8 @@ SND_SOC_DAPM_MIXER("MIXINL", WM8962_PWR_MGMT_1, 5,
> 0,
>  SND_SOC_DAPM_MIXER("MIXINR", WM8962_PWR_MGMT_1, 4, 0,
>  		   mixinr, ARRAY_SIZE(mixinr)),
> 
> +SND_SOC_DAPM_AIF_IN("DMIC", NULL, 0, WM8962_PWR_MGMT_1, 10, 0),
> +

Mark,

I notice you added both a SND_SOC_DAPM_INPUT and a SND_SOC_DAPM_AIF_IN
for the DMIC path here. Should the WM8903 DMIC patch I provided have
done the same?

Thanks

-- 
nvpublic
