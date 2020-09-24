Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131FC4346E
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:48:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B7C235FD
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cbLMf0ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B7C235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BB581794;
	Thu, 24 Sep 2020 07:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BB581794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600926509;
	bh=1W64pjvAof5OsM4DMhjZ2MZtg1c2Pj/Xl5RtkbnGoZQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cbLMf0ewZUcysCOKJA3YsiwYMhOvrarOmD4ckqcMoKlR7Au4ob5xHAdAie2j+5bwu
	 +A1yBvvAs1O6sK7u5e3O/HfxxmOQUHypEz7L/UL4Sqw5cMEp52NThaxNNoe3R55HVa
	 cHGo3uXuEJSlloSqXfLmAqD0lrIlXjNiR3cDsVn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 891ABF80229;
	Thu, 24 Sep 2020 07:47:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FFCAF80232; Thu, 24 Sep 2020 07:47:37 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55994F8015F
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 07:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55994F8015F
IronPort-SDR: ajrSPJodEgL1cyMDIys+vFLRQmEBlLEIAdbRRb50ZoN2sHCTH8xcEDVxrILAnlyN4oq9vLsGKE
 p7bJzRk+wckQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148856165"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="148856165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 22:47:15 -0700
IronPort-SDR: TMF/A4RtDGVTWyhNudwXWNKE1zbZCxG85du9qJrSJ77RIlTPaoashV8l/KZSdRTm0jP6Xg78RO
 fvz+BTnA5kkA==
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="335801799"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 22:47:13 -0700
Date: Thu, 24 Sep 2020 08:45:30 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: SOF: fix kcontrol size checks
In-Reply-To: <160073312817.6173.14263034136602358389.b4-ty@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2009240841280.3186@eliteleevi.tm.intel.com>
References: <20200921110814.2910477-1-kai.vehmanen@linux.intel.com>
 <160073312817.6173.14263034136602358389.b4-ty@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Hi Mark,

On Tue, 22 Sep 2020, Mark Brown wrote:

> [3/5] ASoC: SOF: control: add size checks for ext_bytes control .put()
>       commit: 2ca210112ad91880d2d5a3f85fecc838600afbce
> [4/5] ASoC: SOF: control: remove const in sizeof()
>       (no commit info)
> [5/5] ASoC: SOF: topology: remove const in sizeof()
>       (no commit info)
[...]
> Applied to                                                                                                                                                                                   
>                                                                                                                                                                                             
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next  

I wonder what happened here...? Patches 4 and 5 didn't end up applied 
although they were in the sent series. I can send them again no prob, but 
wondering if there was something wrong in the original series, so I can 
avoid the problem in the future.

Br, Kai
