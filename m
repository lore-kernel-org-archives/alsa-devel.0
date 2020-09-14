Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FBEC43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A60820756
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZgmPhZ/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A60820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62E1F16F2;
	Mon, 14 Sep 2020 17:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62E1F16F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600098394;
	bh=k+2dSlb2yKmfUR60eKdG9LwHSuyZh2w01VWnrzRoNr4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZgmPhZ/NYkhaVkHyZtPuq9wa/1cH+jZA8vfFJqpr2VEd6lMfewPSbDN8sSmQ3m3eo
	 qGaLUEQItCaB3kvEz9onCnoLinnC/ssIKtz/PQRk578jL4t06GolhR0VqzWPzIz7T2
	 UwIV/H00luBWWrm+gKvdPTzSW0uSHSJzFHTmjyNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE6EEF80150;
	Mon, 14 Sep 2020 17:43:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FAB0F8015A; Mon, 14 Sep 2020 17:43:09 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2625FF800AA
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 17:42:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2625FF800AA
IronPort-SDR: H5KL9cmb9uKpw67CDUwJNbEucOfcxBs9M5spStA7Dq1f+d10UfgJXOMOEYHGW3ql+/g63nRNZa
 0cnc0S2G5KEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="138604418"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="138604418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 08:42:55 -0700
IronPort-SDR: PJW7bs0i3dSNhSmViT/GRcRHTeCds7hgHgmSdl79tx4Vm+dJyhAgL6TAup0YjwMj2y7H2M/cMX
 jOPyLp9mBI5Q==
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="330788739"
Received: from flaurent-mobl3.amr.corp.intel.com (HELO [10.212.243.224])
 ([10.212.243.224])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 08:42:54 -0700
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
To: Vinod Koul <vkoul@kernel.org>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
 <20200909075555.GK77521@vkoul-mobl>
 <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
 <20200910062223.GQ77521@vkoul-mobl>
 <adf51127-2813-cdf0-e5a6-f5ec3b0d33fa@linux.intel.com>
 <20200911070649.GU77521@vkoul-mobl>
 <21606609-8aaf-c7b2-ffaf-c7d37de1fa3f@linux.intel.com>
 <20200914050825.GA2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <11feabb2-dc8b-7acc-6e4d-0903fc435b00@linux.intel.com>
Date: Mon, 14 Sep 2020 09:44:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914050825.GA2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org,
 open list <linux-kernel@vger.kernel.org>, broonie@kernel.org,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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




> For LSB bits, I dont think this is an issue. I expect it to work, for example:
> #define CONTROL_LSB_MASK  GENMASK(2, 0)
>          foo |= u32_encode_bits(control, CONTROL_LSB_MASK);
> 
> would mask the control value and program that in specific bitfeild.
> 
> But for MSB bits, I am not sure above will work so, you may need to extract
> the bits and then use, for example:
> #define CONTROL_MSB_BITS        GENMASK(5, 3)
> #define CONTROL_MSB_MASK        GENMASK(17, 15)
> 
>          control = FIELD_GET(CONTROL_MSB_BITS, control);
>          foo |= u32_encode_bits(control, CONTROL_MSB_MASK);
> 
>> If you have a better suggestion that the FIELD_PREP/FIELD_GET use, I am all
>> ears. At the end of the day, the mapping is pre-defined and we don't have
>> any degree of freedom. What I do want is that this macro/inline function is
>> shared by all codec drivers so that we don't have different interpretations
>> of how the address is constructed.
> 
> Absolutely, this need to be defined here and used by everyone else.

Compare:

#define SDCA_CONTROL_MSB_BITS        GENMASK(5, 3)
#define SDCA_CONTROL_MSB_MASK        GENMASK(17, 15)
#define SDCA_CONTROL_LSB_MASK        GENMASK(2, 0)

foo |= u32_encode_bits(control, SDCA_CONTROL_LSB_MASK);
control = FIELD_GET(SDCA_CONTROL_MSB_BITS, control);
foo |= u32_encode_bits(control, SDCA_CONTROL_MSB_MASK);

with the original proposal:

foo |= FIELD_GET(GENMASK(2, 0), control))	
foo |= FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), control))	

it gets worse when the LSB positions don't match, you need another 
variable and an additional mask.

I don't see how this improves readability? I get that hard-coding magic 
numbers is a bad thing in general, but in this case there are limited 
benefits to the use of additional defines.
