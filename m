Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23267C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:25:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A194020801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GOtOPMet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A194020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D577B1686;
	Tue, 18 Feb 2020 18:24:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D577B1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582046725;
	bh=C/LRkYWdX6wxiYiNDVoMyIi3O5/6Xmei2Ghg+RE+6fQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOtOPMetGEi4HH7i+mU9i4Rrvce0DwpD6dWKNc6FkEwIbbA0Rcj2MMOrdW1rO3g72
	 VhqeRUEIAiAmfRWEpXQrwNlz6fT7veE8QNVrNrYAieQttwI/XUgGM4RFxjKy0RsO/U
	 47iPCslnNQzZDLbktptLJncfQTgQdg9Cv1WoJrKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 214F4F8014A;
	Tue, 18 Feb 2020 18:24:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73DCEF8014A; Tue, 18 Feb 2020 18:24:33 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF6AFF80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 18:24:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF6AFF80137
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 09:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; d="scan'208";a="408136585"
Received: from bmerugul-mobl1.amr.corp.intel.com (HELO [10.251.159.61])
 ([10.251.159.61])
 by orsmga005.jf.intel.com with ESMTP; 18 Feb 2020 09:24:25 -0800
Subject: Re: [alsa-devel] [PATCH v4 00/18] ASoC: soc-pcm cleanup step3
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87imk5bovg.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cab66798-bf11-25cc-f6de-7eb50a1d52f0@linux.intel.com>
Date: Tue, 18 Feb 2020 09:56:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87imk5bovg.wl-kuninori.morimoto.gx@renesas.com>
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



On 2/17/20 2:27 AM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> These are v4 of soc-pcm cleanup step3.
> Main change from v3 is that
> 	- tidyup Subject on [10/18] patch
> 	- added Takashi's Reviewed-by / Acked-by on [10/18], [18/18]

For the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thank you Morimoto-san, nice cleanup!

> Kuninori Morimoto (18):
>     1) ASoC: soc-pcm: move dai_get_widget()
>     2) ASoC: soc-pcm: use dai_get_widget() at dpcm_get_be()
>     3) ASoC: soc-pcm: use dai_get_widget() at dpcm_end_walk_at_be()
>     4) ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()
>     5) ASoC: soc-pcm: remove soc_dpcm_be_digital_mute()
>     6) ASoC: soc-pcm: remove snd_soc_dpcm_be_get/set_state()
>     7) ASoC: soc-pcm: add snd_soc_dpcm_can_be() and remove duplicate code
>     8) ASoC: soc-pcm: use goto and remove multi return
>     9) ASoC: soc-pcm: merge playback/cature_active into stream_active
>    10) ASoC: soc.h: add for_each_pcm_streams()
>    11) ASoC: soc-core: use for_each_pcm_streams() macro
>    12) ASoC: soc-pcm: use for_each_pcm_streams() macro
>    13) ASoC: soc-generic-dmaengine-pcm: use for_each_pcm_streams() macro
>    14) ASoC: dwc: dwc-i2s: use for_each_pcm_streams() macro
>    15) ASoC: fsl: fsl_asrc_dma: use for_each_pcm_streams() macro
>    16) ASoC: qcom: lpass-platform: use for_each_pcm_streams() macro
>    17) ASoC: sof: sof-audio: use for_each_pcm_streams() macro
>    18) ALSA: usx2y: use for_each_pcm_streams() macro
> 
>   include/sound/pcm.h                   |   5 +
>   include/sound/soc-dai.h               |   3 +-
>   include/sound/soc-dpcm.h              |   9 -
>   sound/soc/codecs/cs4271.c             |   4 +-
>   sound/soc/dwc/dwc-i2s.c               |   8 +-
>   sound/soc/fsl/fsl_asrc_dma.c          |   4 +-
>   sound/soc/qcom/lpass-platform.c       |   2 +-
>   sound/soc/soc-core.c                  |  48 ++--
>   sound/soc/soc-generic-dmaengine-pcm.c |   8 +-
>   sound/soc/soc-pcm.c                   | 327 +++++++++-----------------
>   sound/soc/sof/sof-audio.c             |  19 +-
>   sound/usb/usx2y/usbusx2yaudio.c       |   9 +-
>   12 files changed, 162 insertions(+), 284 deletions(-)
> 
