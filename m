Return-Path: <SRS0=QuHl=MW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BDDC432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 14:06:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA4A60F5E
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 14:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECA4A60F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E1851930;
	Fri, 30 Jul 2021 16:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E1851930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627653986;
	bh=X8G/Gc1HrzU7b9Z/WGLa6xyXB4XY7b2EXIVB8QnsocQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6WL5/eH7XbEgIgv+7rcfjyl8WoRaoLPPhC16cwyGn7bPfV200pBUT6be2aYJr+px
	 Ei/Got3L9QPjEMXxBiMS60Qcr5ssiWDPo56XhSTXzFXr37jS8MZ7lmvAaS3XF/kQF9
	 Dcbi5sSN0WqLOaDTs7z4Hbpez4uvHGSkf2ONl50I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AE8CF80212;
	Fri, 30 Jul 2021 16:05:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2346F80253; Fri, 30 Jul 2021 16:05:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18072F8019B
 for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2021 16:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18072F8019B
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="276879182"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; d="scan'208";a="276879182"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 07:05:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; d="scan'208";a="508132580"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.24.117])
 ([10.213.24.117])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 07:05:23 -0700
Subject: Re: [PATCH v1] ASoC: Intel: kbl_da7219_max98357a: fix drv_name
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Lukasz Majczak <lma@semihalf.com>
References: <20210730115906.144300-1-lma@semihalf.com>
 <58b46549-9b42-1832-b1e1-680d56c3f393@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c1fb1cd1-6d27-648a-ac9c-81e150505750@intel.com>
Date: Fri, 30 Jul 2021 16:05:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <58b46549-9b42-1832-b1e1-680d56c3f393@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, upstream@semihalf.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On 2021-07-30 3:55 PM, Pierre-Louis Bossart wrote:
> On 7/30/21 6:59 AM, Lukasz Majczak wrote:

...

>> @@ -113,7 +113,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
>>   	},
>>   	{
>>   		.id = "DLGS7219",
>> -		.drv_name = "kbl_da7219_mx98373",
>> +		.drv_name = "kbl_da7219_max98373",
> 
> this one is wrong though? The correct name was already present, you're
> reverting back to the wrong name.
> 
> there's another one that I missed, do you mind changing this as well?
> 
> soc-acpi-intel-cml-match.c:             .drv_name = "cml_da7219_max98357a",
> 
> Should be "cml_da7219_mx98357a"
> 
> 

Not saying 'nay' or 'yay' but why is configuration first available on 
KBL platforms being renamed to 'cml_XXX'?

Czarek
