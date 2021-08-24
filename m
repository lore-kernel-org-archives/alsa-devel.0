Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A8C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650A361373
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 650A361373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D25A5167C;
	Tue, 24 Aug 2021 18:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D25A5167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824118;
	bh=hsGGjOGOXl4V+v37KyDExG3mFlCSSBrsldjIuUlUtC8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SmOw9fuLl6pN/NwM0WPP8lvwuoHlfDxCHhZBiE7D9VbRU1RaOJlOYytwOP0zooelv
	 FCVO+I7bW530KJ+frOPDGUowEnSfm/OZUXHDKmgyb4tSdFHS6zpnb+jMyxZyShcKOU
	 N9cFSDMXMqNXRGCnzrNOAq0Qc4HwT/alPe+HBIj8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA74BF801D5;
	Tue, 24 Aug 2021 18:53:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A019F801D5; Tue, 24 Aug 2021 18:53:48 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51DA9F801D5
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 18:53:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51DA9F801D5
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217076298"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="217076298"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 09:53:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="685433427"
Received: from jlrivera-mobl1.amr.corp.intel.com (HELO [10.212.8.132])
 ([10.212.8.132])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 09:53:31 -0700
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
To: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
 alsa-devel@alsa-project.org
References: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c0e98e24-1c62-aa37-e283-c8b5f56f4f2e@linux.intel.com>
Date: Tue, 24 Aug 2021 11:22:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: lance.hou@intel.com, cezary.rojewski@intel.com, mark_hsieh@wistron.com,
 kai.vehmanen@linux.intel.com, yang.jie@linux.intel.com,
 linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 mac.chiang@intel.com, broonie@kernel.org, brent.lu@intel.com,
 bard.liao@intel.com
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

Looks mostly good, minor comments below

On 8/24/21 8:21 AM, Mark Hsieh wrote:
> Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker
> 
> BUG=b:191811888
> TEST=emerge-brya chromeos-kernel-5_10

I don't think we need this for upstream?

> +struct snd_soc_ops max_98390_ops = {
> +	.hw_params = max_98390_hw_params,
> +};

this could be const. We didn't do it for previous codecs but that was a
miss. I'll send a patch for the max98373

> +extern struct snd_soc_ops max_98390_ops;

const

