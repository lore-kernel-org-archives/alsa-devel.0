Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBFC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F04206DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B6aoH98w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F04206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58D301757;
	Tue, 18 Aug 2020 15:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58D301757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597758708;
	bh=/slSsivvZgkyvVR9C0c59sev1Ouph3IWfCRnFhXcwSw=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B6aoH98wSFOa93S/eiPhPOBdxYQ9hhXPT7hIX/iV0Zm5dWZFuJDWbuR/nhOg8lTzA
	 IztVkUmi01OBQVCVjYJVDK5kw05yB8xaiYJB2UfN2yG3HmNahztdBC5tEwzyrP5Z9y
	 xSgXOSUs0VkaZc7yyb9VdPuaueBQmNary9yZH+9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9BA7F80114;
	Tue, 18 Aug 2020 15:50:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 316D3F8023F; Tue, 18 Aug 2020 15:50:56 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B798F80114
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 15:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B798F80114
IronPort-SDR: R+NR5wnAJWZetdlBO27QF1h5F+lWBwmPa7Z2JX1rUIvLeE6Xql2gYDBzQyveaCqh6lu4ckXB/k
 D6SwC4RKvvpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154872054"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="154872054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 06:50:44 -0700
IronPort-SDR: OFjA1eihL9+leGX1XYtlVNpCK7iHXFFmlgmhCiGVDFbAQiXAPfr0FrDYFE6KKeK4+KS2Yf2XKX
 ZxwkIyGMOxnw==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="278050481"
Received: from cdrobins-mobl.amr.corp.intel.com (HELO [10.209.120.216])
 ([10.209.120.216])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 06:50:41 -0700
Subject: Re: [PATCH 2/2] soundwire: fix port_ready[] dynamic allocation in
 mipi_disco and ASoC codecs
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-3-yung-chuan.liao@linux.intel.com>
 <20200818063659.GW2639@vkoul-mobl>
 <e9f12e13-49e0-5306-a975-b1b854baef02@linux.intel.com>
Message-ID: <c5c91925-b4c0-a41a-1c35-aeebf5de175b@linux.intel.com>
Date: Tue, 18 Aug 2020 08:50:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9f12e13-49e0-5306-a975-b1b854baef02@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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




> In addition, there's a WIP change to regmap to add support for SoundWire 
> 1.2 MBQ-based register access, but this only affects regmap and ASoC 
> trees, all handled by Mark.

I have to take this comment back, the regmap change will depend on the 
MBQ macro that should go in the SoundWire tree.

