Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9CBEB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 09:20:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D7A06C1;
	Wed, 12 Jul 2023 11:19:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D7A06C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689153614;
	bh=Ry3czwbD+drojCmAK4STnlovd4LCSba5lWwblh25Umg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C8Q5VMPQa7u66VHbmS6DRdURlVrpyKi6vEWw2j9w2SamDJchRumk5GZofrAdibyEZ
	 cQw6o71GYZKTOFp/OxbpV9Z4tYvuY3VEfRKDiiBdS8/qdN1xZYnAX5CHjLYyDoP3Td
	 khlpBhAUNMbCfyJd+Sz0DSvY+ZlTxEP1vKUi17Zk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6F64F80153; Wed, 12 Jul 2023 11:19:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33C82F8027B;
	Wed, 12 Jul 2023 11:19:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6046FF80249; Wed, 12 Jul 2023 11:18:54 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 954AAF80153
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 11:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 954AAF80153
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-57026f4bccaso76891287b3.2
        for <alsa-devel@alsa-project.org>;
 Wed, 12 Jul 2023 02:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153530; x=1691745530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG5q3OE8NA2B1Rd9ySf5DoQyHhC234Q++094p9pDpiY=;
        b=TOCiuLJQs/HsMWt/wk7doE4+N+2xORd6T8uYR3oW3T/h91+lkg0OqvZvuYvk0ouY2s
         f/GR+oeKln7ZSZrbfI/31uUrgUpnmYma4kPXVeAIgMRpusaH3xltdIduarhKFCKaJB33
         8L124peS4TtUqNA37/A7iDaPI/forXL/J4ncAbRJq3QdDi96Xqi044rlOphDwKpK3lng
         HoCq+Y7gSoiw100HvDF/udOSbGSJUNsfGuAOBOucPfFBLbkE2bu+RaVy4f7aXpbdcEGD
         1CGxh2fevzKBafE+QqzchIxUg1EOto74pTIly5cteovBOcNzx68zBPSuIFLgOZ0be3EV
         BGuQ==
X-Gm-Message-State: ABy/qLYbKsLNRiSkwx8OkMKq9QO6FQX80IFvG2tsQ0sBBnYmltIGSwGa
	rAIfhbukOvtaV7J0d6AjzR5VUV+tkhyaHA==
X-Google-Smtp-Source: 
 APBJJlGHlfQUUorcWN5lIeMju/ZO70BeUG2sicjT/7jQLu408FFbcrAxkMTA5fMdNntqiWHSj1/k7Q==
X-Received: by 2002:a81:a191:0:b0:577:3cd0:384 with SMTP id
 y139-20020a81a191000000b005773cd00384mr17666975ywg.15.1689153529696;
        Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com.
 [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id
 w18-20020a814912000000b0057a92cd7f95sm1049339ywa.100.2023.07.12.02.18.49
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id
 3f1490d57ef6-bff27026cb0so7556491276.1
        for <alsa-devel@alsa-project.org>;
 Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
X-Received: by 2002:a25:748e:0:b0:c69:b15:3e79 with SMTP id
 p136-20020a25748e000000b00c690b153e79mr17478596ybc.28.1689153528941; Wed, 12
 Jul 2023 02:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
In-Reply-To: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Jul 2023 11:18:35 +0200
X-Gmail-Original-Message-ID: 
 <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
Message-ID: 
 <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: Update maintainer email id
To: Rohit kumar <quic_rohkumar@quicinc.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, cychiang@chromium.org,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: DC5PPJU46PLAX7ECHSFHDHLOSZTCINIQ
X-Message-ID-Hash: DC5PPJU46PLAX7ECHSFHDHLOSZTCINIQ
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DC5PPJU46PLAX7ECHSFHDHLOSZTCINIQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Rohit,

Thanks for your patch!

On Fri, Jul 7, 2023 at 9:49=E2=80=AFAM Rohit kumar <quic_rohkumar@quicinc.c=
om> wrote:
> [PATCH v2] ASoC: dt-bindings: Update maintainer email id

Thank you for stepping forward to become a maintainer for all ASoC
DT bindings ;-)

> Updated my mail id to latest quicinc id.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
> ---
> v2: Updated commit header
>
>  .../devicetree/bindings/sound/google,sc7180-trogdor.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml     | 2 +-

Oh wait, this is not for all of ASoC...

Please use one-line summaries that reflect the actual changes.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
