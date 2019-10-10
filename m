Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3EC4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 19:21:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28DA206B6
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 19:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GyQPmAwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28DA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89C301612;
	Thu, 10 Oct 2019 21:20:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89C301612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570735288;
	bh=1iGnOcwFkfYAiTHf0BWfHtgGWg5E4OqHhD7X1VW2ipA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyQPmAwhXos1wu7tl4Q0gPNwpKi2HcyZxNaAmUnPUYzu9MHC7WK0Cg9YroMW/gDSX
	 AxjyHvyKTuu1NIDSE5CKJsyJHyeZBWz+kPJzn6ArqawKUd5kpknYDsIHQzfHyer1rd
	 WHzeGTai3xujqgbcD9CkXD71HeziHqetiDLpUHSo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F96DF802BC;
	Thu, 10 Oct 2019 21:20:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B16FF8038F; Thu, 10 Oct 2019 21:20:36 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC88BF802BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 21:20:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC88BF802BC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 12:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; d="scan'208";a="206203239"
Received: from pchamber-mobl1.amr.corp.intel.com (HELO [10.252.139.48])
 ([10.252.139.48])
 by orsmga002.jf.intel.com with ESMTP; 10 Oct 2019 12:20:30 -0700
To: Mark Brown <broonie@kernel.org>
References: <20191008164443.1358-1-pierre-louis.bossart@linux.intel.com>
 <20191008164443.1358-3-pierre-louis.bossart@linux.intel.com>
 <20191010140805.GA4741@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8fecfc14-8a5c-272b-6785-369243d9a49b@linux.intel.com>
Date: Thu, 10 Oct 2019 10:41:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010140805.GA4741@sirena.org.uk>
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/9] Revert "ASoC: SOF: Force polling mode
 on CFL and CNL"
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


>> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>>
>> This reverts commit 64ca9d9fcb3e3c86b1417e3d17a90b43dd660f81.
> 
> Please use normal subject lines even for reverts - it makes
> things esier to spot.

ok, will do next time. I thought the opposite was recommended - using 
the default git style.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
