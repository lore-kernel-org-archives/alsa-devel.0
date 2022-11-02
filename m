Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F51DC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 12:15:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B78C207;
	Wed,  2 Nov 2022 13:14:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B78C207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667391310;
	bh=AeKaQgMt7fK+7s4Zf34r4EfOjpj17M6Ane40LvP+sh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSdZtepxw0bySvGp75NHomq1fM1j5+fvl2mu3SAxAhBQbHa5gmsAO0xqHqkeywDIO
	 RGGSLjIFmaLsgJI/oBYWsLumDyRqyKMnpGkeHHgyTXG0V6gnSfFT36JT3gjvZLi0d3
	 O25/gUGyoAlFRxZMECeIJbHRZENNBbhnhx8JhjOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4461F80254;
	Wed,  2 Nov 2022 13:14:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8D3CF801D5; Wed,  2 Nov 2022 13:14:18 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8998DF801D5
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 13:14:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8998DF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="AkNUUmqO"
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-36a4b86a0abso164309907b3.7
 for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2022 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EZG/ByG3yJYBkXj69Uab2Z/6HK+E8SMP0+2AXC/lf1A=;
 b=AkNUUmqO/Y45WxuoBR0rRaklH4OHqR+yZ5YeF6JnVQmYmTjluAaV46qVgaOKJ2mmgM
 PBqqDqdSWLLqNZ45Xbhc9B3t+OD2sBNtUXc4stMQoQBI48nwjPKRzZqbUNLP46fnP13T
 lQmPaz8cpBM0wcs0z2tUJuejy8JXAcpI/+Hs5tpVWFSQAdsg7I4Jl4sDzhvROmrGNqdQ
 MWBorzdi2SMHTwJ7sALIh4+WOqexvrkM688bwEJwNkjYffRbHc4ARbU+DnpEWbp7wI+u
 1X56Ly/vyk7iOdRZ842EBbJE8Gr+ggILqwOTMmQvHR0dIVSvVeQbheizloGpALSZYzdr
 XbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZG/ByG3yJYBkXj69Uab2Z/6HK+E8SMP0+2AXC/lf1A=;
 b=hSPAskBX0FffKzbq5Anv0tQ+ZNRTDv2DcWwQqEOZjkSu9n4kfnM/AgWlltZ+gRM92o
 q/SjLaZodDGDNoqK3JWnV7eYyKtBZ1YOt2woMGQRS4fIs1zi6346RFIt/3hQdX0yY9vG
 KcgCHsYMzXeqBwYV45nQWDUAo0w4U7CWhj1f/ijdaQYUn6lPUn3Kl+bIcXxx26ebldbh
 vDw0ecS8RaMyKKtSUVRnVORwnU565NsBk9tfGK0k3ank/0zkvw+7Wwle+RA5DeFRE8NI
 oQ/K+XbCvqci6Ny3iaFlO8vNRcd9dERFVlPyJeJl5c01ibF2n9l3rTJR1TXuzrke8TS2
 eRWA==
X-Gm-Message-State: ACrzQf3I4WQoGIt07/JJSCC2iB2VvGXOm6TW2F50lGsCTKLb1fuaUhpn
 hyzjC64TpV/pl2loycc+jBb9/x9Zi/o5lgX+Xoi51g==
X-Google-Smtp-Source: AMsMyM78NfzDgrg2IPxctI0tS2AzDrlpnwtNUe18UdnC0fjfl1bmHHKpixedQ85u2WDA5JObnaAM2Jkhsl48huvRB6I=
X-Received: by 2002:a81:9e47:0:b0:361:468a:7221 with SMTP id
 n7-20020a819e47000000b00361468a7221mr23413942ywj.155.1667391250013; Wed, 02
 Nov 2022 05:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221031122224.1846221-1-ajye_huang@compal.corp-partner.google.com>
 <20221031122224.1846221-3-ajye_huang@compal.corp-partner.google.com>
 <549e1ff6-821a-1c26-0a4f-021bed27b093@collabora.com>
In-Reply-To: <549e1ff6-821a-1c26-0a4f-021bed27b093@collabora.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Wed, 2 Nov 2022 20:13:58 +0800
Message-ID: <CALprXBbL6HDaZhGU5eG6cnDP_rqymvamjTNGy7acaOk1rTMNmA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi AngeloGioacchino,

On Wed, Nov 2, 2022 at 6:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> > A "dmic-gpios" property is used for a mixer control to switch
> > the dmic signal source between the Front and Rear Dmic.
> >
> > Refer to this one as an example,
> > commit 3cfbf07c6d27
> > ("ASoC: qcom: sc7180: Modify machine driver for 2mic")
> >

> > +static const char * const dmic_mux_text[] = {
> > +     "FrontMic",
> > +     "RearMic",
>
> Why are the two words joined?
> s/FrontMic/Front Mic/g
> s/RearMic/Rear Mic/g
>
> Like that, we keep it consistent with the naming that was given in the commit
> that you mentioned in the commit description.
>
> Regards,
> Angelo

Thank you for your review.
Yes, you are correct, I should keep the string format consistent with
the commit I mentioned in descriptions to avoid confusion.
I will submit the next. Thanks. Regards.
