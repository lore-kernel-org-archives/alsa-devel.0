Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A54C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:53:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DC020639
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WwFoSfAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DC020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3546617BE;
	Mon,  5 Oct 2020 17:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3546617BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601913197;
	bh=XyAswjGl1+AYf8QQdZpsv169y/IjTI9r//cKvAAg/Lg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WwFoSfAyZXzUfKEYd0w5mgTi3UdjvKqim9WsmFS3Hz1oZRbSmK6gnQOjhqPpJk2pJ
	 O+j+PIoY67gRzFgLZSWyxrj0diCnMO+Sd2r2os+caIHL+rQnsuKj/fmM38RrnAPdEI
	 prawOPVwHDNRV6meiByGFR3vragbZU2UfobEOHIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08515F8026A;
	Mon,  5 Oct 2020 17:51:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7EF8F80121; Mon,  5 Oct 2020 17:51:33 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACF6AF80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 17:51:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACF6AF80121
IronPort-SDR: v406vzlq/aXPSHq//QISs9xj2hUyGyHNRztZjHWuH2YlCOanvqb8dqUBcGywQW0Sbjv4QOc3hi
 KfJXOC9o12Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="143657278"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; d="scan'208";a="143657278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP; 05 Oct 2020 08:51:21 -0700
IronPort-SDR: 7mGhxjst/aYyesI4X0LHECsYlaQJ8AY0/qiQla9KWIDqRdnC3phyLVktIGVDK9hhLKKLG2nYMz
 CqsNkOEyrCqQ==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; d="scan'208";a="417308274"
Received: from srembels-mobl1.amr.corp.intel.com (HELO [10.212.125.28])
 ([10.212.125.28])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2020 08:51:14 -0700
Subject: Re: [PATCH 00/13] ASoC: Intel: Remove obsolete solutions and
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20201004100128.5842-1-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6755ac80-5b90-f7b4-17b3-f6247257c1f0@linux.intel.com>
Date: Mon, 5 Oct 2020 10:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201004100128.5842-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: andriy.shevchenko@linux.intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, marcin.barlik@intel.com, zwisler@google.com,
 tiwai@suse.com, lgirdwood@gmail.com, filip.proborszcz@intel.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 krzysztof.hejmowski@intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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



On 10/4/20 5:01 AM, Cezary Rojewski wrote:
> Follow up to catpt series as mentioned in:
> [PATCH v10 00/14] ASoC: Intel: Catpt - Lynx and Wildcat point
> https://www.spinics.net/lists/alsa-devel/msg116440.html
> 
> As catpt is a direct replacement to sound/soc/intel/haswell, it leaves a
> lot of code redudant. The second legacy solution - baytrail - is
> deprecated for a long time by sound/soc/intel/atom with SOF flavor
> available too.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I would go one step further and start deprecating sound/soc/intel/atom/ 
to use SOF instead. That atom/ thing is maintained only to the extent 
that static analysis tools report errors. Likewise there are no 
commercial platforms based on the haswell silicon so we could also only 
support Broadwell.

Thanks Cezary.

> 
> This series addresses the redudancy and removes obsolete code. Along
> with the legacy solutions, all orphaned components are removed too.
> 
> As a consequence, further cleanups are unlocked: sound/soc/intel/skylake
> becomes the sole user of processing code found in
> sound/soc/intel/common. Those are not part of this series.
> 
> Cezary Rojewski (13):
>    ASoC: Intel: Remove haswell solution
>    ASoC: Intel: Remove max98090 support for baytrail solution
>    ASoC: Intel: Remove rt5640 support for baytrail solution
>    ASoC: Intel: Remove baytrail solution
>    ASoC: Intel: Remove SST ACPI component
>    ASoC: Intel: Remove SST firmware components
>    ASoC: Intel: Skylake: Unassign ram_read and read_write ops
>    ASoC: Intel: Remove unused DSP operations
>    ASoC: Intel: Remove unused DSP interface fields
>    ASoC: Intel: Remove SST-legacy specific constants
>    ASoC: Intel: Make atom components independent of sst-dsp
>    ASoC: Intel: Remove sst_pdata structure
>    ASoC: Intel: Remove sst_dsp_get_thread_context
> 
>   include/sound/soc-acpi-intel-match.h          |    1 -
>   include/trace/events/hswadsp.h                |  385 ---
>   sound/soc/intel/Kconfig                       |   26 -
>   sound/soc/intel/Makefile                      |    1 -
>   sound/soc/intel/atom/sst/sst.c                |    1 -
>   sound/soc/intel/atom/sst/sst.h                |    7 +
>   sound/soc/intel/atom/sst/sst_acpi.c           |    1 -
>   sound/soc/intel/atom/sst/sst_drv_interface.c  |    3 -
>   sound/soc/intel/atom/sst/sst_ipc.c            |    1 -
>   sound/soc/intel/atom/sst/sst_loader.c         |    1 -
>   sound/soc/intel/atom/sst/sst_pvt.c            |    1 -
>   sound/soc/intel/atom/sst/sst_stream.c         |    1 -
>   sound/soc/intel/baytrail/Makefile             |    5 -
>   sound/soc/intel/baytrail/sst-baytrail-dsp.c   |  358 ---
>   sound/soc/intel/baytrail/sst-baytrail-ipc.c   |  772 ------
>   sound/soc/intel/baytrail/sst-baytrail-ipc.h   |   64 -
>   sound/soc/intel/baytrail/sst-baytrail-pcm.c   |  459 ----
>   sound/soc/intel/boards/Kconfig                |   25 -
>   sound/soc/intel/boards/Makefile               |    4 -
>   sound/soc/intel/boards/byt-max98090.c         |  182 --
>   sound/soc/intel/boards/byt-rt5640.c           |  224 --
>   sound/soc/intel/boards/bytcht_es8316.c        |    1 -
>   sound/soc/intel/boards/bytcr_rt5640.c         |    1 -
>   sound/soc/intel/common/Makefile               |    4 -
>   .../intel/common/soc-acpi-intel-byt-match.c   |   15 -
>   sound/soc/intel/common/sst-acpi.c             |  236 --
>   sound/soc/intel/common/sst-dsp-priv.h         |  284 +--
>   sound/soc/intel/common/sst-dsp.c              |  162 --
>   sound/soc/intel/common/sst-dsp.h              |  222 --
>   sound/soc/intel/common/sst-firmware.c         | 1273 ----------
>   sound/soc/intel/common/sst-ipc.c              |   27 -
>   sound/soc/intel/common/sst-ipc.h              |    3 -
>   sound/soc/intel/haswell/Makefile              |    5 -
>   sound/soc/intel/haswell/sst-haswell-dsp.c     |  705 ------
>   sound/soc/intel/haswell/sst-haswell-ipc.c     | 2222 -----------------
>   sound/soc/intel/haswell/sst-haswell-ipc.h     |  527 ----
>   sound/soc/intel/haswell/sst-haswell-pcm.c     | 1369 ----------
>   sound/soc/intel/skylake/bxt-sst.c             |    2 -
>   sound/soc/intel/skylake/cnl-sst.c             |    4 +-
>   sound/soc/intel/skylake/skl-sst-dsp.c         |    2 +-
>   sound/soc/intel/skylake/skl-sst-ipc.c         |    2 +-
>   sound/soc/intel/skylake/skl-sst.c             |    2 -
>   42 files changed, 11 insertions(+), 9579 deletions(-)
>   delete mode 100644 include/trace/events/hswadsp.h
>   delete mode 100644 sound/soc/intel/baytrail/Makefile
>   delete mode 100644 sound/soc/intel/baytrail/sst-baytrail-dsp.c
>   delete mode 100644 sound/soc/intel/baytrail/sst-baytrail-ipc.c
>   delete mode 100644 sound/soc/intel/baytrail/sst-baytrail-ipc.h
>   delete mode 100644 sound/soc/intel/baytrail/sst-baytrail-pcm.c
>   delete mode 100644 sound/soc/intel/boards/byt-max98090.c
>   delete mode 100644 sound/soc/intel/boards/byt-rt5640.c
>   delete mode 100644 sound/soc/intel/common/sst-acpi.c
>   delete mode 100644 sound/soc/intel/common/sst-firmware.c
>   delete mode 100644 sound/soc/intel/haswell/Makefile
>   delete mode 100644 sound/soc/intel/haswell/sst-haswell-dsp.c
>   delete mode 100644 sound/soc/intel/haswell/sst-haswell-ipc.c
>   delete mode 100644 sound/soc/intel/haswell/sst-haswell-ipc.h
>   delete mode 100644 sound/soc/intel/haswell/sst-haswell-pcm.c
> 
