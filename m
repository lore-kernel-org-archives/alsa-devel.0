Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CC8C001DC
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 15:20:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA417823;
	Mon, 31 Jul 2023 17:19:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA417823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690816811;
	bh=tHseUDP5ewIZ91U0WgZQH8SlyWmcwyeqJNAjRGZdQ4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hMy9bcEAV4ne3jL8YqgXTnGMG848wa3lbEyFfJqHKscRruX7i8MGWJiBOhxXnBrPD
	 WOFgl63aMqUrVlUdfhdORtJcDMTAr+6RPMsFwIHztkDk9exrXJkze8EN1dR89bwhm3
	 uzU7UOidtQtJQ1O2e3C6F3N93EP8FqMF7ZSN6Zu0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E066F80520; Mon, 31 Jul 2023 17:18:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02EF5F8016D;
	Mon, 31 Jul 2023 17:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26D9FF8016D; Mon, 31 Jul 2023 17:18:50 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E32D7F8015B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 17:18:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E32D7F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CL2F+Ja9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690816725; x=1722352725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tHseUDP5ewIZ91U0WgZQH8SlyWmcwyeqJNAjRGZdQ4c=;
  b=CL2F+Ja9U1U4HAJ/aO4OMuQAv+lkkVYWA9rPwQCpX6LlKYHiaZAjpSmY
   4y+ELLALu7Jz47b1ejZ0Bpq+mFZJyAUvh542zvWabj1TdFdhAMY15xxRE
   qt/qobvu/liCD51NjC/mnnxwJeyMQdTjJw78LsHU1N82rfXwDuAiQe4/h
   PzYkoE0mKU9mSZ6HNjR+HJPnyPP/Fi5hhJ9XWt2uHNFQV31bvgKFvI4vu
   zDtky/P0GWsKjlMl+/uqph6XRQz9fwtjS/323A4sVdeoatKAwJ8ZxGbYe
   e1Yhycai6dk9IUzt/sn3ZOl2292w1UQBQt5KcOUx4aAGUZlNNu6WeQATc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432863979"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200";
   d="scan'208";a="432863979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 08:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852095057"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200";
   d="scan'208";a="852095057"
Received: from sambriz-mobl.amr.corp.intel.com (HELO [10.212.68.117])
 ([10.212.68.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 08:18:33 -0700
Message-ID: <f3b6e859-3cf1-e12c-4de7-83cce04a122f@linux.intel.com>
Date: Mon, 31 Jul 2023 09:53:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/1] ASoC: Intel: maxim-common: get codec number from
 ACPI table
Content-Language: en-US
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 Yong Zhi <yong.zhi@intel.com>, Terry Cheong <htcheong@chromium.org>,
 Uday M Bhat <uday.m.bhat@intel.com>, Mac Chiang <mac.chiang@intel.com>,
 "Dharageswari . R" <dharageswari.r@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 ye xingchen <ye.xingchen@zte.com.cn>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230731103419.2536036-1-brent.lu@intel.com>
 <20230731103419.2536036-2-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230731103419.2536036-2-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: KHZBG4BEQFB5UUHRSW7RAUO6BD2PPTIY
X-Message-ID-Hash: KHZBG4BEQFB5UUHRSW7RAUO6BD2PPTIY
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KHZBG4BEQFB5UUHRSW7RAUO6BD2PPTIY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/31/23 05:34, Brent Lu wrote:
> We implement a helper function to get number of codecs from ACPI
> subsystem instead of using quirk flag in machine driver. Also refactor
> module interface by adding max_98390_dai_link() function.
> 
> On the sof_rt5682 machine driver side, we remove the quirk flag
> SOF_MAX98390_TWEETER_SPEAKER_PRESENT and use the new interface of
> max98390 to setup dai link.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
