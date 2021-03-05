Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D2C433E6
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 16:15:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747BA65068
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 16:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747BA65068
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D01FA169A;
	Fri,  5 Mar 2021 17:14:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D01FA169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614960902;
	bh=UKJwJsL83DPCPdgCLmF/PTSzp73fBQjyL0O4WFDD7uY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qeG7AOevbc+KV4K8Q8ZbGRxSzmfFwk8NfBgeYEnbYzgTUVtoupjy3AP1k3Bg4n9eg
	 F6oYFB2GwalUBHUgL7G2VSnr+Q7J8JxXOdiJf1etgj2NLCQA7BmcO1kTTBMB1yMHA4
	 f9B7eA/msZvNBD5pEz0Agq+SxIXExqLgI318TTHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B6DDF800ED;
	Fri,  5 Mar 2021 17:14:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B719CF8025E; Fri,  5 Mar 2021 17:14:10 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89574F800ED
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 17:14:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89574F800ED
IronPort-SDR: k9j9aCoapS7lrEeH68fJV9O0fnWb+9nBhw8aN9oalnO7q5GYDQpBQ2nMhD/3Md6NJjZSMijYV+
 2fteE11X7s0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="166935784"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="166935784"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 08:14:01 -0800
IronPort-SDR: At66hWltAQvf4a12iuYYjr5GbeSl1DEI+LSYxwe7pCeRPb1eAvYPWIY3eiPgBzDmYIi/qx8XDa
 NFo7wQBbxsYA==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="408378772"
Received: from unknown (HELO [10.212.58.88]) ([10.212.58.88])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 08:14:01 -0800
Subject: Re: [PATCH 6/8] ASoC: soc-pcm: fixup dpcm_be_dai_startup() user count
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87tupqpg9x.wl-kuninori.morimoto.gx@renesas.com>
 <87lfb2pg8a.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <94eb9f41-3d1d-8054-2f12-16fba9dddaea@linux.intel.com>
Date: Fri, 5 Mar 2021 10:14:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfb2pg8a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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



On 3/4/21 7:00 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> At dpcm_be_dai_startup_unwind(), it indicates error message at (1)
> if this function was called with no users.
> But, it doesn't use "continue" here. Thus, it will be minus
> users at (2).

suggested edit:

"Thus, users will be a negative number at (2)"

> 
> 	void dpcm_be_dai_startup_unwind(...)
> 	{
> 		...
> 		for_each_dpcm_be(...) {
> 			...
> (1)			if (be->dpcm[stream].users == 0)
> 				dev_err(...);
> 
> (2)			if (--be->dpcm[stream].users != 0)
> 				continue;

