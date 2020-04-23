Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE23C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:49:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0F32084D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="psAmMtsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3583168B;
	Thu, 23 Apr 2020 12:48:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3583168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587638950;
	bh=59GR1U0lXfj09fD/+Q2JWMOTGa0EapQcGOf9lcS5ITA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psAmMtsz6avJhmyM2+obXTgP1eoS142n+SYfDlpK/fcpnyhE0xb6P01WW4mNxjZVw
	 AW/LYsTkcBGAzITjq6Ff2VKlgNX6VxBc/SBU6Kuirm/6K827OUU/0H/aw6wTPEao3m
	 MQDoUNxeBjFiJ7KZmJJ7u6BC2givaKopOqZPFej0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68830F8014A;
	Thu, 23 Apr 2020 12:48:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 673FDF801EC; Thu, 23 Apr 2020 12:48:14 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAB50F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 12:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAB50F800FF
IronPort-SDR: p/WjL8kIod/MbuQ6M5KyDzXU8UQyGcpX7xdRVxuDwGb4uCF6ifw6Yjuzy+wEvr8lnxPUCt+kTZ
 Y/0eWMCrS4dQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 03:48:04 -0700
IronPort-SDR: Nya16Jl1HjZbJC3oNUxzwpy5CS93XpN8oMC1ju8yEsE15broVCSl8/54T/UAiPoLbRitMWAnWs
 GXaI5GRNVGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="456864313"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.5.100])
 ([10.213.5.100])
 by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 03:48:02 -0700
Subject: Re: [PATCH v2 1/3] ASoC: Intel: Skylake: Add alternative topology
 binary name
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
 <20200422120532.31492-2-mateusz.gorski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <554b3330-b3c8-4c73-3755-d780f930b843@intel.com>
Date: Thu, 23 Apr 2020 12:48:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422120532.31492-2-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.com
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
> Add alternative topology binary file name based on used machine driver
> and fallback to use this name after failed attempt to load topology file
> with name based on NHLT.
> This change addresses multiple issues with current mechanism, for
> example - there are devices without NHLT table, and that currently
> results in tplg_name being empty.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
> 
> Changes in v2:
> - added <sound/soc-acpi.h> include
> - machine driver name is now read from different field
> 

> @@ -3575,6 +3588,9 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
>   		}
>   	}
>   
> +component_load:
> +
> +
>   	/*
>   	 * The complete tplg for SKL is loaded as index 0, we don't use
>   	 * any other index
> 

Looks like double newline after 'component_load' slipped through my 
eyes. Please fix it.
