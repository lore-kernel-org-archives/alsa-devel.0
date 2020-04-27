Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C81C54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:02:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB322063A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CRBrm7VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB322063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1F0A168E;
	Mon, 27 Apr 2020 13:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1F0A168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587985336;
	bh=MWfAwFQg0hgvAV/UXTols4QxuZQuKuyOZo6FABoZqQ0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRBrm7VNwnemZwPLf0Hi5erE1Wusqs2b1V7y5Lbc8KM7hINUGMhGxqbFIz0sBrlO2
	 N5E4P0zB+sh+22Q1WmLqKvjq2lilU6TB78R1UlYLhK8Cqh1i5fB81uHkD5nc/L1ck0
	 yic5A4U8X+WLWR/hEIHDQg6HlMA2CF6rvaaKS+Mk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 470B9F8010A;
	Mon, 27 Apr 2020 13:01:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C414BF80217; Mon, 27 Apr 2020 13:01:24 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBD73F80113
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 13:01:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBD73F80113
IronPort-SDR: wV+MjeCBHOLCLG6BfsFv+91h8HuXBlrmZtBiSFD+9wZZp9qg+bViYlL1s8c3ck4XDuAKwuZm01
 A9TkskiBaSDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 04:01:18 -0700
IronPort-SDR: MWGPKE2LfyupxpqM1+pDGLkX2OftspcC8m2J3vn7tkq7q2JkA04hpyxaogOBIZP6x4OOVTOT0g
 vQWWsRvS9LyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; d="scan'208";a="302341415"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127])
 ([10.213.7.127])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 04:01:14 -0700
Subject: Re: [PATCH 0/3] add channel constraint for BDW machine drivers
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <1375d0b1-fafa-95b5-9a06-eefb1897ca42@intel.com>
Date: Mon, 27 Apr 2020 13:01:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>
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

On 2020-04-27 10:37, Brent Lu wrote:
> The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
> recording while other two drivers support only 2-channel recording. HW
> constraints are implemented to reflect the hardware limitation on BDW
> platform.
> 

Message body relates to bdw-rt5650 while the series touches every of BDW 
boards.

Apart from review given for each and every patch (although most issues 
are shared so there is not as much to address) my question is:
- are these hw limitations or software (machine board) limitations?

Czarek

> Brent Lu (3):
>    ASoC: bdw-rt5677: channel constraint support
>    ASoC: bdw-rt5650: channel constraint support
>    ASoC: broadwell: channel constraint support
> 
>   sound/soc/intel/boards/bdw-rt5650.c | 34 ++++++++++++++++++++++++++++++++++
>   sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
>   sound/soc/intel/boards/broadwell.c  | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+)
> 
