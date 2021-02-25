Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 17:17:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8770D64F18
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 17:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8770D64F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C41241666;
	Thu, 25 Feb 2021 18:16:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C41241666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614273436;
	bh=J5DCUesOLWBs2FJxGjpqzxey/LPaV9LkOuJ9WfKV83Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t2AGKMO/XxYCdimclW/omb+AWHzVW8tZXWS6iiVeNyiK7PGZdsYKj46v9MqAwba9X
	 /62GF3xI0KHPs04GMExOozNV2g37LDISS+H+eEryRkyDso1gTOSBvo6Mo/IdbchUz6
	 UhR7DX6eMi9GfZSJuSmMqOWR0nl63TZqvP5ck+eE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1691F801F5;
	Thu, 25 Feb 2021 18:15:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 964BCF80245; Thu, 25 Feb 2021 18:15:35 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99515F800E4
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2021 18:15:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99515F800E4
IronPort-SDR: Zfp/aEF6ZOyXXlmiyDdLkdPUS6odR6MLgQNm5C8yuVg/ZU+Vkwpag8vLYaRp2YdLtuxb4d4yuf
 5z5TZEv+isXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="205098329"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; d="scan'208";a="205098329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 09:15:27 -0800
IronPort-SDR: A9hcBWro+tghSvoV8hJWgKJ65nCsry/C+cWc3gFYRHdtmwabPA5e51FfnxQknF2CJT75C3z4zB
 VVxYlff5ZXaA==
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; d="scan'208";a="404463272"
Received: from huisu-mobl1.amr.corp.intel.com (HELO [10.212.85.68])
 ([10.212.85.68])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 09:15:26 -0800
Subject: Re: [PATCH] ASoC: rt1015p: add acpi device id for rt1015p
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210225084545.13359-1-jack.yu@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8ba7a3b-f903-18ac-aeba-b91e180d9878@linux.intel.com>
Date: Thu, 25 Feb 2021 11:15:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225084545.13359-1-jack.yu@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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


> +static const struct acpi_device_id rt1015p_acpi_match[] = {
> +	{ "RT1015", 0},

This is not an ACPI compliant HID, please don't do this. acpica-tools 
will flag an error on this.

And this is super confusing since you already have this in rt1015.c

static struct acpi_device_id rt1015_acpi_match[] = {
	{"10EC1015", 0,},
	{},
};



