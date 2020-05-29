Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82AC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 23:18:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7CD20776
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 23:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YJw7GePn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7CD20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCF761768;
	Sat, 30 May 2020 01:17:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCF761768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590794319;
	bh=0nzKXha9ahCK3hp9GABydjoZeoPkJ8bmPcn8dOW+6OY=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YJw7GePn8tTdIpLb4+zm6J/R1aVFVYZl/TfLlYzjwBwbT495DWhTyrIoFsSm7RqKg
	 lP5QKlgAFsQfG/Z+3ew6T6+xp2KyiV/dVvKIFZXHncBamilUZc/rO57G8RUIleRr+7
	 JGR4xzC11CXKKTEH52wFR6tWwMfhvqM9VnF/GACY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C424F80149;
	Sat, 30 May 2020 01:17:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E093F8014E; Sat, 30 May 2020 01:17:47 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52A81F80125
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2020 01:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52A81F80125
IronPort-SDR: DyqHJBNr6ymM6BZzjc+Al+1KWp40hZHHfxFqZyaod+HDj518bMU2ieW8nsConRUYe4LP+boo4k
 0BzUNROaD9Aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 16:17:37 -0700
IronPort-SDR: YuQRfU79fYgxTG+sPiBk6JIUDKY653XaQUnh8Pp2ORqUadZJHg6PrgHKd9pB71T7gxJnStsUHA
 mCHL8ECH8w3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,450,1583222400"; d="scan'208";a="303276221"
Received: from kthorak-mobl.amr.corp.intel.com ([10.251.132.216])
 by orsmga008.jf.intel.com with ESMTP; 29 May 2020 16:17:37 -0700
Message-ID: <45c9ab01725eedef21ecebe1038b56bd163fa063.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/19] ASoC: add soc-card
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Fri, 29 May 2020 16:17:36 -0700
In-Reply-To: <87eer425lw.wl-kuninori.morimoto.gx@renesas.com>
References: <87eer425lw.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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

On Thu, 2020-05-28 at 10:47 +0900, Kuninori Morimoto wrote:
> Hi Mark
> 
> Current ALSA SoC is handling snd_soc_card related operation,
> but it is implmemented directly without using function/macro,
> and at random place.
> 
> This v2 patch-set creates new snd_soc_card_xxx() functions
> which handles snd_soc_card related operation,
> and implmement these at new soc-card.c.
> 
> v1 -> v2
> 
> 	- careed scripts/checkpatch.pl except for MAINTAINERS file
> update
> 	- added detail log at git-log, and/or comment at file.
> 	- cares "if (card)" under snd_soc_card_xxx()
> 
> Link: 
> https://lore.kernel.org/r/87h7w3339l.wl-kuninori.morimoto.gx@renesas.com
> 
> Kuninori Morimoto (19):
>    1 ASoC: soc.h: convert bool to bit field for snd_soc_card
>    2 ASoC: add soc-card.c
>    3 ASoC: soc-card: move snd_soc_card_get_kcontrol() to soc-card
>    4 ASoC: soc-card: move snd_soc_card_jack_new() to soc-card
>    5 ASoC: soc-card: move snd_soc_card_set/get_drvdata() to soc-card
>    6 ASoC: soc-card: move snd_soc_card_get_codec_dai() to soc-card
>    7 ASoC: soc-card: move snd_soc_card_subclass to soc-card
>    8 ASoC: soc-card: add snd_soc_card_suspend_pre()
>    9 ASoC: soc-card: add snd_soc_card_suspend_post()
>   10 ASoC: soc-card: add snd_soc_card_resume_pre()
>   11 ASoC: soc-card: add snd_soc_card_resume_post()
>   12 ASoC: soc-card: add probed bit field to snd_soc_card
>   13 ASoC: soc-card: add snd_soc_card_probe()
>   14 ASoC: soc-card: add snd_soc_card_late_probe()
>   15 ASoC: soc-card: add snd_soc_card_remove()
>   16 ASoC: soc-card: add snd_soc_card_set_bias_level()
>   17 ASoC: soc-card: add snd_soc_card_set_bias_level_post()
>   18 ASoC: soc-card: add snd_soc_card_add_dai_link()
>   19 ASoC: soc-card: add snd_soc_card_remove_dai_link()
LGTM, Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

