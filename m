Return-Path: <SRS0=nSv5=DG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C698C4727F
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:50:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE93204FD
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bfSVYckI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE93204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 079C7182F;
	Tue, 29 Sep 2020 13:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 079C7182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601380244;
	bh=0yLiKtALD3+hfjTLhvgyWSJ5oZETOCrRraULYa/KOcU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfSVYckI/XsHbnMREhdWwF54VqvcUSp3ExprocHd7G8KuYrF2T0//R3m9dIdzsFmR
	 PJ96FiOUYInJ+eRSazhWhRShRuMnR7DWfloaT8tiJw37SYC5tmcZtwo2op+9S/oLC0
	 ILR257j43L7B0XrNdf9VOKFu7ChJgWlk+pxKGng4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F728F801DB;
	Tue, 29 Sep 2020 13:49:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BBBAF801F5; Tue, 29 Sep 2020 13:49:51 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45887F80115
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 13:49:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45887F80115
IronPort-SDR: zvWkeDzlY/MdQzwfi7F7WYYyPawoB6F9Q8tpNyza+OnL9HWqBdFZ/0xoH0s3hAqoqukuGWDO9G
 vkkLZKviUwXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141574214"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; d="scan'208";a="141574214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 04:49:37 -0700
IronPort-SDR: Hb4xYR01RWJkC6GjogVVdtap68yn68gedfwyPRSny7jzqrJdzGkdwaHlWfYEfO/11k69ObQZds
 V0D+c0KaMiSw==
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; d="scan'208";a="490468249"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.249.141.65])
 ([10.249.141.65])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 04:49:33 -0700
Subject: Re: [PATCH v9 14/14] ASoC: Intel: Select catpt and deprecate haswell
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200926085910.21948-1-cezary.rojewski@intel.com>
 <20200926085910.21948-15-cezary.rojewski@intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <5a765891-c84e-4475-5b91-7fdfc265c5d5@linux.intel.com>
Date: Tue, 29 Sep 2020 13:49:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926085910.21948-15-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: krzysztof.hejmowski@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, gregkh@linuxfoundation.org, ppapierkowski@habana.ai,
 marcin.barlik@intel.com, zwisler@google.com,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, broonie@kernel.org, michal.wasko@intel.com,
 tiwai@suse.com, andriy.shevchenko@linux.intel.com, cujomalainey@chromium.org,
 vamshi.krishna.gopal@intel.com
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

On 9/26/2020 10:59 AM, Cezary Rojewski wrote:
> Prevent sound/soc/intel/haswell code compile and select catpt instead as
> a recommended solution. Userspace-exposed members are compatible with
> what is exposed by deprecated solution thus no harm is done. The only
> visible difference is the newly added 'Loopback Mute' kcontrol.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
> 
> Changes in v7:
> - patch: 10/14 'ASoC: Intel: Select catpt and deprecate haswell' has
>    been moved to the back of the list: enable catpt after machine boards
>    have been prepared for it first
> 
> Changes in v5:
> - remove DMADEVICES depends on: DW_DMAC_CORE already covers that
> - add optional COMPILE_TEST depends on
> 
>   sound/soc/intel/Kconfig        | 24 ++++++++++++------------
>   sound/soc/intel/Makefile       |  2 +-
>   sound/soc/intel/boards/Kconfig |  8 ++++----
>   sound/soc/intel/catpt/Makefile |  6 ++++++
>   4 files changed, 23 insertions(+), 17 deletions(-)
>   create mode 100644 sound/soc/intel/catpt/Makefile
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 0e48c4f532ce..dfc20f2bb859 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -47,21 +47,21 @@ config SND_SOC_INTEL_SST_FIRMWARE
>   	# Haswell/Broadwell/Baytrail legacy and will be set
>   	# when these platforms are enabled
>   
> -config SND_SOC_INTEL_HASWELL
> -	tristate "Haswell/Broadwell Platforms"
> +config SND_SOC_INTEL_CATPT
> +	tristate "Haswell and Broadwell"
> +	depends on ACPI || COMPILE_TEST

We may want to limit building only to x86 platforms here.

>   	depends on SND_DMA_SGBUF
> -	depends on DMADEVICES && ACPI
> -	select SND_SOC_INTEL_SST
> -	select SND_SOC_INTEL_SST_ACPI
> -	select SND_SOC_INTEL_SST_FIRMWARE
> +	select DW_DMAC_CORE
>   	select SND_SOC_ACPI_INTEL_MATCH
>   	help

(...)
