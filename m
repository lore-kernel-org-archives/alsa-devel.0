Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85881C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 20:19:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF06A64DD8
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 20:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06A64DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29D9316AF;
	Fri, 29 Jan 2021 21:18:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29D9316AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611951579;
	bh=umBlcfJaBqGCq8S2ESGQl60p0x7bnma6bKwK180tImI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVECcMUkgL/YyM7HDhKrU7sB4LC/36J9hEzhBjCKHXwVv27Q0Jz7UtOa9p/GxVrU5
	 K6OJ7YVlXW0Y+/oPUFu8CXexUvwx+KyL90BtYUrtHNux7Y/Co/8KJLXvcF3f4t8iWg
	 MG4512VrMAxt/Af4nXofaOIB8zbCI/liSkVk3ek4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E77A8F804CA;
	Fri, 29 Jan 2021 21:17:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C051F800EB; Fri, 29 Jan 2021 21:17:15 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 643ACF8025F
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 21:17:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 643ACF8025F
IronPort-SDR: Ms1Q7IsYNQNQQyHVq2X7A/ufLZ8eR4HIKgDx0uUlmDAptd1eM00LlMGEdl8ZaLClbSe9yxD2rl
 +/qNDJwXKo7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="177916022"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; d="scan'208";a="177916022"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 12:17:10 -0800
IronPort-SDR: 4iUoTLsK6X6g3lCJu8TKhFGnkmMJ+ssQqrjiJ2apzIBjEOVNvNLlzfm/RfwI8AJ6DkiWcFMtIA
 rR9Z1034pxSw==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; d="scan'208";a="431150014"
Received: from kagerrar-mobl.amr.corp.intel.com (HELO [10.212.16.186])
 ([10.212.16.186])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 12:17:09 -0800
Subject: Re: [PATCH 6/6] soundwire: qcom: add support to new interrupts
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
Date: Fri, 29 Jan 2021 13:38:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org
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



On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
> Add support to new interrupts and update irq routine in a way
> to deal with multiple pending interrupts with in a single interrupt!

I can't parse the wording after 'update irq routine'.


> +	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
> +	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, 0x0);

what does this second write 0x0 do? Usually interrupts are W1C, and you 
didn't have this before.

