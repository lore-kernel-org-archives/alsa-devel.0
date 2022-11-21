Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89762C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Nov 2022 09:30:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAA281675;
	Tue, 22 Nov 2022 10:29:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAA281675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669109410;
	bh=rx/Wdg0QMQSk+PSVIvhzBgjQOJPheSBB4YkfhZfFutA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqGSRLMExTsBtAo+PGlKEg25Tqrvh6iSflfDzqO1T+JItg2j3a4JgSCiJtb+jCpE/
	 g3RMwGgF3lgsHXvoGGoAhO+5gDGOC/IVIdyRfm1FMwU8mEYxog0vdJFlfGlSHWxUNr
	 D3N0dmb9rMFX7Bj7micuGtLt59AMJdrsrX1sx6rE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFF1AF8057D;
	Tue, 22 Nov 2022 10:27:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CECCF8028D; Mon, 21 Nov 2022 09:44:15 +0100 (CET)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D77CF80115
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 09:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D77CF80115
Received: by mail-oi1-f172.google.com with SMTP id c129so11913067oia.0
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 00:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=majJ1avGrA5sKHgff1+tjzzyZx4Q8F2N6bTI30UoVN0=;
 b=fvH11T1+SO2562JwQGyKkWpEVqSRg4KGchDNPvMAHyfOd19gamPjWXSh/FbNG7BFan
 jwLAyS9aBzD/36SkHIny7+Aek/w2UZPHaZgPGB2wg5scAmHyATNMhKrmmsYSdc8Z9z0E
 rO1C7uisV45Ye2T+aIhWEGoxtStdLkMGk9CvY2eSyQo//LOK/r7AsnphQlVELN7FdLWm
 legDdUPUz8g5dQZZZj7iFJSHvx6zRyT2qjI1ZyQqktzKCiBARrPcm+dp1+4CDCInLMuN
 ooyMtLhdjjkqVFYYLDreTeBOiOydIS3ZypPf1wP/MCe63GViqans1H9o8YxTj/5JNag1
 xrTg==
X-Gm-Message-State: ANoB5plEi9HUynJ4j/XYR/GkBxcAbmk44mvsAsTzAFYn4lT9EqMFGdBZ
 /gNBMzycJLEvdQUvB7gMOaE/oTNYB5+9tg==
X-Google-Smtp-Source: AA0mqf6gAwd0CeIsXefMaOjJllCyj/NWjIb8pJRAPK3Njq+zr4jVFRW748nWgEmQd52wv85s6sJdKw==
X-Received: by 2002:a05:6808:219b:b0:35a:f763:8e89 with SMTP id
 be27-20020a056808219b00b0035af7638e89mr8214517oib.54.1669020246727; 
 Mon, 21 Nov 2022 00:44:06 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com.
 [209.85.210.54]) by smtp.gmail.com with ESMTPSA id
 r139-20020acaa891000000b00354932bae03sm4047454oie.10.2022.11.21.00.44.06
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Nov 2022 00:44:06 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id
 a13-20020a9d6e8d000000b00668d65fc44fso6919476otr.9
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 00:44:06 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr16184146ybp.202.1669019882500; Mon, 21
 Nov 2022 00:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20221118223728.1721589-1-robh@kernel.org>
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2022 09:37:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXevKD5uq9k+gWygy0rZ_AVjxBW1vrE_Gzzu8=mJu1vjQ@mail.gmail.com>
Message-ID: <CAMuHMdXevKD5uq9k+gWygy0rZ_AVjxBW1vrE_Gzzu8=mJu1vjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex
 anchors
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Nov 2022 10:27:18 +0100
Cc: Nishanth Menon <nm@ti.com>, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-spi@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Samuel Holland <samuel@sholland.org>,
 Ilia Lin <ilia.lin@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
 linux-pci@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>,
 linux-sunxi@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>,
 linux-renesas-soc@vger.kernel.org,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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

On Fri, Nov 18, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml     | 2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
