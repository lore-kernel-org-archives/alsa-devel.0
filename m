Return-Path: <SRS0=quTn=OE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C3C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 19:36:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657D1610CE
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 19:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 657D1610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FD591841;
	Tue, 14 Sep 2021 21:35:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FD591841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631648175;
	bh=wfeKGu8NqlrZztBe5AK0WC8JshhFLxKZHMH3eBTuf+w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DLt8mfq/tWRz3Q6SXwWcIRztorcVLUoV/804gEAHtRL03KdVdPPdAG8wPBFaVsX04
	 e2KV9N2zk/uEXu1sgmxHXBK3V3pNWDdsdn+HO4GL4h+LnqmSBKc630CErr/gHz3RYU
	 8C730upCdWzAvzvPuBk5U7sMuZmcVdQWbNGqcuKg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E8C0F8025A;
	Tue, 14 Sep 2021 21:35:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E5F7F8025E; Tue, 14 Sep 2021 21:35:15 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDD66F80169
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 21:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDD66F80169
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="285800483"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; d="scan'208";a="285800483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2021 12:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; d="scan'208";a="544252949"
Received: from tjohn2x-mobl.amr.corp.intel.com (HELO [10.209.157.105])
 ([10.209.157.105])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2021 12:34:59 -0700
Subject: Re: [PATCH 0/4] Support ALC5682I-VS codec
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20210914101847.778688-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fccf7093-07fe-c8bc-96f8-39670fa56de0@linux.intel.com>
Date: Tue, 14 Sep 2021 11:07:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914101847.778688-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Nathan Chancellor <nathan@kernel.org>,
 Tzung-Bi Shih <tzungbi@google.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Rander Wang <rander.wang@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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



On 9/14/21 5:18 AM, Brent Lu wrote:
> Support the ALC5682I-VS codec in Intel's rt5682 machine driver with
> three board configurations.
> 
> Brent Lu (4):
>   ASoC: Intel: sof_rt5682: support ALC5682I-VS codec
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015p board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015 board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_mx98360a board
> 
>  sound/soc/intel/boards/Kconfig                |   1 +
>  sound/soc/intel/boards/sof_rt5682.c           | 105 +++++++++++++++---
>  .../intel/common/soc-acpi-intel-jsl-match.c   |  24 ++++
>  3 files changed, 112 insertions(+), 18 deletions(-)

Looks good to me, the number of permutations is starting to be hard to
track but at least it's in the same machine driver...

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
