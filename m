Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C307C10F14
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:44:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF64B2064A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IkY5sVk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF64B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 230131657;
	Thu, 10 Oct 2019 17:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 230131657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570722269;
	bh=8s2f41a9UCQP00vxxBpeTAAs7PjgzZl0i3L8J8XkgO8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IkY5sVk6ShZIesvTxIZBon6DjQ5yTAa96XPLox5f6QallK2Z2/qcJui0YnyvSPJxi
	 ZZeEXkXQkx02M2HmYJs18CX9Ujpd0ON1SujpxZTFy3dt9pDpFnwziM9lkdSjDRYXRN
	 JTC3uVINSex+lSkJ4WOX1nEAgJjOQL0LeQR9yfsg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB9D4F80633;
	Thu, 10 Oct 2019 17:41:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F0C9F80610; Thu, 10 Oct 2019 17:41:09 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20087F80447
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 17:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20087F80447
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 08:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="369125073"
Received: from aandraox-mobl1.amr.corp.intel.com (HELO [10.254.98.68])
 ([10.254.98.68])
 by orsmga005.jf.intel.com with ESMTP; 10 Oct 2019 08:41:02 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87sgo2ilso.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a11ccb66-1e7d-2967-586b-bd705494a798@linux.intel.com>
Date: Thu, 10 Oct 2019 10:38:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87sgo2ilso.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 00/21] ASoC: soc-core cleanup - step 4
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 10/8/19 11:29 PM, Kuninori Morimoto wrote:
> 
> Hi Mark
> Cc Pierre-Louis
> 
> These are step4 of soc-core cleanup.
> These related to soc-topology.
> If my understanding and my code are correct,
> there is no effect to topology side, but I can't test.
> 
> I'm not sure who can test these, but I guess
> Pierre-Louis knows ?
> Pierre-Louis, can you help it ?

This patchset was tested with the Intel SOF CI, and no regressions were 
seen.

Full results here: https://github.com/thesofproject/linux/pull/1298

I added a couple of comments to help improve commit messages or code. 
Nothing major, more about fixing inconsistencies than about broken code.

I could however not figure out if Patch 6 was correct or not, this is by 
far the most complicated in this series and additional folks more 
familiar with the code should look into it.

> 
> Kuninori Morimoto (21):
>    ASoC: soc-core: remove for_each_rtdcom_safe()
>    ASoC: soc-core: add for_each_rtd_components() and replace
>    ASoC: soc-core: move soc_init_dai_link()
>    ASoC: soc-core: rename soc_init_dai_link() to soc_dai_link_sanity_check()
>    ASoC: soc-core: remove duplicated soc_is_dai_link_bound()
>    ASoC: soc-core: call soc_bind_dai_link() under snd_soc_add_dai_link()
>    ASoC: soc-core: add soc_unbind_dai_link()
>    ASoC: soc-core: snd_soc_unbind_card() cleanup
>    ASoC: soc-core: remove unneeded snd_soc_tplg_component_remove()
>    ASoC: soc-core: move snd_soc_lookup_component()
>    ASoC: soc-core: add snd_soc_del_component()
>    ASoC: soc-core: use snd_soc_lookup_component() at snd_soc_unregister_component()
>    ASoC: soc-core: move snd_soc_register_dai()
>    ASoC: soc-core: have legacy_dai_naming at snd_soc_register_dai()
>    ASoC: soc-core: move snd_soc_unregister_dais()
>    ASoC: soc-core: add snd_soc_unregister_dai()
>    ASoC: soc-core: don't call snd_soc_dapm_new_dai_widgets() at snd_soc_register_dai()
>    ASoC: soc-core: use mutex_lock() at snd_soc_add_component()
>    ASoC: soc-core: call snd_soc_register_dai() from snd_soc_register_dais()
>    ASoC: soc-core: remove topology specific operation
>    ASoC: soc.h: dobj is used only when SND_SOC_TOPOLOGY
> 
>   include/sound/soc.h       |  25 ++-
>   sound/soc/soc-component.c |  43 +---
>   sound/soc/soc-compress.c  |  52 ++---
>   sound/soc/soc-core.c      | 542 ++++++++++++++++++++--------------------------
>   sound/soc/soc-pcm.c       |  49 ++---
>   sound/soc/soc-topology.c  |  32 ++-
>   6 files changed, 320 insertions(+), 423 deletions(-)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
