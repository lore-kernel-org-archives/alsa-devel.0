Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:32:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B1564F48
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B1564F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A778B1614;
	Fri,  5 Feb 2021 08:31:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A778B1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612510328;
	bh=g/fSmzoXD6BBQt+alv0WtvUvLkMqbx6tyEdEBxCRo7o=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eytu6p0AUtlGO2KIfmbbGuBs6eO2pACHSJHwHjvvPX2uHzLveQH9VgKhgpSJ9nbhR
	 3TE187lgO1FJblhSbQc3Th8AbT+Lg52JXxOp4ZU/wc1H5fK6vL9y0SyS2H8PH6swwA
	 rxlASf4Sajii1V62VDibxhEE6ISlPDX73FlYFY2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAAB6F80156;
	Fri,  5 Feb 2021 08:31:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 418B1F8015A; Fri,  5 Feb 2021 08:31:16 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E4AEF80152
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 08:31:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E4AEF80152
IronPort-SDR: 1Yy3v+sMJEQTg6PBAERiN8s5Hb3ftXb9zQ1258FIAkmpDwJG21oqmtE72rNVUNO1sMC4KnuNU9
 78e6LhobcLdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181541869"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; d="scan'208";a="181541869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 23:31:02 -0800
IronPort-SDR: dgc7MoiCXiFQl/Jye+rT896ZWBVXQ6uCAJ/9XkNtW+vDklyYOfKtIonNoWE1HkyNUEwHoTWRcv
 qHifkXCF7GYA==
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; d="scan'208";a="483984043"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 23:31:00 -0800
Date: Fri, 5 Feb 2021 09:27:39 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/3] ASoC: soc-pcm: add soc_pcm_hw_update_xxx()
In-Reply-To: <87tuqs90rl.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <alpine.DEB.2.22.394.2102050924430.864696@eliteleevi.tm.intel.com>
References: <87tuqs90rl.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

Hey,

On Thu, 4 Feb 2021, Kuninori Morimoto wrote:

> These adds soc_pcm_hw_update_xxx() and cleanup soc-pcm.c
> 
> Kuninori Morimoto (3):
>   ASoC: soc-pcm: add soc_pcm_hw_update_rate()
>   ASoC: soc-pcm: add soc_pcm_hw_update_chan()
>   ASoC: soc-pcm: add soc_pcm_hw_update_format()

the reduction of duplicated code is not a lot, but there's enough that
I think this make sense. Code looks good:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
