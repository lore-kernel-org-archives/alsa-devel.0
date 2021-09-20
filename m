Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C4C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 10:06:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165CE60F5D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 10:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 165CE60F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BCC0168B;
	Mon, 20 Sep 2021 12:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BCC0168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632132386;
	bh=/rKN0TRlG4jUjiQFuZBWWVXi57C3cYujtbWL5c76c6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sg8u9q5gYXf5yMxUHnllk+64oMdg88NOfhXoexAH7xvizWF6Hf7imUBxDO+G0704I
	 ZWXbrQ+GJS1VNt3O+mCeihh/BbuOq8nM5bpp0U9XTc0pzN4dR9O4qEO/wQLXa1ywdi
	 XWsibDakjyOWIF0iDPyRw78HvOTxm7v2MgaTyhQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFF79F80246;
	Mon, 20 Sep 2021 12:05:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC2F8F8025D; Mon, 20 Sep 2021 12:05:33 +0200 (CEST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1F4FF80129
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 12:05:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1F4FF80129
Received: by mail-vk1-f173.google.com with SMTP id d10so6356272vke.10
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 03:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CJlXbAv3u12lESrV/6ZqM6UNLLxRX/MyMpJQH7eW+7g=;
 b=aTHD6Lq698YXQTschRkMjBUawfNtdUu7PLI0hFAIpM1/SRjAcoHt+EU02Pe571mvVp
 3HJoGR8UtH7pcU0NHrfHNPJUsKwu3guKfySmkoWSYbV+L/0BVbBabtnD405f1YhsnhOR
 gVwEvSOgfuCBsgHSB7F48dN/ItfDcvNxb4/qxZbCfpFLVHB7CGXGsjF7sEcwgZhRhTD8
 b+6xW7pmDHnZQ0mukczwxryY+HokCzWI86pbW87a+s2b7ek0oqM/mSSVcCXUA+5nM6IT
 ctkbBpZkDGjXvDQJdtxLQpPkdOw4StYSD0mAIBN+30qc01uVN5PCfqNMRScP5faqtHF/
 eB4w==
X-Gm-Message-State: AOAM532YWxFUxnQVnm16gTa0hKVWD3w/3ywkceP1yzHAE8/C2YGqu5ut
 vTkgs4rWeN8ioK96XOIq635/5V6j4NzBlJOcyiw=
X-Google-Smtp-Source: ABdhPJw21KYJ6+E01J7XKEBzRND+bYGJxtvpgL/KCdlzvGuzKjTv1Xd3XS/lrKcKi3oLR3yuOCRgqcDqibrEOieac7U=
X-Received: by 2002:a1f:230c:: with SMTP id j12mr13427328vkj.11.1632132324735; 
 Mon, 20 Sep 2021 03:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210920100206.1418649-1-arnd@kernel.org>
In-Reply-To: <20210920100206.1418649-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Sep 2021 12:05:13 +0200
Message-ID: <CAMuHMdUvb=nCZ=qfeUyUHQJ7TRjMjs4OVtd2q3yQT5SPk6Dx_g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: force COMMON_CLK dependency
To: Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Trevor Wu <trevor.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Arnd,

Thanks for your patch!

On Mon, Sep 20, 2021 at 12:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_COMMON_CLK, this driver fails to link:
>
> ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
> ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko] undefined!
>
> Add the proper Kconfig dependency for compile testing.
>
> Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
> Fixes: 940ffa194547 ("ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK")

I don't think the second Fixes tag is appropriate, as that commit did not
relax the dependencies.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 5a2f4667d50b..268c1f74aa3e 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -187,7 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
>
>  config SND_SOC_MT8195
>         tristate "ASoC support for Mediatek MT8195 chip"
> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       depends on ARCH_MEDIATEK || (COMPILE_TEST && COMMON_CLK)

Why not add a second line

    depends on COMMON_CLK

to make a clear distinction between hard and soft dependencies?

>         select SND_SOC_MEDIATEK
>         help
>           This adds ASoC platform driver support for Mediatek MT8195 chip

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
