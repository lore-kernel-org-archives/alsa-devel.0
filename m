Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9C2C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 00:33:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43B721D6;
	Wed, 17 May 2023 02:32:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43B721D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684283577;
	bh=B90uMXCgtBXkEQUKEAEJeQb+X0V5judH6w1l/YEk44k=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K9Ukie1u8kxmT2dspnoiG8XkO08c7XL0V1GYJqTzDZ8EPG3evbdCyT9cl6tixxQUZ
	 2ryH0YWvSy1zpnVoX7Rl6c0Hp58gBIO4XYmLBIiOsRe/auY++x/Odrh4qs6MiMcH/O
	 JmA+y0npfJSrMZRltUO8tn0kwpT7u/ph8kKKnhAM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05531F8016D; Wed, 17 May 2023 02:31:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8949BF8016D;
	Wed, 17 May 2023 02:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 050BAF8016D; Wed, 17 May 2023 02:31:33 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76C6CF8016D
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 02:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76C6CF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jtMJJDwY
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f24d4900bbso207470e87.3
        for <alsa-devel@alsa-project.org>;
 Tue, 16 May 2023 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684283485; x=1686875485;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85tj7cERzQUFMgIoMyKczc8IKyrN6wIgIWOqQfpMlDo=;
        b=jtMJJDwYaYhTc6C6QspYc4twjQZDUkykOJa3NicXAKw6p7cDvj58tf8UG8XU7Eplof
         lSBZRY36X547z3GHfO1qt40ZYTPWrriLlT9uTRQ5+6+yPlQPnlijQHbaAmaXgH+yAXWn
         yUdjw1313iag7m0XWkZvBB3tP5p83xAsrIRSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684283485; x=1686875485;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85tj7cERzQUFMgIoMyKczc8IKyrN6wIgIWOqQfpMlDo=;
        b=M2LHEXPhQ0W6Nnyi11gLgfOw410ZFnbmm5QJXAAXguEFLhhkqv1v3DpIJXwWC93l3a
         PwFXm1Zd2mWQape2n+sn3r5zQC4aCmXxMrE4qLIvDC3Nv2vgLhsAerfZqmbm+vMSugRQ
         JLQUV0CNztmNpi1UVv82QU8JgCA5sbz3aIQfJHfeCt9uR4+B55IxJWYXE5ojRpSzqGh2
         bvyA2UXWUxni18Q+fQ4pp5wpLG3gF9mEvVbbf9DNkhcEDablNnGNdyK53YA9fqm3Esf8
         SmelAOOy532WU3EwTPi2xWoWQW9D0DYx9SducbRS2vkEEWN+DNL/fpFtiyP50h+vWvLd
         88Ww==
X-Gm-Message-State: AC+VfDyVpTfYG/8M3MEv6f1b/OZDgzByUn+eY4EiC8jwigkdauqEK6A2
	Gyiy8yzeI687EDZ1gkCGkZsRgqMZu3+0CzV3fy/igA==
X-Google-Smtp-Source: 
 ACHHUZ508i9q4cn2mVNF2UODCHXuv6hgo4JJfdk/dNcca6S43+rSFSKLjwd8ZnfrBdE9PrUrOAVqlrFERQqt36gzEP8=
X-Received: by 2002:a19:5216:0:b0:4f3:77f6:14b1 with SMTP id
 m22-20020a195216000000b004f377f614b1mr3919564lfb.34.1684283485283; Tue, 16
 May 2023 17:31:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 May 2023 17:31:24 -0700
MIME-Version: 1.0
In-Reply-To: 
 <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
References: 
 <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 16 May 2023 17:31:24 -0700
Message-ID: 
 <CAE-0n52-uUiMyVEsuiaBfbtgAr8x+cAHURMGa56r50TRe9dgHw@mail.gmail.com>
Subject: Re: [PATCH] SoC: rt5682: Disable jack detection interrupt during
 suspend
To: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>, Oder Chiou <oder_chiou@realtek.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: MEYH7DZ364S3FG732OO4HUB3SAFUCWWC
X-Message-ID-Hash: MEYH7DZ364S3FG732OO4HUB3SAFUCWWC
X-MailFrom: swboyd@chromium.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEYH7DZ364S3FG732OO4HUB3SAFUCWWC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Quoting Matthias Kaehlcke (2023-05-16 09:46:30)
> The rt5682 driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:

I was wondering why we can't resume the device before device irqs are
enabled (and similarly suspend it after irqs are disabled). It looks
like snd_soc_component_driver is not an actual 'struct driver' instance
so it reimplements PM hooks like suspend and resume for the components
and the suspend hooks run from snd_soc_suspend() at the struct
dev_pm_ops::suspend() path. Adding a noirq variant looks like it isn't
worth it.

>
> [   56.245502] rt5682 9-001a: ASoC: error at soc_component_read_no_lock on rt5682.9-001a for register: [0x000000f0] -16
>
> Disable the jack detection interrupt during suspend and
> re-enable it on resume. The driver already schedules the
> jack detection work on resume, so any state change during
> suspend is still handled.
>
> This is essentially the same as commit f7d00a9be147 ("SoC:
> rt5682s: Disable jack detection interrupt during suspend")
> for the rt5682s.
>
> Cc: stable@kernel.org
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
> index 2935c1bb81f3..5bc46b041786 100644
> --- a/sound/soc/codecs/rt5682-i2c.c
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -267,7 +267,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
>                 ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
>                         rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
>                         | IRQF_ONESHOT, "rt5682", rt5682);
> -               if (ret)
> +               if (!ret)
> +                       rt5682->irq = i2c->irq;
> +               else
>                         dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);

Not in this patch, but

s/reguest/request/
