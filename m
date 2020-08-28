Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67671C433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA3620776
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dOv5ONX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C17F1879;
	Fri, 28 Aug 2020 11:10:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C17F1879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598605863;
	bh=Q6lzh15EtIDgKW4H3rKBBLyCxSNmFOKGiUTZcN/8FFM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOv5ONX4mpReVY2luFJfeGepYlzA2a1GlY7YrYOOr4iSeEYBNvHzQUPCBrt4T8yeG
	 NM14MmOIVlB/oaTGgMidba6oiGeNPGEfdrx3GIWrIJ3XuOG1uqsPU3HpuzydYyfInt
	 OoXsGktAOcH+hp+gfNDS/oGnqIQQd82DKPt3sT0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C291F80143;
	Fri, 28 Aug 2020 11:10:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C27B3F8016F; Fri, 28 Aug 2020 11:10:10 +0200 (CEST)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 685F2F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 11:10:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 685F2F80118
Received: by mail-ej1-f68.google.com with SMTP id oz20so574000ejb.5
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 02:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mJubNjqa+XudkEa895Ask1EqV4yYrNAcnoAT4Dsx/b8=;
 b=JHCEd0+Gh7u18RFb7VAqSFE18IhMEUB/8jOyv+GeRgbGVJXBTr8dRZepJgy4Ea1XhR
 gXB+1OdidXsCPdGyvKD8qbN6p/LNKdg/4a4amZgnSda/kgl2a3p+KQ6hUOL7SrnK/25V
 OFoFlBYohIL+K9PpO7Eqh36fA09NPEtX+MYkLDA45VVt9o36czp1zIF0lOU45TKm2nF1
 Qf4ispR5LAEFg5iO9+4HcVYbYvGb3vfZY0kRyz0HG5emiEUUTvuULUEOvu5cC3Kb7FRS
 a3j0dkADoPB1MMGEj2Dp5iwfdijuCfin1aP8zCjUSUly+mnWA1rw5ypITWXPnzw6pM5l
 3rhA==
X-Gm-Message-State: AOAM532ijTBxmSY9biR9anSATa+UT9KtCLDO8rgkz+/l5jhgakFdDsyw
 kiqM+Pmu/GH/vYYHH6u1KKE=
X-Google-Smtp-Source: ABdhPJyooERpw0LvwmLPaTV9qsPD6VFRMiJ7F0Sb8CfrTLmnOOtarEgEd5+QSZafBe3+gniR2X8RMw==
X-Received: by 2002:a17:906:7c82:: with SMTP id w2mr755460ejo.87.1598605807481; 
 Fri, 28 Aug 2020 02:10:07 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
 by smtp.googlemail.com with ESMTPSA id q14sm448658edv.54.2020.08.28.02.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:10:06 -0700 (PDT)
Date: Fri, 28 Aug 2020 11:10:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 2/2] ASoC: wm8994: Ensure the device is resumed in
 wm89xx_mic_detect functions
Message-ID: <20200828091004.GA17786@pi3>
References: <20200827173357.31891-1-s.nawrocki@samsung.com>
 <CGME20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf@eucas1p1.samsung.com>
 <20200827173357.31891-2-s.nawrocki@samsung.com>
 <20200828064812.GE17406@pi3>
 <28723053-c305-d359-3862-656ade11bf74@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28723053-c305-d359-3862-656ade11bf74@samsung.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, patches@opensource.cirrus.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, m.szyprowski@samsung.com
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

On Fri, Aug 28, 2020 at 10:50:33AM +0200, Sylwester Nawrocki wrote:
> On 28.08.2020 08:48, Krzysztof Kozlowski wrote:
> >> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> >> index b3ba053..fc9ea19 100644
> >> --- a/sound/soc/codecs/wm8994.c
> >> +++ b/sound/soc/codecs/wm8994.c
> >> @@ -3514,6 +3514,8 @@ int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	pm_runtime_get_sync(component->dev);
> 
> > The driver enables PM runtime unconditionally so you should probably
> > handle the error code here. I know that driver does not do it in other
> > cases but it should not be a reason to multiple this pattern... unless
> > it really does not matter as there are no runtime PM ops?
> 
> The regmap is provided by the parent MFD device (drivers/mfd/wm8994-core.c)
> and that is where those runtime PM calls get propagated, we could possibly
> get en error if there is something wrong with resuming the parent device.
> 
> If you don't mind I would prefer to omit the return value tests in that
> fix patch. Existing callers of the wm89*_mic_detect() functions are 
> ignoring the return value anyway. Probably the checks could be added 
> in a separate patch. 

I don't mind.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

