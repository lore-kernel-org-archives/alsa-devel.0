Return-Path: <SRS0=tzFk=HO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B970EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 23:49:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A2F64D9A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 23:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A2F64D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC2AA16DB;
	Sat, 13 Feb 2021 00:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC2AA16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613173786;
	bh=yMq/CURkJfGWo60L+k6MKC5giFeHU4d1X877pYRYhr0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RNuFGSnWp5IlTDdgr5oqblHZowrjIiECE8rH8Cpg+5HD7JASkGAW8aRfdJARFMIy1
	 Tp4M51XRsHJle1+MY6tJh0uHu+HwgUy17TEMokfp0l6Pw5rGnOwg1FNUE3pf6EU56F
	 s6pu/6ZGGeMQCysFdZiQy70AqNzt8/LmPO4U6zZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37D98F8016C;
	Sat, 13 Feb 2021 00:48:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 278B8F8022B; Sat, 13 Feb 2021 00:48:54 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FA1FF8014B
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2021 00:48:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FA1FF8014B
IronPort-SDR: ViuTlU/TeVCNkow1TTEPDiOeXTogwRzExA0mFV++aOujKSrAgGNQVoR7tBfMXJ0jHwWBH8ZdWu
 fAObjqWchWcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="267339770"
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; d="scan'208";a="267339770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 15:48:41 -0800
IronPort-SDR: JYkHhAzScdPh+HpQjCc6Wtrs6zS2GQDGau1p8E3VQ8dQqNuGiwOAD2rRUAgKvI+pbwfzaM2ZJ/
 TX2ctW0hOcbw==
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; d="scan'208";a="398194867"
Received: from jchatzix-mobl2.amr.corp.intel.com (HELO [10.212.157.251])
 ([10.212.157.251])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 15:48:40 -0800
Subject: Re: [PATCH 2/3] ASoC: soc-pcm: add soc_pcm_hw_update_chan()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87tuqs90rl.wl-kuninori.morimoto.gx@renesas.com>
 <87r1lw90oo.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <62f03ec8-7b9c-4550-d63d-cc50693e62fa@linux.intel.com>
Date: Fri, 12 Feb 2021 17:48:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1lw90oo.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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


> We have soc_pcm_hw_update_rate() now.
> This patch creates same function for chan.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch seems to break all SOF platforms. I tested manually to try 
and reproduce the CI results and it's indeed not so good:

root:~# speaker-test -Dhw:0,2 -c2 -r48000

speaker-test 1.2.4

Playback device is hw:0,2
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Playback open error: -22,Invalid argument

Git bisect points to this patch as the first bad commit.

I reverted patch 3 and patch 2 in this series in our tests and the 
results are back to normal.

see https://github.com/thesofproject/linux/pull/2755

results with these two patches included:

https://sof-ci.01.org/linuxpr/PR2755/build5289/devicetest/

Results with these two patches reverted:

https://sof-ci.01.org/linuxpr/PR2755/build5290/devicetest/

I will not have the time to dig further before the middle of next week, 
but I wanted to share the information in case Morimoto-san, Ranjani or 
Kai have ideas on what might have gone wrong?

