Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541A3C4332E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:02:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F4B2051A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bvTLdZo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F4B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0322F86E;
	Mon, 23 Mar 2020 20:02:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0322F86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584990176;
	bh=ac2edYEg+RKc8ksXG875oRUxcXoUEZM9JWsIZILY/6w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvTLdZo9FPojPNqoh0C2hdMEdwAbBTiYoaYhZcrh5EOdk2tXTUWeNzIo0UBGtL0pL
	 +07Zph0l5is7GtvAxcLZeMgW9uGDeTN4MxFAyU3f1dC+lH5Dhgx3jTotBkkim6/uSq
	 hwoWKULR0vFgtMQRyOqFScYVUtiOacLhfptqqEJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D1B2F80147;
	Mon, 23 Mar 2020 20:02:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8089FF80158; Mon, 23 Mar 2020 20:02:03 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E302AF80095
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 20:01:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E302AF80095
IronPort-SDR: kKuUrekxZ8wXWebVsEki6MbrJv//DotQhBqsNsGp6Gmr6/f4eLwFy/SncrXNkSaVWpJdOrAeOI
 s5M6kNX1kQBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 12:01:49 -0700
IronPort-SDR: K0zF8UJgqBE+5xR6d25kahDUFcosBh29Q+LpiT+IFt3vIRrWgPH00lTJMK+1+myKDODUD7t1D9
 b6TRmcYVug1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; d="scan'208";a="393010273"
Received: from ykim11-mobl1.amr.corp.intel.com (HELO [10.255.34.170])
 ([10.255.34.170])
 by orsmga004.jf.intel.com with ESMTP; 23 Mar 2020 12:01:48 -0700
Subject: Re: [PATCH 36/36] ASoC: soc-core: remove
 cpu_dai/codec_dai/cpu_dais/codec_dais
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <877dzbk5wm.wl-kuninori.morimoto.gx@renesas.com>
 <87r1xjhch2.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba9abc6a-e0e0-edc0-6bac-d68a042d95c9@linux.intel.com>
Date: Mon, 23 Mar 2020 13:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1xjhch2.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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



On 3/23/20 12:22 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> No-one is using cpu_dai/codec_dai/cpu_dais/codec_dais.
> Let's remove these from snd_soc_pcm_runtime

No objections, but to avoid short-term compilation issues for everyone 
could we delay this removal or make this conditionally-compiled for some 
time?

Thanks!
