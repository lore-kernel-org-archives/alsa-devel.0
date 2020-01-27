Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D67C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812472067C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OOut5NmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812472067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2BAC167B;
	Mon, 27 Jan 2020 13:20:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2BAC167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580127701;
	bh=Agtx4uajSGL/n12/jtg+i0yJcrsnGtFDmtTjowER4Mo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOut5NmDj5w7bO0CZdLSkCUMSpODIFq7gFxb5jDwvZ1SQBCf3gSUY/xDAz5xF2MV5
	 rJk1cFWr3wANnnZqq+2eUL5wC/LbjqwgRaO0Cqif84s7oNmS9ZKZSBYdOejF81S6f/
	 8vJD3twqr5yPE1amKVcwvjKqAC3bxQDQtS8GEvbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 633D8F80085;
	Mon, 27 Jan 2020 13:16:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 509FFF8021E; Mon, 27 Jan 2020 13:16:30 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 711D0F80085
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 13:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 711D0F80085
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 04:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; d="scan'208";a="223225419"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2020 04:16:13 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200124190413.18154-1-cezary.rojewski@intel.com>
 <20200124190413.18154-8-cezary.rojewski@intel.com>
 <0713f11f-99a6-939b-322b-32a275f7920e@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <dc06c2bd-fa9d-97f0-bb27-7c8aa0cee346@intel.com>
Date: Mon, 27 Jan 2020 13:16:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0713f11f-99a6-939b-322b-32a275f7920e@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH 07/12] ASoC: SOF: Implement Probe IPC API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2020-01-24 20:28, Pierre-Louis Bossart wrote:
> Cezary, if you send stuff upstream directly, please test and provide 
> patches against Mark's tree. The line above is a telltale sign that you 
> used topic/sof-dev.
> Thanks.
> 

Rebased in v2, thanks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
