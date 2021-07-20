Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA4C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:50:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AB06023B
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AB06023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4911716AE;
	Tue, 20 Jul 2021 20:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4911716AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626807036;
	bh=4pqPp36DcRnyNup3cY1nClvBcEPl9PhECgVrgiUWXgs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fggPLVWmbRX/3ivK7H+MTXsDwhECI/RO2Dw+sB8xNuYNs7Au9+rRpRz2FySdB9qkc
	 HcU8b9Rb/EOY2kgGks4lr0k1xF29f9mUGwHewFOMDpf3+Zl3+zGH/LWONv64NRsrSb
	 PpELybM+qtXuOqtp9qNKRomlpwk6c5x6vYz3Csqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BCCBF804E6;
	Tue, 20 Jul 2021 20:47:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21091F804AC; Tue, 20 Jul 2021 20:47:47 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7B89F80256
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 20:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7B89F80256
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="198511684"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="198511684"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 11:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="462146693"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10])
 ([10.209.130.10])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 11:47:34 -0700
Subject: Re: [PATCH v4 00/12] Add Vangogh ACP ASoC driver
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6988543f-acd4-412d-67e2-651217de2510@linux.intel.com>
Date: Tue, 20 Jul 2021 13:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alexander.Deucher@amd.com, Sunil-kumar.Dommati@amd.com,
 krisman@collabora.com
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



On 7/20/21 11:37 AM, Vijendar Mukunda wrote:
> This adds an ASoC driver for the ACP (Audio CoProcessor)
> block on AMD Vangogh APU.

Thanks for the update. I added a couple of minor comments on the v4, this looks mostly good now so feel free to add my tag in the following version

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
