From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [alsa-devel] [RFC PATCH v2 1/5] ASoC: Mediatek: Refine mt8173
 driver
Date: Thu, 14 Apr 2016 20:44:53 +0800
Message-ID: <1460637893.13240.24.camel@mtksdaap41>
References: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
	 <1460636070-37426-2-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460636070-37426-2-git-send-email-garlic.tseng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: broonie@kernel.org, tiwai@suse.de, alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2016-04-14 at 20:14 +0800, Garlic Tseng wrote:
> Move mt8173 driver to another folder.
> 
> The software control sequence of mt2701 is very different from that of mt8173,
> so this patch moves mt8173 code to another folder.
> 
> 
> Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
> ---
>  sound/soc/mediatek/Makefile                            | 12 +++++-------
>  sound/soc/mediatek/mt8173/Makefile                     |  7 +++++++
>  sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c      |  2 +-
>  sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c |  2 +-
>  sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c |  4 ++--
>  sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c        |  2 +-
>  sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h       |  0
>  sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c          |  0
>  8 files changed, 17 insertions(+), 12 deletions(-)
>  create mode 100644 sound/soc/mediatek/mt8173/Makefile
>  rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
>  rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
>  rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
>  rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
>  rename sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h (100%)
>  rename sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c (100%)
> 
> diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
> index d486860..5048165 100644
> --- a/sound/soc/mediatek/Makefile
> +++ b/sound/soc/mediatek/Makefile
> @@ -1,7 +1,5 @@
> -# MTK Platform Support
> -obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
> -# Machine support
> -obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
> -obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
> -obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173-rt5650-rt5514.o
> -obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
> +# 8173 Machine support
> +obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173/
> +obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173/
> +obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173/
> +obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173/

Since all CONFIG_SND_SOC_MT8173_* depends on CONFIG_SND_SOC_MEDIATEK,
you could just do:

obj-$(CONFIG_SND_SOC_MEDIATEK) += mt8173/


This way we don't need to modify 2 makefiles when adding new ASoC
driver.


> diff --git a/sound/soc/mediatek/mt8173/Makefile b/sound/soc/mediatek/mt8173/Makefile
> new file mode 100644
> index 0000000..d486860
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8173/Makefile
> @@ -0,0 +1,7 @@
> +# MTK Platform Support
> +obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o

Maybe we should also rename this to mt8173-afe-pcm.o?

Joe.C
