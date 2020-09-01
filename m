Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F7C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:31:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F782078B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JljNOKaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F782078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6C7917B2;
	Tue,  1 Sep 2020 20:30:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6C7917B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598985068;
	bh=GU5jknsCTZZ3XDEk1cxYpjyVvzXo6mG9ZAzUEKy4jBw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JljNOKajbasZ+mLaHF8y6C/VvUD6t4r9fD2HZhhn474dkSE0MStqu9DCl9WmBFMuf
	 Bco+nQxWuT1NVHDAlvyKVux9pPQAtDBAWcHHHRKssPqlCxm50TEF+oEUS6rmAARLSm
	 lce39yacsAQTouiVewhN97dcq8TyWVhWSoVUhGjM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54BB7F8020D;
	Tue,  1 Sep 2020 20:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 069EEF80217; Tue,  1 Sep 2020 20:30:13 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83D07F801DA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 20:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83D07F801DA
IronPort-SDR: UeDOzPB1Hfsu5hgwQRtNEMnlwhQNhn1V3NFhJ+FBEXeI1TudUvH9z53thwWyqkjFkp0g0mKDrX
 wsrw4PzmSZDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="137294963"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; d="scan'208";a="137294963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 11:29:59 -0700
IronPort-SDR: T7OSlaVoI3u6ZC/6uEQh6dIdSjZ5pwOu1Ouod8OqaaFKyA+UiyQ42SaziHyySa/xpTPPi6EJk+
 se+DveOGYStg==
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; d="scan'208";a="502346237"
Received: from yzhan76-mobl.amr.corp.intel.com (HELO [10.212.111.228])
 ([10.212.111.228])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 11:29:50 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for MPMAN Converter9
 2-in-1
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20200901080623.4987-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7bfe9f46-63bf-8495-0ef1-aa0dff42d734@linux.intel.com>
Date: Tue, 1 Sep 2020 08:16:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901080623.4987-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 9/1/20 3:06 AM, Hans de Goede wrote:
> The MPMAN Converter9 2-in-1 almost fully works with out default settings.
> The only problem is that it has only 1 speaker so any sounds only playing
> on the right channel get lost.
> 
> Add a quirk for this model using the default settings + MONO_SPEAKER.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Hans!

