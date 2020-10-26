Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC9C2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A2E207F7
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VrToiGdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A2E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04C1B169C;
	Tue, 27 Oct 2020 00:35:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04C1B169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603755388;
	bh=7HXpQTTCQEg8p3t216iokhURjG0oBhVL8jgPKoYPUbk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VrToiGdxc4iAFzpFtkSMgH7P3vHjc4zCUWhmZ6INXJWbYlUj3vIkG/Wffz1jgsBZe
	 CMgASohHZ1ZgkapFH4J+F/8F0snRl75bB5idKFajjZk7zYbMseIfyPzhbi10Fogp4y
	 yo38p1RK5lgAgMpxkgQ0eTOL/jeNAIrCVTkoB0J4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 691A5F80212;
	Tue, 27 Oct 2020 00:35:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6DCFF8025E; Tue, 27 Oct 2020 00:35:34 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F1E9F80086
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 00:35:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F1E9F80086
IronPort-SDR: OuO/zEacgqv75QQ+7J3uRZ83RVkJDuScwoex8x9CwOvDGLzZ8L334tzkjn4v6ikHGWWGEWzKSI
 SZ3Ae6XNaoNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="167220013"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; d="scan'208";a="167220013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 16:35:28 -0700
IronPort-SDR: Wy/LuMKPwNf18D0QFgq6hb9EeytvQuq6a+akzIesatlG+Vfr76cUY7Gitum4qiO6+BbSTzbpMv
 v+2rQpyxuDMw==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; d="scan'208";a="524475073"
Received: from tanguye1-mobl2.amr.corp.intel.com (HELO [10.209.126.195])
 ([10.209.126.195])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 16:35:25 -0700
Subject: Re: [PATCH v3] ASoC: Intel: boards: Add CML_RT1015 m/c driver
To: Keith Tzneg <matsufan@gmail.com>, alsa-devel@alsa-project.org
References: <1603515087-4092-1-git-send-email-keith.tzeng@quantatw.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0ade3e3c-c55d-d137-0af2-b2b32c16cfd7@linux.intel.com>
Date: Mon, 26 Oct 2020 14:22:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603515087-4092-1-git-send-email-keith.tzeng@quantatw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Libin Yang <libin.yang@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Fred Oh <fred.oh@linux.intel.com>,
 Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Naveen Manohar <naveen.m@intel.com>, Brent Lu <brent.lu@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, linux-kernel@vger.kernel.org
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



On 10/23/20 11:51 PM, Keith Tzneg wrote:
> From: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>
> 
> Machine driver to enable RT5682 on SSP0, DMIC, HDMI and RT1015 AMP on
> SSP1: Enabled 4 CH TDM playback with 24 bit data.

Same comment for the third time: there is no reason to add an entire 
machine driver just to replace one amplifier by another.

let's use an existing machine driver and use a quirk (DMI or table_id) 
to select the relevant amp for that device.

