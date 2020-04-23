Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B95C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:12:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4A12084D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G1veTdvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4A12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87A2C168E;
	Thu, 23 Apr 2020 11:11:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87A2C168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587633133;
	bh=ft+mTiwHPIIOSKprCpEn+qdTCsV5WyBeHbX70a3WpEA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G1veTdvk7TCZpELh8+iW52d5Nkx0QLQqCrjCknksEHiV0xstZacP7zbULtsufo3Cr
	 bvGfsjm9BB0oWnMgysR+2IWyZC1jnJsld6A3EmV80Jl1/CTXCAAhVYulZqo3DdtmuB
	 HieDPOFoh2Zml+9fruiYbUuS73RKXbk+Bwf4pz9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10E66F8014A;
	Thu, 23 Apr 2020 11:11:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1FCFF801EC; Thu, 23 Apr 2020 11:11:19 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 322A4F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 11:11:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 322A4F800FF
IronPort-SDR: 9xdBWmNkz+n4W+XyEfSOzLXHIE1xhs46h/mKzzlqatk1MlWon9PqRcJkS34dxyTE4kcf+DrHY9
 oBe8BTBlGAaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 02:11:09 -0700
IronPort-SDR: 18mcOKN2qT1HRKtURVaJqX7Qtl/VcJXXaidFeuM1Pid/M+6ND3v0BW0Edvsgt2Df/gXuZJyB4R
 B2d1iC+o5/gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="456837451"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.5.100])
 ([10.213.5.100])
 by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 02:11:06 -0700
Subject: Re: [PATCH v2 0/3] Add support for different DMIC configurations
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <89873366-c063-5754-0e18-511477c3daa5@intel.com>
Date: Thu, 23 Apr 2020 11:11:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, tiwai@suse.com
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

On 2020-04-22 14:05, Mateusz Gorski wrote:
> Set of patches to enable DMIC capture on different hardware
> configurations.
> Information about supported DMIC configuration is read from NHLT and
> correct pipeline configuration is selected automatically.
> Also, adding additional option for topology binary name which is
> based on used machine driver.

*seems like this thread is missing few maintainers in CC*

> 
> Mateusz Gorski (3):
>    ASoC: Intel: Skylake: Add alternative topology binary name
>    ASoC: Intel: Multiple I/O PCM format support for pipe
>    ASoC: Intel: Skylake: Automatic DMIC format configuration according to
>      information from NHLT
> 
> Changes in v2:
> - removed patch 1/4 swapping machine device and platform device
>    registration order
> - alt_tplg_name creation now uses different field to read machine driver
>    name
> - including of <sound/soc-acpi.h> moved to different patch

Ain't change-block supposed to be just below message body?

> 
>   include/uapi/sound/skl-tplg-interface.h |   2 +
>   sound/soc/intel/skylake/skl-topology.c  | 189 +++++++++++++++++++++++-
>   sound/soc/intel/skylake/skl-topology.h  |   1 +
>   3 files changed, 187 insertions(+), 5 deletions(-)
> 

You have forgotten to add my Reviewed-by tag as both, v1 and v2 were 
reviewed by me internally before upstreaming.

Thanks for addressing Pierre's review - indeed i2s_dev field usage could 
have been avoided. Good review, Pierre.

Don't believe series need to be resend just to fix cosmetics:
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
