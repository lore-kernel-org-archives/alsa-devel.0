From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Sort ALC5623 in Kconfig and Makefile
Date: Thu, 03 Feb 2011 16:15:30 +0000
Message-ID: <1296749730.3456.123.camel@odin>
References: <1296742110-29827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 50631103AB2
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:15:35 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so1252848wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 08:15:35 -0800 (PST)
In-Reply-To: <1296742110-29827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2011-02-03 at 14:08 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 06894da..46ffb26 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
>  obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
>  obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
>  obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
> +obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
>  obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
>  obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
>  obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
> @@ -103,7 +104,6 @@ obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
>  obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
>  obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
>  obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
> -obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
>  obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
>  obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
>  obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
