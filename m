Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B0C4332B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:45:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DD220775
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lrguUxoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DD220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E1C2170F;
	Wed, 18 Mar 2020 21:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E1C2170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584564298;
	bh=dcTvTaCoDhDu5a3vy1j+Ia/M+aG+jyUkBUuwtesSFBI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrguUxoc5II6iIb7G3asKgzNL3fRreeFghvMAQPbVvk346QREdOx9CcIjzAEHKWFg
	 /3AfbOOIMqHD+7r3GS2apFot9uEjfjhLdzWIFABomz6FxcS1l3p+vCkNdyUeh/ZuQE
	 3qBeKv7sU80niy/6hC1ekjD7x07edeFBpAxvlGiQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFCF8F800C0;
	Wed, 18 Mar 2020 21:44:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3693BF80139; Wed, 18 Mar 2020 21:44:06 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79829F800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 21:44:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79829F800C0
IronPort-SDR: hC08Fur9h1ydjWhL4hkpygg7A5CLHFykhi6TfggdDjskgjNvklcFBPMBLNeOVDXnpWP6Fw8LmX
 /412wWkMwUPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 13:43:58 -0700
IronPort-SDR: hnAFtkem/0RpY0/6OofqBa2ypUL03MUicEUJuekqAX1X0jwCOC/oEcgHrsZwVtv8Sgd57+FRBi
 a0SRj1QCHxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; d="scan'208";a="238294014"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222])
 ([10.249.155.222])
 by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 13:43:55 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
Date: Wed, 18 Mar 2020 21:43:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318192213.GA2987@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, curtis@malainey.com,
 linux-kernel@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

On 2020-03-18 20:22, Dominik Brodowski wrote:
> On Wed, Mar 18, 2020 at 07:27:58PM +0100, Cezary Rojewski wrote:

>>
>> Due to pandemic I'm working remotely and right now won't be able to test
>> audio quality so focusing on the stream==NULL issue. And thus we got to help
>> each other out : )
> 
> Sure, and thanks for taking a look at this!
> 
>> Could you verify issue reproduces on 5.6.0-rc1 on your machine?
> 
> It reproduces on 5.6.0-rc1 + i915-bugfix. I'm trying to bisect it further in
> the background, but that may take quite some time.
> 

Could you checkout v5.6-rc1 with following commit reverted:
	ASoC: Intel: broadwell: change cpu_dai and platform components for SOF

For my working v5.6-rc1 commit id is: 
64df6afa0dab5eda95cc4cc2269e3d4e83b6b6ce.

Czarek
