Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B28C4741F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:22:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C34A20786
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MX5XKjmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BCA0167E;
	Thu,  5 Nov 2020 17:22:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BCA0167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604593374;
	bh=kXLDNUI+CxKe9tjwC47pb/KDZMpFwU1CQMpkL95gTbU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MX5XKjmcWvKq4sClFMZb8Y8V4DBV7VJvRVnvUL0z2T1eOQlpZ6ly50ZhpKXg6cjUH
	 ot5SHHg6970CUV2tWlSG+NI4Tl1K1N7j0Qp83TH3ki9bu4oMG+b5YqOjJHn8i1Ti9F
	 FPMMfJjPbwRcfqgB/7ZkUMrLOBP86RZKpfyIVhx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDA3EF800BA;
	Thu,  5 Nov 2020 17:22:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58F5DF80171; Thu,  5 Nov 2020 17:22:02 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89B12F800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 17:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89B12F800EC
IronPort-SDR: x/jcNy1kyy5/0S89845FerIj2PpaIFuZ2z02RqtliyZPVOfwTnob0PngLOiAYFDzFNSczRkqbQ
 OkBFfMLuoFGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="254117005"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; d="scan'208";a="254117005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 08:21:49 -0800
IronPort-SDR: hl4GtaSibPgUhGLw5GW27FY4FYOcw6yn18XocQQCoz5se2eglotbMRBQ9HPFtevTNCtD0lqu+z
 LIdp+DiJ71Zw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; d="scan'208";a="539466778"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO [10.254.6.114])
 ([10.254.6.114])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 08:21:47 -0800
Subject: Re: [PATCH v3] ASoC: rt1015: add delay to fix pop noise from speaker
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20201105030804.31115-1-jack.yu@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fea8c842-f842-4186-0b53-2b92260553d7@linux.intel.com>
Date: Thu, 5 Nov 2020 08:31:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105030804.31115-1-jack.yu@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, tzungbi@google.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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



On 11/4/20 9:08 PM, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
> 
> Add delay to fix pop noise from speaker.
> 
> Signed-off-by: Jack Yu <jack.yu@realtek.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

