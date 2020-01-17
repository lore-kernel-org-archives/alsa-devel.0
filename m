Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7AEC33C9E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:12:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B234720728
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OW0dQXzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3A7F17D3;
	Fri, 17 Jan 2020 20:11:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3A7F17D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579288320;
	bh=9tzMWt62d6sCxWyLNEgs7BYINNRTM7LEG2dSEw0sT5E=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OW0dQXzV6t56B2WZZJzBMcq00UoGOCJ6dXyKQdbkVL324v8fsOGI3degEkMyoDjbP
	 ZGTdGcOozROgQ5POmNU9JgC2EdiILlKaqovp/bVpW5Khzfvq+urdV6YySlXipjtjwK
	 Y/WFpINWmymaDEhbVay8S7NdpoLE1oUNXaLm0UUU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47FB0F8014B;
	Fri, 17 Jan 2020 20:11:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BCC7F801EB; Fri, 17 Jan 2020 20:11:06 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1BDAF800AA
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 20:11:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1BDAF800AA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 11:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; d="scan'208";a="263269243"
Received: from rakeshmi-mobl.gar.corp.intel.com (HELO [10.252.131.157])
 ([10.252.131.157])
 by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2020 11:10:56 -0800
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
 linux-kernel@vger.kernel.org
References: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
 <20200117175626.56358-7-andriy.shevchenko@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c92e0395-0a08-a400-eb48-0aa05e52cf30@linux.intel.com>
Date: Fri, 17 Jan 2020 13:10:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117175626.56358-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v1 7/8] ASoC: Intel: Switch DMI table match
 to a test of variable
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/17/20 11:56 AM, Andy Shevchenko wrote:
> Since we have a common x86 quirk that provides an exported variable,
> use it instead of local DMI table match.
> 
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   .../intel/common/soc-acpi-intel-cht-match.c   | 28 ++-----------------
>   1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> index d0fb43c2b9f6..833d2e130e6e 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> @@ -5,31 +5,11 @@
>    * Copyright (c) 2017, Intel Corporation.
>    */
>   
> -#include <linux/dmi.h>
> +#include <linux/platform_data/x86/machine.h>
> +
>   #include <sound/soc-acpi.h>
>   #include <sound/soc-acpi-intel-match.h>
>   
> -static unsigned long cht_machine_id;
> -
> -#define CHT_SURFACE_MACH 1
> -
> -static int cht_surface_quirk_cb(const struct dmi_system_id *id)
> -{
> -	cht_machine_id = CHT_SURFACE_MACH;
> -	return 1;
> -}
> -
> -static const struct dmi_system_id cht_table[] = {
> -	{
> -		.callback = cht_surface_quirk_cb,
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
> -		},
> -	},
> -	{ }
> -};
> -
>   static struct snd_soc_acpi_mach cht_surface_mach = {
>   	.id = "10EC5640",
>   	.drv_name = "cht-bsw-rt5645",
> @@ -43,9 +23,7 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
>   {
>   	struct snd_soc_acpi_mach *mach = arg;
>   
> -	dmi_check_system(cht_table);
> -
> -	if (cht_machine_id == CHT_SURFACE_MACH)
> +	if (x86_microsoft_surface_3_machine)
>   		return &cht_surface_mach;
>   	else
>   		return mach;
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
