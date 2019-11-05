Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A2CA9ED3
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:49:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C910217F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nI2VkU3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C910217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C99B171A;
	Tue,  5 Nov 2019 03:48:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C99B171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572922183;
	bh=3NQ231ZtRV5dIRLdCdyj8vvkhxU91Jm6VclOfFRMLUo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nI2VkU3gBJHc+xQyukyZQhE1JNAgzEe5E6UoOhnEJq7xpZdnWvau2tYqLJyznNabT
	 Z/M7BQhtXmvos0QvENMja5ouu0KVnPIv6zBax8cUiXIbj1sHi4lsmE4eGa6U3tE2q4
	 0T34htF/HwfZbsDgLnxf1LpY5D5AZXjb6a00CXaI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5610F8060F;
	Tue,  5 Nov 2019 03:47:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9033F805E0; Tue,  5 Nov 2019 03:47:03 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD638F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 03:46:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD638F8015B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Nov 2019 18:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,269,1569308400"; d="scan'208";a="226952324"
Received: from demiho-mobl.amr.corp.intel.com (HELO [10.255.94.53])
 ([10.255.94.53])
 by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2019 18:46:54 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <874kzrdo1x.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e47765e3-ad11-fe5b-bec9-ae8e6022a193@linux.intel.com>
Date: Mon, 4 Nov 2019 20:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <874kzrdo1x.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 resend 00/18] ASoC: soc-core cleanup -
 step 4
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



On 10/29/19 8:23 PM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> These are resend of soc-core cleanup step4.
> These are based on mark/for-5.5 branch.
> I already got report from Intel that these had no issue on Intel CI machine.

In addition to the first pass of automatic testing on SOF-enabled 
devices, I double-checked the v2 code once more and didn't see any 
issues with the changes. Copying Ranjani and Kai in case they have spare 
cycles to have additional eyes on this large change.

The comments I have are on existing code that was moved, and the 
improvements could be handled as a follow-up patch. So for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Morimoto-san, this is a major clean-up. Nice work!

> 
> Kuninori Morimoto (18):
>    ASoC: soc-core: remove unneeded snd_soc_tplg_component_remove()
>    ASoC: soc-core: move soc_init_dai_link()
>    ASoC: soc-core: tidyup soc_init_dai_link()
>    ASoC: soc-core: remove duplicated soc_is_dai_link_bound()
>    ASoC: soc-core: call soc_bind_dai_link() under snd_soc_add_dai_link()
>    ASoC: soc-core: add soc_unbind_dai_link()
>    ASoC: soc-core: move snd_soc_lookup_component()
>    ASoC: soc-core: add snd_soc_del_component_unlocked()
>    ASoC: soc-core: remove snd_soc_component_add/del()
>    ASoC: soc-core: use snd_soc_lookup_component() at snd_soc_unregister_component()
>    ASoC: soc-core: move snd_soc_register_dai()
>    ASoC: soc-core: move snd_soc_unregister_dais()
>    ASoC: soc-core: add snd_soc_unregister_dai()
>    ASoC: soc-core: have legacy_dai_naming at snd_soc_register_dai()
>    ASoC: soc-core: don't call snd_soc_dapm_new_dai_widgets() at snd_soc_register_dai()
>    ASoC: soc-core: call snd_soc_register_dai() from snd_soc_register_dais()
>    ASoC: soc-core: remove topology specific operation
>    ASoC: soc.h: dobj is used only when SND_SOC_TOPOLOGY
> 
>   include/sound/soc.h      |  15 +-
>   sound/soc/soc-core.c     | 536 +++++++++++++++++++++--------------------------
>   sound/soc/soc-topology.c |  17 +-
>   3 files changed, 263 insertions(+), 305 deletions(-)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
