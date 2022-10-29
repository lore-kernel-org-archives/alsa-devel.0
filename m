Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15FC38A02
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Oct 2022 03:45:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8B0C85D;
	Sat, 29 Oct 2022 05:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8B0C85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667015144;
	bh=45C1jboMe+05gbSn1GCpQ6eEwkqwMDh5afPsLEkvmX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZdaxwO6mP8Gaz9v6qe1DZk/wkqHhKSnpR+w3/9TXdoU6pe0p+/HDyCW31c9GuUOJ
	 47CEqN2w81uPdbhE9r2MbHmVinbPTPiw0Nlok5/sD7Mzf6sz+KUTz/aJUXyLcIbJKF
	 wK1GEvrTh5hyh7HSPxwAxoqXogwW4+HgGKj31nJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60348F800E1;
	Sat, 29 Oct 2022 05:44:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0827AF804CC; Sat, 29 Oct 2022 05:44:53 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 442BEF80162
 for <alsa-devel@alsa-project.org>; Sat, 29 Oct 2022 05:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 442BEF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="g6MMhZCm"
Received: by mail-yb1-xb2c.google.com with SMTP id n130so8121435yba.10
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gz8chRT8BgwvM1bBz/hqcVOXEH6efHhKugP2b6d/KNA=;
 b=g6MMhZCmMEfh5a1DNSkgtctHLoc0Zxx78dPchuD8LfuYJuM5a1iKBrVY3MzEJpWdSU
 St2AbaMMDtRXzuN7Q9fGU5SuwvRBV8GtPCtMKFew5Jgeo3SqAp3VI2Uff9lQ4/h7Xgjv
 e87BsOqWIITvxqZrgqybtQZCsPPTDd+GZ/aDgY1yOHLKqOuhxyFLlNxRFYJbUVplgX/b
 Nr1A7IKy/E9utSKzdSQGIo8zwRASo1XvlR14JZTP3iaAwE60u+5pauhotsJQew5rfIhz
 o07M4q7QLt1ZdhZ2j+qK4jcCgzprDxNjmdyBOeBCztLzR3zFNw+3a/w8RQH3ndmDNtaW
 h3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gz8chRT8BgwvM1bBz/hqcVOXEH6efHhKugP2b6d/KNA=;
 b=eaCTHspRwdwGNokm69ZbWrt2wYYdrP57rWqyHQBQW1c+AfK++BRjrEAQ8d0vGAaFGj
 UWSmllhRCx09DKYiVma+9B9xsyXz20TfHBbt82LoVriKlv3QcTDcw5X1VV2ePSEU0yfo
 ybFLqZYWvf2YqhK9RR9NqZfcBG4kS/f2Gp4jpK7WB/twzPfnQFk1EdlIC77wJa+WfHGK
 jqAIJb1+ISdyd89yjNqUgIi2NjejJ3bgZ0DrbIs8S7WsckSKnPhDtZaV0WNjuK33UEVb
 A6rNb+0y1Na/jrQ2kZDX+VOq0VLMXtHwAMVxUYElpeBtsSQTLV2Kwx+GlCPOy+gR47ZT
 YI3g==
X-Gm-Message-State: ACrzQf3XvoB7574QRLtmN8mndwyzbuD2d8VyAutBWVWAmLc02IhnfO/5
 xSxR4IuEFRWyo4MfgqTagU8wqYgrgKFUDVrtzyd2Bg==
X-Google-Smtp-Source: AMsMyM66Ody47i2fsJ1hG0H/GOy1qXYYvmBtbpesojjIICAXjadL3JpiUK2chgxERuVe2gXSvIE968uC4fCiiR0bu24=
X-Received: by 2002:a25:420e:0:b0:6ca:2d9b:bdcb with SMTP id
 p14-20020a25420e000000b006ca2d9bbdcbmr2339348yba.453.1667015086809; Fri, 28
 Oct 2022 20:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
 <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
 <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org>
 <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
 <Y1wi+g9yVR+++iIg@sirena.org.uk>
In-Reply-To: <Y1wi+g9yVR+++iIg@sirena.org.uk>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Sat, 29 Oct 2022 11:44:41 +0800
Message-ID: <CALprXBZ0qTkd1UoJ-TNEA8Epp5nBJW1KYsBQz_Wtm4YnxewmrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
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

Hi Mark Brown,

On Sat, Oct 29, 2022 at 2:44 AM Mark Brown <broonie@kernel.org> wrote:
>
> There was my thing about putting the names in DT too.

> @@ -72,6 +76,8 @@ examples:
>          pinctrl-0 = <&aud_clk_mosi_off>;
>          pinctrl-1 = <&aud_clk_mosi_on>;
>
> +        dmic-gpios = <&pio 23 0>;

I think I added the pinctrl-name and pinctrl id in its example, to
make it easier for the user to understand , like below, what do you
think? thanks
examples:
  - |

    sound: mt8186-sound {
        compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
        mediatek,platform = <&afe>;
        pinctrl-names = "aud_clk_mosi_off",
                        "aud_clk_mosi_on";
+                       "aud_gpio_dmic_sec";
        pinctrl-0 = <&aud_clk_mosi_off>;
        pinctrl-1 = <&aud_clk_mosi_on>;
+       pinctrl-2 = <&aud_gpio_dmic_sec>;

+       dmic-gpios = <&pio 23 GPIO_ACTIVE_HIGH>;

        headset-codec {
            sound-dai = <&rt5682s>;
        };

        playback-codecs {
             sound-dai = <&it6505dptx>,
                         <&rt1019p>;
        };
    };
