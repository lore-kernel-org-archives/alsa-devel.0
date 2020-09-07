Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBBC433E2
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:57:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09567206D4
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tRJehSk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09567206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4854179A;
	Mon,  7 Sep 2020 08:56:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4854179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599461823;
	bh=O2tRFycCZHbAI+HkoDdeb6T7YOlYwSXs02gQoG6xPGw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRJehSk2tM2Z1DU4tkDLb3KJC9nbk6J5XPCVag17b815uvJZO7GLj49XmySCRtuL6
	 hBMmyEjWKy9J9RKxcflFhgNabjLQSc+BHLA+KVKYQP+dPDKn0p+C9cAPjUETnFKzsH
	 rBYS1eKnSUOV45YUsoISjlGXt3SL7a23NEQ1RULw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73DC9F8021C;
	Mon,  7 Sep 2020 08:56:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26699F80227; Mon,  7 Sep 2020 08:56:10 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 017CBF800D3
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 08:56:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 017CBF800D3
IronPort-SDR: VeqHW0z+KhZ13gwdn/K1SgZCmmSjTLgACbTLyrixcw2s0sQMPWWQIBj3zipl1vAHlE58+qyxQ6
 xbR/8uCCuS2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157226468"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; d="scan'208";a="157226468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2020 23:55:57 -0700
IronPort-SDR: Lb4w1+QuW7lx1jayQ5wXV2NBoNhdnugYCgFcSXddlUXGj+967Wxlztg0pTdeXWzLJ/A4wiXy2H
 0vZO4pGeZdtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; d="scan'208";a="303640874"
Received: from oliviapo-mobl.ger.corp.intel.com (HELO [10.213.16.209])
 ([10.213.16.209])
 by orsmga006.jf.intel.com with ESMTP; 06 Sep 2020 23:55:55 -0700
Subject: Re: [PATCH] [RFC] ASoC: core: Do not cleanup uninitialized dais on
 soc_pcm_open failure
To: broonie@kernel.org
References: <20200904123854.26742-1-cezary.rojewski@intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c7d05b64-5e1e-e4a8-0685-5693ecfb8c91@intel.com>
Date: Mon, 7 Sep 2020 08:55:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904123854.26742-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com,
 kuninori.morimoto.gx@renesas.com, pierre-louis.bossart@linux.intel.com
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

On 2020-09-04 2:38 PM, Cezary Rojewski wrote:
> Introduce for_each_rtd_dais_rollback macro which behaves exactly like
> for_each_codec_dais_rollback and its cpu_dais equivalent but for all
> dais instead.
> 
> Use newly added macro to fix soc_pcm_open error path and prevent
> uninitialized dais from being cleaned-up.
> 

Mark, may I re-send this patch with a quick update - append 'Fixes' and 
remove '[RFC]' tags - before this gets merged? Change would fill 
complete with these updates.

Czarek
