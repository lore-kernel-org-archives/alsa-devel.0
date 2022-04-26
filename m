Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2588FC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 13:35:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BE46183A;
	Tue, 26 Apr 2022 15:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BE46183A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650980103;
	bh=HJ4uZcmxmhMMhRnHLxuWOeJmcpkNRgvlD5pZbxSxoTs=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cUGblp1KL8eRqWGPyD2OsedzYbOBojQ1I/5HNKhromRdgcynqiBe/MARfLuK8hBqN
	 ZBOvJDty14W7etRwruvQL9MxbcvM7SY3ugQRQolXS7lRbHcsp1kgLWNTqv6nmhRBGQ
	 xoDLBzl3qdjTC4c3CpldFEDaYsir/8IFwZKfv86w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8760F8014B;
	Tue, 26 Apr 2022 15:34:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FD83F80152; Tue, 26 Apr 2022 15:34:11 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82677F800FA
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 15:34:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82677F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="DkKL6HFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650980045; x=1682516045;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HJ4uZcmxmhMMhRnHLxuWOeJmcpkNRgvlD5pZbxSxoTs=;
 b=DkKL6HFCJKR8pRvrvRiLMf2HnKoSRWmHMXNTb1L0thowPJgZbp9aaAmj
 oW+4bWN0prBTuT/L7rdKQf3Pd4320OCU5FjiYBKJbM8qHtGZwfCFfjVPE
 erKQB81e5mPV14BQt6wG3lsI/IGGqhoFe2km/+V4B9z6FAa+dj0YcAll6
 D/9KB/WO+0MLfq4S0FIrZl8D3xakDQUOqW3Hml2qtq2IMYDQ2K+nclric
 Y37PpiPxpxfLiy/pFqsL5EvQ92mwj8pNkZh6ihlLPh2SZWNggcPPmlWUG
 izgC28Cn5ShoA3ik0porbXb3YXnt6TSFG6rvB7MgkuPI2a2w4QFlle/HC Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="263171175"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="263171175"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 06:33:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="807517742"
Received: from asimchuk-mobl2.amr.corp.intel.com (HELO [10.212.150.79])
 ([10.212.150.79])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 06:33:58 -0700
Message-ID: <eab567f0-73a4-bf23-76bf-8d576fa942f0@linux.intel.com>
Date: Tue, 26 Apr 2022 08:33:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: Intel: avs: Depend on CONFIG_ACPI
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
References: <20220426115454.685787-1-amadeuszx.slawinski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220426115454.685787-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: kernel test robot <lkp@intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
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



On 4/26/22 06:54, Amadeusz Sławiński wrote:
> Apparently the assumption that driver can build without ACPI was too
> optimistic as avs selects SND_SOC_ACPI which requires working ACPI
> implementation. So depend on ACPI without COMPILE_TEST alternative.
> 
> Fixes: 47a1886a610a ("ASoC: Intel: avs: Enable AVS driver only on x86 platforms")
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/intel/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index be42c4eff165..9fdd6e32951f 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -211,8 +211,8 @@ config SND_SOC_INTEL_KEEMBAY
>  
>  config SND_SOC_INTEL_AVS
>  	tristate "Intel AVS driver"
> -	depends on (X86 && ACPI) || COMPILE_TEST
> -	depends on PCI
> +	depends on X86 || COMPILE_TEST
> +	depends on PCI && ACPI
>  	depends on COMMON_CLK
>  	select SND_SOC_ACPI

select SND_SOC_ACPI if ACPI should work, that's what we do for SOF.

>  	select SND_SOC_TOPOLOGY
