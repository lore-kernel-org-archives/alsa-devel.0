Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC7C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 14:43:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8894360EB1
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 14:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8894360EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FAA41684;
	Mon, 11 Oct 2021 16:42:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FAA41684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633963419;
	bh=GEZrQLH3vJcAB3kJ9S5oIt8ZVlTBJuinwUazy4w387Y=;
	h=Date:Subject:From:To:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bxRxSu3mm+FiC8OslVB8y69eSqCRFOXvAotdzGC3yEkZOmnRvQHvRqrvPpvx+8zh0
	 GhlVoHVG5A/y0xxi94GDjiOq58AldNF/KIYuoyufCI2DdYCBp/xd8au3Ek+HQGYzXs
	 Yv9QA/eY6Fa6uMk5wWHG06VzE592kf4eZr8Y3z2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93C46F80290;
	Mon, 11 Oct 2021 16:42:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 999FEF80423; Mon, 11 Oct 2021 16:42:33 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F721F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 16:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F721F8016D
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="213835394"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="213835394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 07:42:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="490504331"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO [10.249.40.144])
 ([10.249.40.144])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 07:42:19 -0700
Message-ID: <b5bafbfc-377f-421a-dd64-5359206e9fec@linux.intel.com>
Date: Mon, 11 Oct 2021 17:42:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ASoC: rt1011: Fix 'I2S Reference' enum control caused
 error
Content-Language: en-US
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, jack.yu@realtek.com,
 oder_chiou@realtek.com
References: <20211011141543.31030-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20211011141543.31030-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 seppo.ingalsuo@linux.intel.com
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



On 11/10/2021 17:15, Peter Ujfalusi wrote:
> Access to 'Is@ Reference' enum causes alsamixer to fail to load:
> $ alsamixer
> cannot load mixer controls: Invalid argument
> 
> cml_rt1011_rt5682 cml_rt1011_rt5682: control 2:0:0:TL I2S Reference:0: access overflow
> 
> The reason is that the original patch adding the code was using
> ucontrol->value.integer.value[0]
> instead the correct
> ucontrol->value.enumerated.item[0]
> 
> for an ENUM control.

I have noticed that the ENUM declaration was wrong as well, sent v2 to
fix it also.

> 
> Fixes: 87f40af26c262 ("ASoC: rt1011: add i2s reference control for rt1011")
> Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/soc/codecs/rt1011.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
> index 508597866dff..3adaff6f0141 100644
> --- a/sound/soc/codecs/rt1011.c
> +++ b/sound/soc/codecs/rt1011.c
> @@ -1325,7 +1325,7 @@ static int rt1011_i2s_ref_put(struct snd_kcontrol *kcontrol,
>  		snd_soc_kcontrol_component(kcontrol);
>  	struct rt1011_priv *rt1011 =
>  		snd_soc_component_get_drvdata(component);
> -	int i2s_ref_ch = ucontrol->value.integer.value[0];
> +	int i2s_ref_ch = ucontrol->value.enumerated.item[0];
>  
>  	switch (i2s_ref_ch) {
>  	case RT1011_I2S_REF_LEFT_CH:
> @@ -1344,7 +1344,7 @@ static int rt1011_i2s_ref_put(struct snd_kcontrol *kcontrol,
>  		dev_info(component->dev, "I2S Reference: Do nothing\n");
>  	}
>  
> -	rt1011->i2s_ref = ucontrol->value.integer.value[0];
> +	rt1011->i2s_ref = ucontrol->value.enumerated.item[0];
>  
>  	return 0;
>  }
> @@ -1357,7 +1357,7 @@ static int rt1011_i2s_ref_get(struct snd_kcontrol *kcontrol,
>  	struct rt1011_priv *rt1011 =
>  		snd_soc_component_get_drvdata(component);
>  
> -	ucontrol->value.integer.value[0] = rt1011->i2s_ref;
> +	ucontrol->value.enumerated.item[0] = rt1011->i2s_ref;
>  
>  	return 0;
>  }
> 

-- 
Péter
