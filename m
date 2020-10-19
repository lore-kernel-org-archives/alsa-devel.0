Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C9C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:51:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71446223C6
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i3fW+rUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71446223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4C9B16E1;
	Mon, 19 Oct 2020 20:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4C9B16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603133474;
	bh=Fv/2KK8pnYscd971tKlnsnBu4co57Yvfsez5hUyCQi8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i3fW+rUsdOo3ByeB2UmKaYffEpbEFUnFWBNGkehJC2K4psb6VUZSC5SX7gNJIafV3
	 dwLcL2u2rJHdixR1MtWBGcBHYqw7zi6W7mgc5Q78lm2aoA/tEYMDpp/AJXGTEgbZAz
	 ve9Hmh89LeUfeeefr74eRSG8VMH2giiH0MsEyrqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C79BF8010F;
	Mon, 19 Oct 2020 20:50:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23E5BF80247; Mon, 19 Oct 2020 20:50:22 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AE56F80121
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 20:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AE56F80121
IronPort-SDR: EbtIyrTEQ5fsAaRZLY8BeBK/fBQIHIOpVP47QPxZQAcg1AJWryWwaxD/XMuW+ilXLpHCFC5hrI
 Htlyrf9thHDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="163597878"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="163597878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 11:50:06 -0700
IronPort-SDR: i0qe4ZkIVZch+BW918f3qYvwZYplTcc9xNgAereVl9P1Lpjm+QrQd1l+YgF4J9ZbGUrKO5Jn/F
 nxUqTeyaB8sg==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="358243428"
Received: from mloenko-mobl.amr.corp.intel.com (HELO [10.212.85.115])
 ([10.212.85.115])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 11:50:03 -0700
Subject: Re: [PATCH v2] ASoC: Intel: boards: Add CML_RT1015 m/c driver
To: Keith Tzneg <matsufan@gmail.com>, alsa-devel@alsa-project.org
References: <1603123126-8739-1-git-send-email-keith.tzeng@quantatw.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <aae644dd-0469-3ffc-61f4-7e3396636a93@linux.intel.com>
Date: Mon, 19 Oct 2020 13:50:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603123126-8739-1-git-send-email-keith.tzeng@quantatw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Naveen Manohar <naveen.m@intel.com>, Libin Yang <libin.yang@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Fred Oh <fred.oh@linux.intel.com>,
 linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 10/19/20 10:58 AM, Keith Tzneg wrote:
> From: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>
> 
> Machine driver to enable RT5682 on SSP0, DMIC, HDMI and RT1015 AMP on
> SSP1: Enabled 4 CH TDM playback with 24 bit data.
> 
> Signed-off-by: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>
> ---
>   sound/soc/intel/boards/Kconfig                    |  17 +
>   sound/soc/intel/boards/Makefile                   |   2 +
>   sound/soc/intel/boards/cml_rt1015_rt5682.c        | 570 ++++++++++++++++++++++
>   sound/soc/intel/common/soc-acpi-intel-cnl-match.c |   7 +
>   4 files changed, 596 insertions(+)
>   create mode 100644 sound/soc/intel/boards/cml_rt1015_rt5682.c
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index c10c378..9331d0a 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -496,6 +496,23 @@ config SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH
>   	  Say Y if you have such a device.
>   	  If unsure select "N".
>   
> +config SND_SOC_INTEL_SOF_RT5682_MACH
> +        tristate "SOF with rt5682 codec in I2S Mode"
> +        depends on I2C && ACPI && GPIOLIB
> +        depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
> +                    (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
> +                   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
> +        select SND_SOC_MAX98373_I2C
> +        select SND_SOC_RT1015
> +        select SND_SOC_RT5682_I2C
> +        select SND_SOC_DMIC
> +        select SND_SOC_HDAC_HDMI
> +        help
> +           This adds support for ASoC machine driver for SOF platforms
> +           with rt5682 codec.
> +           Say Y if you have such a device.
> +           If unsure select "N".
> +

This is duplicating an existing config

if SND_SOC_SOF_HDA_LINK || SND_SOC_SOF_BAYTRAIL
config SND_SOC_INTEL_SOF_RT5682_MACH
	tristate "SOF with rt5682 codec in I2S Mode"
	depends on I2C && ACPI && GPIOLIB

What you would need is to add

        select SND_SOC_RT1015

to the existing config, not duplicate it.


>   endif ## SND_SOC_SOF_COMETLAKE && SND_SOC_SOF_HDA_LINK
>   
>   if SND_SOC_SOF_JASPERLAKE
> diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
> index a58e4d2..73131cc 100644
> --- a/sound/soc/intel/boards/Makefile
> +++ b/sound/soc/intel/boards/Makefile
> @@ -20,6 +20,7 @@ snd-soc-sst-byt-cht-es8316-objs := bytcht_es8316.o
>   snd-soc-sst-byt-cht-nocodec-objs := bytcht_nocodec.o
>   snd-soc-sof_rt5682-objs := sof_rt5682.o hda_dsp_common.o sof_maxim_common.o
>   snd-soc-cml_rt1011_rt5682-objs := cml_rt1011_rt5682.o hda_dsp_common.o
> +snd-soc-cml_rt1015_rt5682-objs := cml_rt1015_rt5682.o
>   snd-soc-kbl_da7219_max98357a-objs := kbl_da7219_max98357a.o
>   snd-soc-kbl_da7219_max98927-objs := kbl_da7219_max98927.o
>   snd-soc-kbl_rt5663_max98927-objs := kbl_rt5663_max98927.o
> @@ -60,6 +61,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH) += snd-soc-sst-byt-cht-da7213.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH) += snd-soc-sst-byt-cht-es8316.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH) += snd-soc-sst-byt-cht-nocodec.o
>   obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH) += snd-soc-cml_rt1011_rt5682.o
> +obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1015_RT5682_MACH) += cml_rt1015_rt5682.o

But here you are using a config that was never defined.

And as I said in my previous email, please consider reusing an existing 
machine driver rather than adding a new one just to use rt1011 to rt1015.

>   obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH) += snd-soc-kbl_da7219_max98357a.o
>   obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH) += snd-soc-kbl_da7219_max98927.o
>   obj-$(CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH) += snd-soc-kbl_rt5663_max98927.o
> diff --git a/sound/soc/intel/boards/cml_rt1015_rt5682.c b/sound/soc/intel/boards/cml_rt1015_rt5682.c
> new file mode 100644
> index 0000000..bf18830
> --- /dev/null
> +++ b/sound/soc/intel/boards/cml_rt1015_rt5682.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2019 Intel Corporation.
> +
> +/*
> + * Intel Cometlake I2S Machine driver for RT1015 + RT5682 codec
> + */
> +
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/dmi.h>
> +#include <linux/slab.h>
> +#include <asm/cpu_device_id.h>
> +#include <linux/acpi.h>
> +#include <sound/core.h>
> +#include <sound/jack.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/rt5682.h>
> +#include <sound/soc-acpi.h>
> +#include "../../codecs/rt1015.h"
> +#include "../../codecs/rt5682.h"
> +#include "../../codecs/hdac_hdmi.h"
> +
> +/* The platform clock outputs 24Mhz clock to codec as I2S MCLK */
> +#define CML_PLAT_CLK	24000000
> +#define CML_RT1015_CODEC_DAI "rt1015-aif"
> +#define CML_RT5682_CODEC_DAI "rt5682-aif1"
> +#define NAME_SIZE 32
> +
> +#define SOF_RT1015_SPEAKER_WL		BIT(0)
> +#define SOF_RT1015_SPEAKER_WR		BIT(1)
> +#define SOF_RT1015_SPEAKER_TL		BIT(2)
> +#define SOF_RT1015_SPEAKER_TR		BIT(3)
> +#define SPK_CH 4
> +
> +/* Default: Woofer speakers  */
> +static unsigned long sof_rt1015_quirk = SOF_RT1015_SPEAKER_WL |
> +					SOF_RT1015_SPEAKER_WR;
> +
> +static int sof_rt1015_quirk_cb(const struct dmi_system_id *id)
> +{
> +	sof_rt1015_quirk = (unsigned long)id->driver_data;
> +	return 1;
> +}
> +
> +static const struct dmi_system_id sof_rt1015_quirk_table[] = {
> +	{
> +		.callback = sof_rt1015_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Helios"),
> +	},
> +		.driver_data = (void *)(SOF_RT1015_SPEAKER_WL | SOF_RT1015_SPEAKER_WR |
> +					SOF_RT1015_SPEAKER_TL | SOF_RT1015_SPEAKER_TR),
> +	},
> +	{
> +	}
> +};

in cml_rt1011_rt5682.c, we already have:

static const struct dmi_system_id sof_rt1011_quirk_table[] = {
	{
		.callback = sof_rt1011_quirk_cb,
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
			DMI_MATCH(DMI_PRODUCT_NAME, "Helios"),
	},
		.driver_data = (void *)(SOF_RT1011_SPEAKER_WL | SOF_RT1011_SPEAKER_WR |
					SOF_RT1011_SPEAKER_TL | SOF_RT1011_SPEAKER_TR),
	},
	{
	}
};

Can someone explain how the same "Helios" product can have DMI identical 
quirks pointing to different amplifiers? this really begs the question 
on what PRODUCT_NAME means. I would expect DMI quirks to be unique, not 
match in different drivers as suggested.

NAK on this version. Please don't copy-paste like this.


