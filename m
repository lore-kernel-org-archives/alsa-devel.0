Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D14C432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:04:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998D16108E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 998D16108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15A1F17B8;
	Thu,  2 Sep 2021 17:03:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15A1F17B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630595039;
	bh=RmUt3ZSOY2UaR0DSsXKn+8mEapRgH6VP4RvO07h9Tss=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOfSmWauZE7+51bbyxmYSzTZu0Eb2ocSgb3wtxiYD4W0Scxhf7RcEC7x8HnKqtKYC
	 p+OGmiWGlp0RPhB2wlImrvCCJf4dRrvWC19PzB/u9N5m495LH1Z5bsP2qAFcRPcvcZ
	 pN2ecvLWL6KjDEreh+LvbwIEhG1xX8owpGlNBxgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5B73F80290;
	Thu,  2 Sep 2021 17:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACAC8F804B3; Thu,  2 Sep 2021 17:02:40 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8848F8028D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 17:02:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8848F8028D
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="219200573"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; d="scan'208";a="219200573"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 08:02:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; d="scan'208";a="689144054"
Received: from elee5-mobl.amr.corp.intel.com (HELO [10.212.50.6])
 ([10.212.50.6])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 08:02:19 -0700
Subject: Re: [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP
 select
To: Nathan Chancellor <nathan@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Fabio Aiuto <fabioaiuto83@gmail.com>
References: <20210802190351.3201677-1-nathan@kernel.org>
 <20210802212409.3207648-1-nathan@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <da246896-fbd3-be8d-355f-3c0a83e7d4eb@linux.intel.com>
Date: Thu, 2 Sep 2021 10:02:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210802212409.3207648-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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



On 8/2/21 4:24 PM, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> EXPERT [=n] && SOUNDWIRE [=y]
>   Selected by [y]:
>   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...
> 
> Selecting a symbol does not account for dependencies. There are three
> ways to resolve this:
> 
> 1. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH select
>    CONFIG_SND_SOC_SDW_MOCKUP only if CONFIG_EXPERT is set.
> 
> 2. Make CONFIG_SND_SOC_SDW_MOCKUP's prompt depend on CONFIG_EXPERT so
>    that it can be selected by options that only depend on
>    CONFIG_SOUNDWIRE but still appear as a prompt to the user when
>    CONFIG_EXPERT is set.
> 
> 3. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH imply
>    CONFIG_SND_SOC_SDW_MOCKUP, which will select
>    CONFIG_SND_SOC_SDW_MOCKUP when its dependencies are enabled but still
>    allow the user to disable it.
> 
> Go with the third option as it gives the most flexibility while
> retaining the original intent of the select.
> 
> Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
> Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This patch was missed, maybe because I didn't provide a formal ack on my
own suggestion, so here goes:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Mark, can you add it to 5.15 fixes please? Thank you.
-Pierre
