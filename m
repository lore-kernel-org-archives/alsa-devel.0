Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8867C433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:22:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC7B22286
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UGSCLLzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7B22286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 397C416C0;
	Wed, 16 Sep 2020 15:21:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 397C416C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600262536;
	bh=qpQW8rqnN4KXIZPc0LcxL1jhXKW6fer64irivX9jKJM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGSCLLzGBR2J6uSXenlTMTo4dLxTt2OIAh+SjfcrdhRDbmO5YGXBmU0vwgoV6s0Fw
	 Yu9038+3UKiciWWmSHpS0vXMHzZDG47PEIylUofuvi6cICcxMrgT+qeWdTIUNCCUcn
	 xieG+WIlqZ9swUm1V+vdTHJ/5vbA7JQDHFejw2bY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C129F802DD;
	Wed, 16 Sep 2020 15:20:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA999F802DF; Wed, 16 Sep 2020 15:20:17 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FAD3F8020B
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 15:20:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FAD3F8020B
IronPort-SDR: EllPohcUk+QOHOvgov2tP4f+2OHEz28KDOO7lVdfx0F4qdn91dmsrht+Yxq5auXbW/K32HhYwT
 vTL/WNJXVLrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="158739708"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="158739708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 06:20:07 -0700
IronPort-SDR: aNmDpg3D6dXOBkv8AOEPQ7Eo0OR4v49dvSZKbbKqki7iDt0H6/qz2nGujWkIt447J/1WN8tda+
 HnS7s6zRbiEg==
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="507165115"
Received: from gopikapa-mobl.amr.corp.intel.com (HELO [10.209.66.210])
 ([10.209.66.210])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 06:20:07 -0700
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value set.
To: Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
Date: Wed, 16 Sep 2020 08:18:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916124634.GM2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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


>> According to usage (bitfields.h) of REG_FIELDS,
>> Modify is:
>>    reg &= ~REG_FIELD_C;
>>    reg |= FIELD_PREP(REG_FIELD_C, c);


if this is indeed the case, all the code in cadence_master.c is also 
broken, e.g:

	dpn_config = cdns_readl(cdns, dpn_config_off);

	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);


Gah.

