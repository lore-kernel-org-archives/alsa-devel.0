Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36060C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:32:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B238D22482
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VqlX/Js/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B238D22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25EEE1657;
	Mon, 20 Jul 2020 17:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25EEE1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595259155;
	bh=DMG9M4u3P08fPuxzipprLOQ6gXUcdtXcvdypM0upuLU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqlX/Js/5OpRzlk6a1Rslp2/tppHnfj97E6JPTWHmWTomuX0fV8/Jz4xBb1OfGUlC
	 J6Pum9XCACwrVZVryHrMV0SEQji6Q67ZBvsVqBemsnCFR45KCOVaAHL1V7P1LD7bRf
	 SiBz8OFAA2OB9QpKMle1xmU3PnpVjyH16K5rdIGY=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0406F80141;
	Mon, 20 Jul 2020 17:31:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDCFEF80141; Mon, 20 Jul 2020 17:30:56 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21BD4F800CE
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 17:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21BD4F800CE
IronPort-SDR: Xopap6Jh+Wf4B1SYA0vqqii0wZOBaHZPqCDIlVM+CiOlsfu/UaZ/YEiznP+6PUMnWWUCTwJ+aV
 fSQaC1A0EpYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214613589"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="214613589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 08:30:26 -0700
IronPort-SDR: mD4j0UmBgycKzXUhVcl7OV6w2ci3TO/7/0bO22HYXh1cE/51POfBOOSiAYp9POapsRt/I0zoyi
 llZMqqGbtKYw==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="326090839"
Received: from unknown (HELO [10.254.115.28]) ([10.254.115.28])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 08:30:26 -0700
Subject: Re: [PATCH 19/29] ASoC: intel: use asoc_substream_to_rtd()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87y2nf0yw2.wl-kuninori.morimoto.gx@renesas.com>
 <877duz0ysw.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d87417b1-5bc3-9ad0-a362-0e7e1bb03f67@linux.intel.com>
Date: Mon, 20 Jul 2020 10:17:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <877duz0ysw.wl-kuninori.morimoto.gx@renesas.com>
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



On 7/19/20 8:19 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now we can use asoc_substream_to_rtd() macro,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

LGTM. If there's a v2, maybe split the boards/ directory changes from 
the other platform driver changes to help with backports/tests?

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Morimoto-san.

> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c     |  6 +++---
>   sound/soc/intel/baytrail/sst-baytrail-pcm.c      | 16 ++++++++--------
>   sound/soc/intel/boards/bdw-rt5650.c              |  2 +-
>   sound/soc/intel/boards/bdw-rt5677.c              |  4 ++--
>   sound/soc/intel/boards/broadwell.c               |  2 +-
>   sound/soc/intel/boards/bxt_rt298.c               |  2 +-
>   sound/soc/intel/boards/byt-rt5640.c              |  2 +-
>   sound/soc/intel/boards/bytcht_da7213.c           |  4 ++--
>   sound/soc/intel/boards/bytcr_rt5640.c            |  2 +-
>   sound/soc/intel/boards/bytcr_rt5651.c            |  2 +-
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c     |  2 +-
>   sound/soc/intel/boards/cht_bsw_nau8824.c         |  2 +-
>   sound/soc/intel/boards/cht_bsw_rt5645.c          |  2 +-
>   sound/soc/intel/boards/cht_bsw_rt5672.c          |  2 +-
>   sound/soc/intel/boards/cml_rt1011_rt5682.c       |  4 ++--
>   sound/soc/intel/boards/ehl_rt5660.c              |  2 +-
>   sound/soc/intel/boards/glk_rt5682_max98357a.c    |  2 +-
>   sound/soc/intel/boards/haswell.c                 |  2 +-
>   sound/soc/intel/boards/kbl_da7219_max98927.c     |  8 ++++----
>   sound/soc/intel/boards/kbl_rt5660.c              |  2 +-
>   sound/soc/intel/boards/kbl_rt5663_max98927.c     |  4 ++--
>   .../intel/boards/kbl_rt5663_rt5514_max98927.c    |  4 ++--
>   sound/soc/intel/boards/skl_nau88l25_max98357a.c  |  2 +-
>   sound/soc/intel/boards/skl_nau88l25_ssm4567.c    |  2 +-
>   sound/soc/intel/boards/skl_rt286.c               |  2 +-
>   sound/soc/intel/boards/sof_da7219_max98373.c     |  2 +-
>   sound/soc/intel/boards/sof_maxim_common.c        |  4 ++--
>   sound/soc/intel/boards/sof_pcm512x.c             |  4 ++--
>   sound/soc/intel/boards/sof_rt5682.c              |  4 ++--
>   sound/soc/intel/boards/sof_sdw_rt1308.c          |  2 +-
>   sound/soc/intel/boards/sof_wm8804.c              |  2 +-
>   sound/soc/intel/haswell/sst-haswell-pcm.c        | 12 ++++++------
>   sound/soc/intel/keembay/kmb_platform.c           |  2 +-
>   sound/soc/intel/skylake/skl-pcm.c                |  8 ++++----
>   34 files changed, 62 insertions(+), 62 deletions(-)

