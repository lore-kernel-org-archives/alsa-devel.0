Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD5C4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:40:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3123920B7C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N6CjqGRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3123920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A8501614;
	Thu, 10 Oct 2019 17:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A8501614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570722003;
	bh=TNAoCavfY9YLmcGHl7yyuG8euCEJ02HLFTFegmNnzno=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6CjqGRhlNYm2TCujiroXr0ZR12mkreycBw7ODQe5yQG4jYFZUJ7GEIfJqbZ8kqEU
	 OGaxHTyin92xImYFQudQo8SVgas3koxy4Qer285+/a5hVG5cQNc7q6po73t5Q9KHMl
	 HBkoCmHHIH26TCWSYgiJl9VpDvYU2+zXLTTBY1xU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA52AF80322;
	Thu, 10 Oct 2019 17:39:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46D28F8038F; Thu, 10 Oct 2019 17:39:11 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43A30F802BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 17:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43A30F802BC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 08:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="369124724"
Received: from aandraox-mobl1.amr.corp.intel.com (HELO [10.254.98.68])
 ([10.254.98.68])
 by orsmga005.jf.intel.com with ESMTP; 10 Oct 2019 08:39:05 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87sgo2ilso.wl-kuninori.morimoto.gx@renesas.com>
 <87mueailrn.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c594c9fd-1001-a50f-d6c2-06298a1c2110@linux.intel.com>
Date: Thu, 10 Oct 2019 09:17:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87mueailrn.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 04/21] ASoC: soc-core: rename
 soc_init_dai_link() to soc_dai_link_sanity_check()
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



On 10/8/19 11:30 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_init_dai_link() is checking dai_link only, not initializing today.
> Therefore, we can rename it as sanity_check.
> 
> And this check is for soc_bind_dai_link().
> Thus, we can check it under soc_bind_dai_link() to more clear code.
> This patch rename it, and call it from soc_bind_dai_link().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-core.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 335dc8f..f440022 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -941,8 +941,8 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
>   	return false;
>   }
>   
> -static int soc_init_dai_link(struct snd_soc_card *card,
> -			     struct snd_soc_dai_link *link)
> +static int soc_dai_link_sanity_check(struct snd_soc_card *card,
> +				     struct snd_soc_dai_link *link)
>   {
>   	int i;
>   	struct snd_soc_dai_link_component *codec, *platform;
> @@ -1043,11 +1043,15 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>   	struct snd_soc_pcm_runtime *rtd;
>   	struct snd_soc_dai_link_component *codec, *platform;
>   	struct snd_soc_component *component;
> -	int i;
> +	int i, ret;
>   
>   	if (dai_link->ignore)
>   		return 0;
>   
> +	ret = soc_dai_link_sanity_check(card, dai_link);
> +	if (ret < 0)
> +		return ret;
> +
>   	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
>   
>   	if (soc_is_dai_link_bound(card, dai_link)) {
> @@ -1985,15 +1989,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>   	int ret, i;
>   
>   	mutex_lock(&client_mutex);
> -	for_each_card_prelinks(card, i, dai_link) {
> -		ret = soc_init_dai_link(card, dai_link);
> -		if (ret) {
> -			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
> -				dai_link->name, ret);
> -			mutex_unlock(&client_mutex);
> -			return ret;
> -		}
> -	}

This part is difficult to understand.

There were two calls to soc_init_dai_link(), here and [2] below.
Your patch removes the first call and the for loop, is this intentional 
and needed?

>   	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
>   
>   	snd_soc_dapm_init(&card->dapm, card, NULL);
> @@ -2073,9 +2068,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>   		if (soc_is_dai_link_bound(card, dai_link))
>   			continue;
>   
> -		ret = soc_init_dai_link(card, dai_link);
> -		if (ret)
> -			goto probe_end;

[2]

>   		ret = soc_bind_dai_link(card, dai_link);
>   		if (ret)
>   			goto probe_end;
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
