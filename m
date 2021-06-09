Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E300C48BD1
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 19:32:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD87613D4
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD87613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 834D016D0;
	Wed,  9 Jun 2021 21:31:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 834D016D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623267152;
	bh=Upot+h4BOUxop9u5aoOEm30KgW0P5W74+xDE4RuL2BA=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mgVfoomVhq9xPqfKE8bIV6O5c9qhLKcSGIqwSyKoJk09BAHbyYJB9V+9s4zjlv0VH
	 fMpjKWh1z2hTwgblv865u4QtVLTUDp5xt1s1kJt5oGJP/o5iIA4k/XaOa8TuENWPjX
	 HESJzl4mtFwy28lHdcCHNjLHx8+pZ08lM/KQ5Bmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D193F80212;
	Wed,  9 Jun 2021 21:31:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7E75F8026C; Wed,  9 Jun 2021 21:31:40 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84DA0F800F4
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 21:31:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84DA0F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="MMFEzs5U"
Received: by mail-ot1-x32b.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so11360499otl.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2021 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to; bh=/5hRR3JhxA61/7kGbJ52XF4Id3fG9uBeIzCvCACHPQw=;
 b=MMFEzs5U6IDNKqGfwXrix6STIsbRevLZaidgF9ycrqSfLwnZd2nH5WPjEDTby0ZOMT
 8mSMBVUXuPyJIo4vUqhf5ZC9cfz4dg6jelk7kAgdMPS1kHmslrmOtoqpiLM/7/f0b9tk
 3nPQf+T5651vsSqqm8Tz1nlX7vFJ6ukPeraZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to;
 bh=/5hRR3JhxA61/7kGbJ52XF4Id3fG9uBeIzCvCACHPQw=;
 b=Bl+qyUzE0OjtJKGDHNxmayVxDl+oE5qZfMWXWwlaQNhmvX14dIlVYlvw4MdTP4hqTX
 GpvFLWmnmWiW16Fk0Qz1Zx7YCJE5OCfiIyq1HKUHOPzARgrCuDfC/gB4QTyiqXb2oLkK
 K0IRpu/EUvPHrLUh5vYGm97sI8NkJJvciw8y3zKL7xjGwpe6ELfHFVDoHIMoKMrvRW5K
 aFUuGaS7dMky064vVvktDRlt6d2Galo+KPkFvttz5QNm22zL2FIqgbZhmD5glm/KFesd
 xYnt+GIlhkUUH5O6Oc5kk3Hk76J9japBxU2QQYdAou4nHkKTjNIIGWmmy3VQbRn9g1WC
 2/sg==
X-Gm-Message-State: AOAM531D0M1lIeN2LQIrCUjUFE38Y3IZSj3TM8qe/RDu+rPyXc8VOR8F
 pt0aU2w/PsQoCFoJOOXg6OJ5VrNQNhErbeHbljUCLw==
X-Google-Smtp-Source: ABdhPJwbGOmwALrdCY6bSX1H2qs6NY1fPr3SD/WDtOxCLEy4O9BT2CZIneFt6DfO7TE5QTj4TK4ORmu+XZn+RYoNM64=
X-Received: by 2002:a05:6830:190:: with SMTP id
 q16mr865886ota.34.1623267094752; 
 Wed, 09 Jun 2021 12:31:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Jun 2021 12:31:33 -0700
MIME-Version: 1.0
In-Reply-To: <20210609133039.4648-1-srivasam@codeaurora.org>
References: <20210609133039.4648-1-srivasam@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date: Wed, 9 Jun 2021 12:31:33 -0700
Message-ID: <CAE-0n53Jy_kRK-6L4bZMZ2EAv2n3b9PX2GZSaUodZtU8P7P=6Q@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: qcom: Add four speaker support on MI2S secondary
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 alsa-devel@alsa-project.org, 
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, judyhsiao@chromium.org, lgirdwood@gmail.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz, 
 plai@codeaurora.org, robh+dt@kernel.org, rohitkr@codeaurora.org, 
 srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
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

Quoting Srinivasa Rao Mandadapu (2021-06-09 06:30:39)
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index c62d2612e8f5..aff39c9f6326 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -29,6 +29,15 @@
>  #define LPASS_CPU_I2S_SD0_1_2_MASK     GENMASK(2, 0)
>  #define LPASS_CPU_I2S_SD0_1_2_3_MASK   GENMASK(3, 0)
>
> +/*
> + * Channel maps for Quad channel playbacks on MI2S Secondary
> + */
> +static struct snd_pcm_chmap_elem lpass_quad_chmaps[] = {

Can this be const?

> +               { .channels = 4,
> +                 .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_RL,
> +                               SNDRV_CHMAP_FR, SNDRV_CHMAP_RR } },
> +               { }
> +};
>  static int lpass_cpu_init_i2sctl_bitfields(struct device *dev,
>                         struct lpaif_i2sctl *i2sctl, struct regmap *map)
>  {
