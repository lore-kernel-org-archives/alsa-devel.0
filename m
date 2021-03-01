Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F10C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:54:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9F164E41
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F164E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21FEB169F;
	Mon,  1 Mar 2021 14:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21FEB169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614606890;
	bh=ExZVqku75Co3OApbG13LcXf3+8VU5GNXgfPiW99Yi7I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9FPim/LfGAVeEHiG9fMaJC5ULUb9+hDn+PMh5wxgyQDYy9VcDDEK1073vrexukuq
	 9iXpl4U0mvn71EtsYlZaDVhhdzUs0o6HOUROTDehVDyDDAh8ar2gQ0N1jeecIMLCLd
	 a5mZrp0EcKzwnW7izd41J4z18vhHczFVk/jdU/7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E5F2F804FC;
	Mon,  1 Mar 2021 13:37:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 160BDF80508; Mon,  1 Mar 2021 13:37:27 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4340F804FC
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 13:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4340F804FC
IronPort-SDR: b/vuZWofEZmvPlLfwaQghgcPHT1oNkDf2kr+M/VzkxULlo5jmgv85W7oC4fnk75pM/fYU98Ptm
 qe5+FJGyaYeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165681141"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="165681141"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:37:16 -0800
IronPort-SDR: 6KMnGF1B+htsRyDuEnC0Bakm+2zocqOdXoKQvE9rjiZ01/882mKLfarANPUHwhR4OE0RyKhVuA
 cu4qtWHT+Reg==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="397708026"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.1.91])
 ([10.213.1.91])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:37:14 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: Compile when any configuration is
 selected
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20210125115441.10383-1-cezary.rojewski@intel.com>
 <CAAd53p4fycxLn6y0WpaMWvWkN8EwmT216b40DavttfshN_GMRg@mail.gmail.com>
 <324dc8a5-c4d3-6ebf-c8e9-6321d6c93dab@intel.com>
 <CAAd53p4gqyuFPWX55fnPGHORXXf58++ZRMH9WFYp+QwS1=xDJQ@mail.gmail.com>
 <181c989f-7a4d-3cdd-11be-7378dbc9502c@intel.com>
 <5e970d19-9544-50fe-f140-b66245418c6e@intel.com>
 <CAAd53p4srH6NFwcyUCBnLj=MS8-YBvA9CPjMbcryGgi5CmUUHw@mail.gmail.com>
 <2c93bf65-4996-08c6-5be1-da4b9966e168@intel.com>
 <f20e5e2b-3761-5e13-3166-5f026d088aa1@intel.com>
 <CAAd53p6ZyuAzNJWLyONkbFndSRF2HBLn=6HLzb5RUShCmNWdVQ@mail.gmail.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <46f88397-dd4e-ffb4-3bd3-8f64c4827b66@intel.com>
Date: Mon, 1 Mar 2021 13:37:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p6ZyuAzNJWLyONkbFndSRF2HBLn=6HLzb5RUShCmNWdVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
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

On 2021-02-22 4:04 PM, Kai-Heng Feng wrote:
> Hi Cezary,
> 

...

>>
>> I'd like to close the compilation issue which this patch is addressing.
>> Could you confirm that the presented change fixes the issue on your end?
> 
> No, the SST regression is not fixed.
> However, it's not the scope of this patch, which is to fix a different issue.
> 
> So please proceed to merge the patch. We can discuss the SST
> regression in other thread.
> 

Thanks for the reply Kai-Heng.
Could you elaborate on the SST regression subject though?

Mark, do you want me to re-send the patch?

Regards,
Czarek
