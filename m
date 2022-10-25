Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E785FA3740
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 20:14:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCA184B43;
	Tue, 25 Oct 2022 22:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCA184B43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666728841;
	bh=LxSxRxqD6xZhQJWNK6dvxLp4Arzn7vD5/UZLW0kutsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYw6DqRj/gXK8v6SsuRZtM8jQVivU5G0ypEv/MkEVUJnk3cNzlMDhsOV3J1/D2Xz5
	 wWD31Cbev3pBlo98m5++CO1wsqYO4DvZiPwnga5ErTcYK9Ddih43qvKOTNQ8mKdk8E
	 CKWDTpLqFRRkrAwT30LRwhKVJGFIMclDnA8UQOhE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A34AF8042F;
	Tue, 25 Oct 2022 22:13:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FE83F80431; Tue, 25 Oct 2022 22:13:09 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11924F80100
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 22:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11924F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="K3/2yhlJ"
Received: by mail-vs1-xe31.google.com with SMTP id h4so12271051vsr.11
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CDt1y7e7BIyTnclLO8/l8wF0JXVZnj5kZesVA/eyFg=;
 b=K3/2yhlJoAiQZi9EIf9ab9ebsvLBXlapY9+VwvPvvaVRJdx5Qh7HaDiz2pbdxMyjy6
 7O0o8Vn/BmDMXgzxWGyev/NBW9V/cCjmYxXMKeQtMV/TakUujFewAyvj3sGn29sXYTwy
 HJUaeg9EChZ2sMJxySltPYCDU+/TXDc57BhfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CDt1y7e7BIyTnclLO8/l8wF0JXVZnj5kZesVA/eyFg=;
 b=F1Zmr5+j/GiO5feokfQJGhuXfCUwOhBb8B6ne8plhtcPBrrrNAFYOBXOgykFkXc7aw
 UkhxDkeR041YsCJYlPXB5kKntwtNL3gitWPge+QdR/cFb3PhgGoykiXV0XKA5xiYC7f0
 fzpl2Vkhy+INZvaT2ZkDODiIDARVu0dIqh69u5tfy8jVmDrpjGTBnU1nBLXNe3nlju/v
 GVm3JFP0T/aVlOYdqNkzJotvAM2AvOcbxR8p9UtI40CLGhKuea+ZtQAoI9yhqQj/moOl
 RBa9m2d6Jf8zlmn6MD7HlDSBXoHhvmiO4ifLS4tyOBrtHOynuap8YMB/4+RT5lay/zpD
 gTeg==
X-Gm-Message-State: ACrzQf2zjtvjCP/PZRyNIafEtwJOhq0Gk32xqWOhyPzFZQEg8qbUlG5i
 a+34fnPuzD2SZzCHg6sZTLpKlOAgwdICBtaqmvm/3A==
X-Google-Smtp-Source: AMsMyM442Daimvpeuj+fzZhj86o7I+uEPF+apOJTcNTkmGt7gJrIuTpph61tawRfa3xTlXfYPexjfx9DegwQ7Ul9dgo=
X-Received: by 2002:a67:f106:0:b0:3aa:efc:8610 with SMTP id
 n6-20020a67f106000000b003aa0efc8610mr8867914vsk.65.1666728780555; Tue, 25 Oct
 2022 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
In-Reply-To: <20221024220015.1759428-3-nfraprado@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Oct 2022 13:12:49 -0700
Message-ID: <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Derek Fang <derek.fang@realtek.com>,
 kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Mon, Oct 24, 2022 at 3:01 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The rt5682s codec can have two supplies: AVDD and MICVDD. They are

The actual chip also has LDO1_IN (for digital core and charge pump)
and DBVDD (for I/O). However in the Chromebook designs these two
and AVDD are all provided from the same power rail, through separate
filter banks.

Neither does the datasheet specify the ordering of AVDD, DBVDD, and
LDO1_IN for power sequencing, just that three should be toggled together.

Should we model these? Or wait until some design actually splits these?


ChenYu


> already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
> binding.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added mention that property is already used in a DT to the commit
>   message
>
>  Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml=
 b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> index 1c0b06d82369..ac1dea5b4450 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> @@ -90,6 +90,10 @@ properties:
>    "#sound-dai-cells":
>      const: 1
>
> +  AVDD-supply: true
> +
> +  MICVDD-supply: true
> +
>  additionalProperties: false
>
>  required:
> --
> 2.38.1
>
