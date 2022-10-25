Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD1FA373E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 20:14:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 922D84B54;
	Tue, 25 Oct 2022 22:13:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 922D84B54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666728879;
	bh=rAPmmifa2/HcHB2qPav/4923vIZAl9TQd5J4SGzrQ0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMyI2Vhz39y7vK03iJR1MR52BGT32ATNfF3iBgAFaauIpKvsa+myD607gg1v7gLu/
	 u4nZLkZMaB2p6x9c/+sPVBU+invTf++RrLyRcKZishgK3PY/ilxwhVX1lKYK4D2b4P
	 iVjNP3p+ZWEMc2fpbluOdvNTlYSHwtgFPanyZvJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A7F6F8047D;
	Tue, 25 Oct 2022 22:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F0B0F8049E; Tue, 25 Oct 2022 22:13:47 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C7C1F80431
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 22:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C7C1F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="WRa1eOJ1"
Received: by mail-vs1-xe2e.google.com with SMTP id 128so12268388vsz.12
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAPmmifa2/HcHB2qPav/4923vIZAl9TQd5J4SGzrQ0A=;
 b=WRa1eOJ1K81r/SUmnntIankHeHKKywXwyFJDwjNCmatVV8G+BItMgNQVaKyTZD+KEW
 bAm1zlAB12EDCGkC762udKuZPfW3iyP73wMq+ybNWskymy48ElCG/KCRK/moNnSR17dQ
 QwO/avAYCvLx9rhLlMG/BOBtCw3+Xzsbxm/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAPmmifa2/HcHB2qPav/4923vIZAl9TQd5J4SGzrQ0A=;
 b=fmdT5qk5xZW18plUEerA+WAK+C2VytKYaKxp1T/73prAQ9X+CN0AmgZs+veX49hY1R
 lL9YWUKnkvEivfeRBy2m8/JSSfg7y/4vY6iDRsgqE5MYFLCA1awfv8isugMQawZTVPGe
 EoiBI5DEnmo+S/+VyxjCH8pmDgqTE89XU6uvSzMrN/PU1CRoIDEwtBtQGCb4BjkEZzJX
 VH9a394PxRY9+UmesA1er8xrCCUBO2Htxw4OezbkUzpX7+AE8uG4lJpm75bj6HDZELj+
 9VYuHQeSpU32Lu5cZyQH9utx8DXpyu7ZehVt874Uxq6cgIOiLkOzsPfzYB1VyHVFqDyt
 Ih4w==
X-Gm-Message-State: ACrzQf3Nem7oElMPnnByIgUVEGCZY2inaQlCGjof5M1Wfe/gHta0P8/7
 s5hx97gr16acI0QhSqp+iZcqYrHB/DhsfLW8Vf77ZA==
X-Google-Smtp-Source: AMsMyM5IB8RgcuzYzbkFmYZrPSXEs1oFyu5ZgLVs7Z6aLBG8OIFrAtoBUdy5htlVYoqfUMIXTvOVS3pYIt5SK/aEe3U=
X-Received: by 2002:a05:6102:3ed5:b0:386:91a5:a246 with SMTP id
 n21-20020a0561023ed500b0038691a5a246mr23144507vsv.26.1666728819322; Tue, 25
 Oct 2022 13:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-4-nfraprado@collabora.com>
In-Reply-To: <20221024220015.1759428-4-nfraprado@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Oct 2022 13:13:28 -0700
Message-ID: <CAGXv+5GUtP_mqbO4uJkMUL-=AxytUbEsMxgYtYdNis=zCzvFnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
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

On Mon, Oct 24, 2022 at 3:02 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Commit 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> defined the sound-dai-cells property as 0. However, rt5682 has two DAIs,
> AIF1 and AIF2, and therefore should have sound-dai-cells set to 1. Fix
> it.
>
> Fixes: 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
