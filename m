Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FBC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 20:33:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174CE610A5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 174CE610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 788641674;
	Thu, 19 Aug 2021 22:32:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 788641674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629405184;
	bh=1Kg48ZCoPuU0dDhS+OtxNP178W9+2630q1o/kZ+5H9s=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJQW8vdj5rQ9StSFLk51Ex8Hr/EGpqC9jsyyaxaYteboFZZ1VBB8h58MrZ7p0v2/h
	 AgOykfRCt83dAjpCAdkqliIXLiSr/gdh2SPEUkEAAjUkdL6r6lrDIxDlWSXt9E0Fgl
	 MY8q67v4b6CiCNSQoJZhymOnDy+A4ev+LRzb0bO8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8A14F801EC;
	Thu, 19 Aug 2021 22:32:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7FCAF800EC; Thu, 19 Aug 2021 22:32:00 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A571AF800EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 22:31:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A571AF800EC
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277665018"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; d="scan'208";a="277665018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2021 13:31:44 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; d="scan'208";a="489883816"
Received: from mmdandap-mobl.amr.corp.intel.com (HELO [10.213.172.210])
 ([10.213.172.210])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2021 13:31:43 -0700
Subject: Re: [PATCH v2 0/6] ASoC: Intel/rt5640: Add support for HP Elite Pad
 1000G2 jack-detect
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20210819190543.784415-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6c148e7-3f1d-7f05-aae1-9d6928640593@linux.intel.com>
Date: Thu, 19 Aug 2021 15:31:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819190543.784415-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Bard Liao <bard.liao@intel.com>
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



On 8/19/21 2:05 PM, Hans de Goede wrote:
> Changes in v2:
> - Rebase on asoc/for-next
> - New patch: "ASoC: Intel: bytct_rt5640: Add a separate "Headset Mic 2"
>   DAPM pin for the mic on the 2nd jack"
> - Addressed Pierre-Louis' comments about calling
>   acpi_dev_add_driver_gpios() twice

Thanks Hans, the code in patch6 looks much simpler now.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Original cover-letter:
> 
> The HP Elitepad 1000 G2 tablet has 2 headset jacks:
> 
> 1. on the dock which uses the output of the codecs built-in HP-amp +
> the standard IN2 input which is always used with the headset-jack.
> 
> 2. on the tablet itself, this uses the line-out of the codec + an external
> HP-amp, which gets enabled by the ALC5642 codec's GPIO1 pin; and IN1 for
> the headset-mic.
> 
> The codec's GPIO1 is also its only IRQ output pin, so this means that
> the codec's IRQ cannot be used on this tablet. Instead the jack-detect
> is connected directly to GPIOs on the main SoC. The dock has a helper
> chip which also detects if a headset-mic is present or not, so there
> are 2 GPIOs for the jack-detect status of the dock. The tablet jack
> uses a single GPIO which indicates if a jack is present or not.
> 
> Differentiating between between headphones vs a headset on the tablet jack
> is done by using the usual mic-bias over-current-detection mechanism.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (6):
>   ASoC: rt5640: Move rt5640_disable_jack_detect() up in the rt5640.c
>     file
>   ASoC: rt5640: Delay requesting IRQ until the machine-drv calls
>     set_jack
>   ASoC: rt5640: Add optional hp_det_gpio parameter to
>     rt5640_detect_headset()
>   ASoC: rt5640: Add rt5640_set_ovcd_params() helper
>   ASoC: Intel: bytct_rt5640: Add a separate "Headset Mic 2" DAPM pin for
>     the mic on the 2nd jack
>   ASoC: Intel: bytcr_rt5640: Add support for HP Elite Pad 1000G2
>     jack-detect
> 
>  sound/soc/codecs/rt5640.c             | 136 ++++++++++++----------
>  sound/soc/codecs/rt5640.h             |   6 +
>  sound/soc/intel/boards/bytcr_rt5640.c | 158 +++++++++++++++++++++++++-
>  3 files changed, 234 insertions(+), 66 deletions(-)
> 
