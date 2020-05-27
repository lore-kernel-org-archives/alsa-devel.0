Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A7C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 00:25:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DAD207CB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 00:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sq0h99Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DAD207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E1A7178A;
	Wed, 27 May 2020 02:24:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E1A7178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590539120;
	bh=IQKwHcxyrmhTHdV+Oe2Q3QLIW3rTj974qIBS8GN0NEw=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sq0h99EiQTjhJWRQK3o/A5Umg4VjcaHaBfaCpy8sEDCQgP2BIWDfypEbNUKfjMZ4r
	 2LubXAFA9FGJg10p2W/iprBj5jumJrTQf3+QfCdzbVdjJqc17aJdlK5lXnuVoQSkKi
	 yUoSkjcJPCyGEl0bECNByN/Xj6XnrIo0d43pzKlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AC05F8015D;
	Wed, 27 May 2020 02:24:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA6E8F80161; Wed, 27 May 2020 02:24:13 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30941F8015C
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 02:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30941F8015C
IronPort-SDR: hoIAiwHip7XqBCeJT+SGqb6kPxHiTIKa9BkAOsyIWuz8xAJDIgLm+s+U+alE9tvVVCI2p5xN+G
 NRy9u41xxItQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 17:24:00 -0700
IronPort-SDR: C6YNHlcba1CAfRo/eNVqvYJwh88RWqgWa9Nhyd92i79MMlb1JD/aG3hckpbfCRC7FUzizhBQBs
 q2t5CVxJ4B2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; d="scan'208";a="255312065"
Received: from vivienne-mobl.ger.corp.intel.com ([10.251.132.190])
 by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 17:24:00 -0700
Message-ID: <8fde36670a1f1801e2efca30315d6934661e3620.camel@linux.intel.com>
Subject: Re: [PATCH 17/19] ASoC: soc-card: add
 snd_soc_card_set_bias_level_post()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Tue, 26 May 2020 17:24:00 -0700
In-Reply-To: <87sgfn1oj8.wl-kuninori.morimoto.gx@renesas.com>
References: <87h7w3339l.wl-kuninori.morimoto.gx@renesas.com>
 <87sgfn1oj8.wl-kuninori.morimoto.gx@renesas.com>
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

On Tue, 2020-05-26 at 10:19 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Card related function should be implemented at soc-card now.
> This patch adds it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-card.h |  3 +++
>  sound/soc/soc-card.c     | 12 ++++++++++++
>  sound/soc/soc-dapm.c     |  4 ++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
> index 4bcdc1d382bf..54341e4d818a 100644
> --- a/include/sound/soc-card.h
> +++ b/include/sound/soc-card.h
> @@ -31,6 +31,9 @@ int snd_soc_card_remove(struct snd_soc_card *card);
>  int snd_soc_card_set_bias_level(struct snd_soc_card *card,
>  				struct snd_soc_dapm_context *dapm,
>  				enum snd_soc_bias_level level);
> +int snd_soc_card_set_bias_level_post(struct snd_soc_card *card,
> +				     struct snd_soc_dapm_context *dapm,
> +				     enum snd_soc_bias_level level);
>  
>  /* device driver data */
>  static inline void snd_soc_card_set_drvdata(struct snd_soc_card
> *card,
> diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
> index a9f25b6a4c67..8db3b98d1c80 100644
> --- a/sound/soc/soc-card.c
> +++ b/sound/soc/soc-card.c
> @@ -184,3 +184,15 @@ int snd_soc_card_set_bias_level(struct
> snd_soc_card *card,
>  
>  	return soc_card_ret(card, ret);
>  }
> +
> +int snd_soc_card_set_bias_level_post(struct snd_soc_card *card,
> +				     struct snd_soc_dapm_context *dapm,
> +				     enum snd_soc_bias_level level)
> +{
> +	int ret = 0;
> +
> +	if (card->set_bias_level_post)
> +		ret = card->set_bias_level_post(card, dapm, level);
> +
> +	return soc_card_ret(card, ret);
> +}
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index add39d24a583..af457ee5ef83 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -736,8 +736,8 @@ static int snd_soc_dapm_set_bias_level(struct
> snd_soc_dapm_context *dapm,
>  	if (ret != 0)
>  		goto out;
>  
> -	if (card && card->set_bias_level_post)
> -		ret = card->set_bias_level_post(card, dapm, level);
> +	if (card)
> +		ret = snd_soc_card_set_bias_level_post(card, dapm,
> level);
same here too. We can move the check to
snd_soc_card_set_bias_level_post() and remove the first parameter?

Thanks,
Ranjani

