Return-Path: <SRS0=nH8J=HR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A03C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 15:44:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB5F64E8E
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB5F64E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB32C1655;
	Mon, 15 Feb 2021 16:43:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB32C1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613403849;
	bh=A6CHLJo+IjVw3TJZBh2jm5AhzIdQZUdeu9h59RODGmU=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWp0IqG1pdCn3AwS2lS2rT60Hvnm4CtWR/9MOJVlccJbgV5Tbo4sWKMmqSPUbJnZQ
	 enkIj08Xn+O73yxtyvNWhyOSqgtakIMsYveZpw/y4n2XGQ4DRa22fbftx/RliPPyTT
	 LZl7dKrzezkSI1rqweXuo+EC01yU/ZCfN7VT8KTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F6B5F8020B;
	Mon, 15 Feb 2021 16:43:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A46DF80258; Mon, 15 Feb 2021 16:43:17 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4152DF80089
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2021 16:43:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4152DF80089
IronPort-SDR: YB/3WnOZDWtFoMAzjtYgoIC/yfDgPA+mtgBvycYVCrcQeIBelSvMjR7muYJfsQTz0dt97fEEX2
 HPykwYBuPyEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="179205317"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; d="scan'208";a="179205317"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2021 07:43:06 -0800
IronPort-SDR: dCXx2fYsPNhz52iSYJrFsR0qkT7fu5JO590zwX3TA9+9bdC/7OPxq6jBfYcrm8utPkCDUHi/8c
 vl5nBr1fGbQA==
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; d="scan'208";a="399122736"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.10.52])
 ([10.213.10.52])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2021 07:43:03 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: Compile when any configuration is
 selected
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20210125115441.10383-1-cezary.rojewski@intel.com>
 <CAAd53p4fycxLn6y0WpaMWvWkN8EwmT216b40DavttfshN_GMRg@mail.gmail.com>
 <324dc8a5-c4d3-6ebf-c8e9-6321d6c93dab@intel.com>
 <CAAd53p4gqyuFPWX55fnPGHORXXf58++ZRMH9WFYp+QwS1=xDJQ@mail.gmail.com>
 <181c989f-7a4d-3cdd-11be-7378dbc9502c@intel.com>
 <5e970d19-9544-50fe-f140-b66245418c6e@intel.com>
 <CAAd53p4srH6NFwcyUCBnLj=MS8-YBvA9CPjMbcryGgi5CmUUHw@mail.gmail.com>
 <2c93bf65-4996-08c6-5be1-da4b9966e168@intel.com>
Message-ID: <f20e5e2b-3761-5e13-3166-5f026d088aa1@intel.com>
Date: Mon, 15 Feb 2021 16:43:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2c93bf65-4996-08c6-5be1-da4b9966e168@intel.com>
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

On 2021-02-07 3:49 PM, Cezary Rojewski wrote:
> 
> On 2021-02-02 1:41 PM, Kai-Heng Feng wrote:
>> On Tue, Feb 2, 2021 at 6:56 PM Cezary Rojewski
>> <cezary.rojewski@intel.com> wrote:

...

>> Commit cc2d025a81a9 ("ASoC: Intel: Skylake: Update description for
>> HDaudio kconfig") removed "DEPRECATED" from the
>> SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC, does that mean the option is safe
>> and should be enabled in downstream distros?
> 
> Skylake driver - sound/soc/intel/skylake - is your only option if you 
> want to enable HDA (dsp) + DMIC configuration on SPT platforms 
> (skl/kbl/kbl-r/aml/cml-s).

Hello Kai-Heng,

I'd like to close the compilation issue which this patch is addressing. 
Could you confirm that the presented change fixes the issue on your end?

Regards,
Czarek
