Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADDC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 20:29:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE41B22CF6
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 20:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE41B22CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B91F1729;
	Mon, 11 Jan 2021 21:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B91F1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610396991;
	bh=/UPbUNU8WPdgjrPsMWuYGzfIMgl/Zq6kyj/wFYULlTY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WI7Yeo1FDqIWbL/eFg+NDPZivM5o84O3QJzZmid0ohxiRJEl7Syq2g2JV27nwHvz2
	 wTZ4hVdxp10wAt6I1Ngu1I/D8cwB50/kJppDQBJnORJEt6yuFPYPZhW0SccxWMqMoB
	 EHfbowbHt4ToOQC83v0GlbWtavDsNR72Xqm4FqGk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2826F8025F;
	Mon, 11 Jan 2021 21:29:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F270F80290; Mon, 11 Jan 2021 21:28:53 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44106F80113
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 21:28:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44106F80113
IronPort-SDR: G5X+o3/Cm1v2rDaHjrnjuBA2fXx9BCJax0qdsdhQ1p7v0jh07TT3NXp3vQH3f7NuhItL0yiZD7
 nnbj2rejFazA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="262712508"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="262712508"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 12:28:37 -0800
IronPort-SDR: 7Lmv4jpP+QuEafbuouAL4jOSz3kIZVScDA8uz+WZCQOjEsYkHs4kPTvy+63kmXbu6sGVUjS2+o
 Nw+oosBYKUFg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="344995375"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85])
 ([10.212.87.85])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 12:28:33 -0800
Subject: Re: [PATCH 12/14] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
To: Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee.jones@linaro.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-13-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <92934cb4-0b68-bdcc-d63b-d20628bc3c94@linux.intel.com>
Date: Mon, 11 Jan 2021 11:52:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201227211232.117801-13-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 12/27/20 3:12 PM, Hans de Goede wrote:
> Some Bay Trail systems:
> 1. Use a non CR version of the Bay Trail SoC
> 2. Contain at least 6 interrupt resources so that the
>     platform_get_resource(pdev, IORESOURCE_IRQ, 5) check to workaround
>     non CR systems which list their IPC IRQ at index 0 despite being
>     non CR does not work
> 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
> 
> Add a DMI quirk table to check for the few known models with this issue,
> so that the right IPC IRQ index is used on these systems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Hans!

> ---
>   sound/soc/intel/common/soc-intel-quirks.h | 25 +++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
> index b07df3059926..a93987ab7f4d 100644
> --- a/sound/soc/intel/common/soc-intel-quirks.h
> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> @@ -11,6 +11,7 @@
>   
>   #if IS_ENABLED(CONFIG_X86)
>   
> +#include <linux/dmi.h>
>   #include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
>   #include <asm/iosf_mbi.h>
> @@ -38,12 +39,36 @@ SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
>   
>   static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
>   {
> +	/*
> +	 * List of systems which:
> +	 * 1. Use a non CR version of the Bay Trail SoC
> +	 * 2. Contain at least 6 interrupt resources so that the
> +	 *    platform_get_resource(pdev, IORESOURCE_IRQ, 5) check below
> +	 *    succeeds
> +	 * 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
> +	 *
> +	 * This needs to be here so that it can be shared between the SST and
> +	 * SOF drivers. We rely on the compiler to optimize this out in files
> +	 * where soc_intel_is_byt_cr is not used.
> +	 */
> +	static const struct dmi_system_id force_bytcr_table[] = {
> +		{	/* Lenovo Yoga Tablet 2 series */
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +				DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
> +			},
> +		},
> +		{}
> +	};
>   	struct device *dev = &pdev->dev;
>   	int status = 0;
>   
>   	if (!soc_intel_is_byt())
>   		return false;
>   
> +	if (dmi_check_system(force_bytcr_table))
> +		return true;
> +
>   	if (iosf_mbi_available()) {
>   		u32 bios_status;
>   
> 
