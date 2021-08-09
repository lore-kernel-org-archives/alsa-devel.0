Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7106CC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:39:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E7760FF2
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02E7760FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7CF11616;
	Mon,  9 Aug 2021 17:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7CF11616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628523595;
	bh=FL2Y67qQKqHbmqaV1S2aZjqQmb/E5C5ZK3+E4BtHn/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TK9akK8LoURLcij5QeJ55nrV5Om9VBFQIjYxclmhRw7JYfTQiuzj2JHLhYarh0BFL
	 IZJjpG81peuDojnpheYeUl6613vd5rs2M6K0biPB0nnzIOSDjt5rs1xDjIEzz1ZgnF
	 LcyhKBFPdikiNRKQb+Rj2XVwWeUeX3fh+mXMtaSk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 659F1F80105;
	Mon,  9 Aug 2021 17:39:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCFC2F802D2; Mon,  9 Aug 2021 17:39:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54919F800FD
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 17:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54919F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ThBmEC6N"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2B361052
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628523527;
 bh=FL2Y67qQKqHbmqaV1S2aZjqQmb/E5C5ZK3+E4BtHn/c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ThBmEC6NAEFNIVe7zi0ikhLlp1LQUgLjgcr1OHxgamGrdkou1CxI8/WW9Quz41dkj
 9bAqNN/LbbdCxU8sbgiYC/OhTxhbY/ZvDKgsn5r2cgZlMnCshpui5qhmh/D7FR4Bmc
 tN5Bc2X/B50H2gtHnAO/HAgwZz2H6PkjJ2qJNES3jBNB3Fh1emea2LlxtZx07wG+jG
 loBVXuxenCFZimPsmxiFJgLXYIWLD88fa3JX4aF73WNbaBkUyrU4E5x14Jh3o0aOvL
 Q2LMCk2EG8/DpV2F51j9nzmvamtxk6/tMDaeO1/5f9WSEWj4U0LzdAC0t8dNpds7I2
 4jnu+qdwaxtRg==
Received: by mail-ed1-f45.google.com with SMTP id x14so2719687edr.12
 for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2021 08:38:47 -0700 (PDT)
X-Gm-Message-State: AOAM530bBIEdTLPXx4aPRdhnJUeIeUlb1PyOSsY+Dp7j+iA9IxHF2lWr
 59Ozlad8GArVahlp83npnR7gYzQO4hDt1U93kA==
X-Google-Smtp-Source: ABdhPJwHWW7SqmOjHtOtDmm2lqoa/xhxT33kYVNt+5rEFpgw+r5ogOrkLJOTa6lP4ZuTcsVI90qDJqnl+p/h4q514Ag=
X-Received: by 2002:a05:6402:104b:: with SMTP id
 e11mr14192653edu.62.1628523525547; 
 Mon, 09 Aug 2021 08:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
In-Reply-To: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Aug 2021 09:38:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbHF12TVnktAh6Hq0mLnx9xV__rM_kHcyaJt58sXK0ww@mail.gmail.com>
Message-ID: <CAL_JsqKbHF12TVnktAh6Hq0mLnx9xV__rM_kHcyaJt58sXK0ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: rt1015p: add new compatible id
To: Jack Yu <jack.yu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

On Mon, Aug 9, 2021 at 4:27 AM Jack Yu <jack.yu@realtek.com> wrote:
>
> Add new compatible ID for rt1015p in dt-bindings document.

Please resend without the winmail.dat attachment. And run 'make
dt_binding_check' as this will fail.

>
> Signed-off-by: Jack Yu <jack.yu@realtek.com>
> ---
>  Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> index 644b68edf3e1..8fcb5f79a1b5 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> @@ -15,7 +15,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: realtek,rt1015p
> +      oneOf:
> +        const: realtek,rt1015p
> +        const: realtek,rt1019p
>
>    sdb-gpios:
>      description:
> --
> 2.31.1
>
