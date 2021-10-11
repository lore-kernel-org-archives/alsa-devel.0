Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5070C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 16:16:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7970060EE2
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 16:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7970060EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64BA91699;
	Mon, 11 Oct 2021 18:15:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64BA91699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633968993;
	bh=wSEtBNGdQSetF0B1kfSGqlVeepqfBTVZ4Sfrz2ZuoJw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Thsp3fqAqYiJjVrQvHRnlCRrcnGEIsGYVVLKN4suHSSz2fmTBPE6DSAq0EAd5uMLC
	 Eo+afajy+4wUsAoMCbiDbvi63k6hlq+GNnZGF+qElT8dBxROzXpo3Qlsel3eCTcqQX
	 E4NTWqpaN1Hncdpk1oqjb87LV0qVQNACNapZO/44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0D3EF80269;
	Mon, 11 Oct 2021 18:15:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ADBEF8028D; Mon, 11 Oct 2021 18:15:41 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DBF8F800C0
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 18:15:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DBF8F800C0
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="287788344"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="287788344"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 09:14:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="562278385"
Received: from cpeng4-mobl.amr.corp.intel.com (HELO [10.213.182.8])
 ([10.213.182.8])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 09:14:17 -0700
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5640: few cleanups
To: Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
 <3219a8c9-a9c8-25a9-95df-9aa5dbdf6815@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d4e5aca7-9ec1-6421-c3b5-b03983bd1bb5@linux.intel.com>
Date: Mon, 11 Oct 2021 09:19:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3219a8c9-a9c8-25a9-95df-9aa5dbdf6815@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
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


>> Andy Shevchenko (4):
>>   ASoC: Intel: bytcr_rt5640: Get platform data via dev_get_platdata()
>>   ASoC: Intel: bytcr_rt5640: Use temporary variable for struct device
>>   ASoC: Intel: bytcr_rt5640: use devm_clk_get_optional() for mclk
>>   ASoC: Intel: bytcr_rt5640: Utilize dev_err_probe() to avoid log
>>     saturation
> 
> Thanks, the entire series good to me, this one I've also
> given a quick test-spin, so:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> For the series.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

