Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B83C4BA24
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FC624687
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sFIzCzHY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="OXkwZ310"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FC624687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1359E1670;
	Thu, 27 Feb 2020 09:07:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1359E1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582790914;
	bh=xGWJ5R6nGW7jNo+kKhY+rVMkKutdGnVYKHgBSx+xx9k=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFIzCzHYbaaXbJjZS70cp79oqbZgheqEmMF7gSUrM7iHxWZwqWm8uoEZJmufkbpMG
	 HV0GJ+0NCITXsR3xQkdmS57svGI272vlhPiL1zVtSLWmSXVupCFLFd8Q0C4pR+FR96
	 Pj8bLD6Tpde/cffIe3K/foi8qUMT5pOAHLSTSu7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A11DF8013E;
	Thu, 27 Feb 2020 09:07:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C0E5F80142; Thu, 27 Feb 2020 09:07:42 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 533B4F80125
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 09:07:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 533B4F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="OXkwZ310"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=3202; q=dns/txt; s=axis-central1;
 t=1582790860; x=1614326860;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version:content-transfer-encoding;
 bh=IUblToJWSxBgFlhnLquBrYBi+CsSdc+WRI3/2kSysr0=;
 b=OXkwZ310AgQDJugT5Y3PlZVp+bVNebFfrop3GRsdRKmbZAvvV4nEjqk9
 nUZYgTQ7LP7+hflXiKTykU0pP4OuVD2HlyBaTGif2iIpcFhf8hp5/cxwc
 fD+bLzSe78xx/S40YrmfPaUvBkrUsrcV7p0L29cdocmWhuvmsjVxg3reL
 TrIb2yyl4+IA3EMRku+Axmsb4A6n/YElSuIjQm+v49KFCM8ijMYpdYO+0
 V+xC1eS/IDFz+mfu3SYC1h1bOqFP5jTd5u4GiXMzbFxNYentu7a03LV/p
 KNa6ky5Pntql9rgf92HPytrx8vCmwdxADCsKDoEsrWTJ4wtBJiF3gJlW8 w==;
IronPort-SDR: 4mylBMR7HB74vnqaSyqPRFX40dEnpjOoMnBlVuNPGIW7qs7HF5ObxIbo4N0k/fUcNr+n7UJGRt
 RKx5NPXkF12ol2jEG3zjRlIB/WmUQLgzH5+Fxn5H2AAVQUgOQ+UUcpMEPMn7FoPW3+IQfw+gRM
 805besfOypi/tJWnMVHMfbND3++c2GZ6MI6V+l+vAIletvAux0ZksEFgnRu833nloHg5CGV8yG
 ShkWLPAO6coCrsOzClChCelpYvdUthQjbxVgrGwF5DK7Pq07YgVEhwv6AW31pMADyCZSRDX4H9
 7bo=
X-IronPort-AV: E=Sophos;i="5.70,491,1574118000"; 
   d="scan'208";a="5877651"
Date: Thu, 27 Feb 2020 09:07:28 +0100
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH for-next] ASoC: tlv320adcx140: Fix MIC_BIAS defines for
 ADC full scale
In-Reply-To: <20200226133439.15837-1-dmurphy@ti.com>
Message-ID: <alpine.DEB.2.20.2002270906590.29598@lnxricardw1.se.axis.com>
References: <20200226133439.15837-1-dmurphy@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <Ricard.Wanderlof@axis.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>
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


On Wed, 26 Feb 2020, Dan Murphy wrote:

> Change the #defines for the ADC full scale bits from MIC_BIAS to
> ADC_FSCALE.  This also changes the error message to incidate ADC full
> scale value error as opposed to the Mic bias.
> 
> Reported-by: Ricard Wanderlof <ricardw@axis.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  sound/soc/codecs/tlv320adcx140.c | 12 ++++++------
>  sound/soc/codecs/tlv320adcx140.h |  8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320adcx140.c
> b/sound/soc/codecs/tlv320adcx140.c
> index 93a0cb8e662c..825ace9b5fa7 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -758,12 +758,12 @@ static int adcx140_codec_probe(struct
> snd_soc_component *component)
>          ret = device_property_read_u8(adcx140->dev, "ti,vref-source",
>                                        &vref_source);
>          if (ret)
> -               vref_source = ADCX140_MIC_BIAS_VREF_275V;
> +               vref_source = ADCX140_ADC_FSCALE_VREF_275V;
>  
> -       if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
> -           vref_source != ADCX140_MIC_BIAS_VREF_25V &&
> -           vref_source != ADCX140_MIC_BIAS_VREF_1375V) {
> -               dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
> +       if (vref_source != ADCX140_ADC_FSCALE_VREF_275V &&
> +           vref_source != ADCX140_ADC_FSCALE_VREF_25V &&
> +           vref_source != ADCX140_ADC_FSCALE_VREF_1375V) {
> +               dev_err(adcx140->dev, "ADC full scale setting is
> invalid\n");
>                  return -EINVAL;
>          }
>  
> @@ -787,7 +787,7 @@ static int adcx140_codec_probe(struct snd_soc_component
> *component)
>  
>          ret = regmap_update_bits(adcx140->regmap, ADCX140_BIAS_CFG,
>                                  ADCX140_MIC_BIAS_VAL_MSK |
> -                               ADCX140_MIC_BIAS_VREF_MSK, bias_source);
> +                               ADCX140_ADC_FSCALE_VREF_MSK, bias_source);
>          if (ret)
>                  dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
>  out:
> diff --git a/sound/soc/codecs/tlv320adcx140.h
> b/sound/soc/codecs/tlv320adcx140.h
> index 6d055e55909e..adb9513900b1 100644
> --- a/sound/soc/codecs/tlv320adcx140.h
> +++ b/sound/soc/codecs/tlv320adcx140.h
> @@ -117,10 +117,10 @@
>  #define ADCX140_MIC_BIAS_VAL_AVDD       6
>  #define ADCX140_MIC_BIAS_VAL_MSK GENMASK(6, 4)
>  
> -#define ADCX140_MIC_BIAS_VREF_275V     0
> -#define ADCX140_MIC_BIAS_VREF_25V      1
> -#define ADCX140_MIC_BIAS_VREF_1375V    2
> -#define ADCX140_MIC_BIAS_VREF_MSK GENMASK(1, 0)
> +#define ADCX140_ADC_FSCALE_VREF_275V   0
> +#define ADCX140_ADC_FSCALE_VREF_25V    1
> +#define ADCX140_ADC_FSCALE_VREF_1375V  2
> +#define ADCX140_ADC_FSCALE_VREF_MSK GENMASK(1, 0)
>  
>  #define ADCX140_PWR_CFG_BIAS_PDZ        BIT(7)
>  #define ADCX140_PWR_CFG_ADC_PDZ         BIT(6)
> --
> 2.25.0
> 
> 
> 

Looks good to me!

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
