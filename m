Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E3DC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 00:27:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A540E207CB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 00:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="imF+Pm7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A540E207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 058351771;
	Wed, 27 May 2020 02:26:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 058351771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590539225;
	bh=m7xEY3oMG8iAUInoNtcvof7Rkqkh7/KC6FVQPDTw9RQ=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imF+Pm7rLh0Wb9vYJL9kkBV8GT2A4xs5Q8xA4MC5OygaTDMYI2o7uWXJHBAoycmle
	 LAErpNNcVhqawMJ5GXmrzd6HFkbHBLaP6l0gP1udKEMoIEzhmaDdTiwuicqH4ZljGl
	 INYhvgQrjjzzB1n9/4HB+9azDKxETI3neAwrUOe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FAA8F80131;
	Wed, 27 May 2020 02:26:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C63FF8015C; Wed, 27 May 2020 02:26:13 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA127F80131
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 02:26:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA127F80131
IronPort-SDR: oCb+JP5u3R93AtxSn0IDpfi3AP4kK5an7XjdJ8bMvlYQVsLs3VTdjW07auY9JNS9hb17jEPHv9
 hUyjqdtd1qhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 17:26:03 -0700
IronPort-SDR: ObYCgt1MtabYB00HYWdkN+76K5Kh3aF4Ii3DgdAVqXx8tg4TSG42x1cd2ZfYzKL0hTX7lnqQKF
 GO+TCruwE7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; d="scan'208";a="255312584"
Received: from vivienne-mobl.ger.corp.intel.com ([10.251.132.190])
 by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 17:26:02 -0700
Message-ID: <c8f57c0ff243997075769f67761708e8bad45e8e.camel@linux.intel.com>
Subject: Re: [PATCH 02/19] ASoC: add soc-card.c
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Tue, 26 May 2020 17:26:02 -0700
In-Reply-To: <87eer7337h.wl-kuninori.morimoto.gx@renesas.com>
References: <87h7w3339l.wl-kuninori.morimoto.gx@renesas.com>
 <87eer7337h.wl-kuninori.morimoto.gx@renesas.com>
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

On Tue, 2020-05-26 at 10:16 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current ALSA SoC has some snd_soc_card_xxx() functions,
> and card->xxx() callbacks.
> But, it is implemented randomly at random place.
> 
> To collect all card related functions into one place,
> this patch creats new soc-card.c.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-card.h | 11 +++++++++++
>  include/sound/soc.h      |  1 +
>  sound/soc/Makefile       |  2 +-
>  sound/soc/soc-card.c     | 26 ++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 include/sound/soc-card.h
>  create mode 100644 sound/soc/soc-card.c
> 
> diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
> new file mode 100644
> index 000000000000..997809bb3afb
> --- /dev/null
> +++ b/include/sound/soc-card.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * soc-card.h
> + *
> + * Copyright (C) 2019 Renesas Electronics Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + */
> +#ifndef __SOC_CARD_H
> +#define __SOC_CARD_H
> +
> +#endif /* __SOC_CARD_H */
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 11ee3ed87aa1..5b880e29d106 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1450,5 +1450,6 @@ static inline void
> snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
>  }
>  
>  #include <sound/soc-component.h>
> +#include <sound/soc-card.h>
Morimoto-san,

soc-card.h should be added where it is needed. For example, in this
patch, it should be included in soc-card.c and in the following
patches, it should be included in soc-core.c, soc-dapm.c etc where it
is needed.

Thanks,
Ranjani

