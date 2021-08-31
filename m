Return-Path: <SRS0=fy3w=NW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CEDC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 10:58:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2122A60F6B
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 10:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2122A60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3CE81698;
	Tue, 31 Aug 2021 12:57:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3CE81698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630407483;
	bh=4wU1qPThIsRUXcc4vcwbeKhdVs7RjHgSUtXm24zR/0Y=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G44eDaBTmlyzt61+1s0SsPl/TcnlrN3TC+owOjOLkodqOjbvhHf5bpFsZgNH+p/tn
	 7AaNZ9V01oIdMlahACJF1YRJXjqNuMz78IxUpVcp9Z3bN5rwcgBKDkyRn9gyCnaikx
	 Wqpm74bMCzlhw3Qx6Rswxb0r+t2CgvZaGEiVTHJ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D9FEF80254;
	Tue, 31 Aug 2021 12:57:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEEB4F8025B; Tue, 31 Aug 2021 12:57:11 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11DD2F80127
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 12:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11DD2F80127
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205580473"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; d="scan'208";a="205580473"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2021 03:57:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; d="scan'208";a="428144017"
Received: from yungchua-mobl.ccr.corp.intel.com (HELO [10.252.187.212])
 ([10.252.187.212])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2021 03:56:58 -0700
Subject: Re: [PATCH 1/2] ASoC: rt5682s: Add driver for ALC5682I-VS codec
To: derek.fang@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210826080938.14872-1-derek.fang@realtek.com>
From: Bard liao <yung-chuan.liao@linux.intel.com>
Message-ID: <8d4c9eed-e641-36c9-6727-ac744e87ff45@linux.intel.com>
Date: Tue, 31 Aug 2021 18:56:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826080938.14872-1-derek.fang@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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


On 8/26/2021 4:09 PM, derek.fang@realtek.com wrote:
> +
> +static int is_sys_clk_from_plla(struct snd_soc_dapm_widget *w,
> +		struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct rt5682s_priv *rt5682s = snd_soc_component_get_drvdata(component);
> +
> +	if ((rt5682s->sysclk_src == RT5682S_CLK_SRC_PLL1) ||
> +	    (rt5682s->sysclk_src == RT5682S_CLK_SRC_PLL2 &&
> +	     rt5682s->pll_comb == USE_PLLAB))


What about rt5682s->pll_comb == USE_PLLA?


> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int is_sys_clk_from_pllb(struct snd_soc_dapm_widget *w,
> +		struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct rt5682s_priv *rt5682s = snd_soc_component_get_drvdata(component);
> +
> +	if (rt5682s->sysclk_src == RT5682S_CLK_SRC_PLL2)


Should we also test rt5682s->pll_comb here?


> +		return 1;
> +
> +	return 0;
> +}
>
