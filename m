Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6AC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 17:24:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2A622C9E
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2A622C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFF201842;
	Mon, 18 Jan 2021 18:23:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFF201842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610990673;
	bh=vL2Q3fMkuv15u8DKEPcndnCArRvWjWoeKmNZlB7vghQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBPXGA/uBWtm8u7EJ6NbyryrRWc8oLju+wpIuJSbk+236yLG+wHwcyXcH0TJhhRuj
	 vr3YAxlTOht0n0TeXuCLlGYI4gLzIWQU3Zzinq7FHPSLNtJAO2OQWfpYvFmV+SYweo
	 GgK42eQWiXbYZcHAo/+kcml690hCa6iKiXisnDRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CF9CF80166;
	Mon, 18 Jan 2021 18:23:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0583F8016E; Mon, 18 Jan 2021 18:23:38 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAAB1F80137
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 18:23:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAAB1F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="n86qYIu9"
Received: by mail-pg1-x529.google.com with SMTP id c132so11330472pga.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 09:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1m+rUUQDdIhjKXOvL3hkSq8B9mPmn1aBAZoQylBeiLM=;
 b=n86qYIu9xLuWzYbv5gShTHRXcjqMDjkM0L7Ez6qeDZBDJjTSBGiYMV1VuMcQmn3CW2
 HmJauxMzu8xcDFCy8yhRj5ANa+eWQMVPQ40RwNdXfjCjkVZlrheJgNY0Y4AONsglytIS
 Ia3fQW7QcfHW4epgVInXoNKquJdCEkflv15WFP3LAJzYmUXefNozboNUAhp8SM7/cUOY
 7ggLCPvOFIiO38HSZxVVnfDqD4QcnsBekwwVApOQawixQiITtTRkHKHs9ms+8Befx5r+
 nUJErvetE0dCReRQgqIxy8pPTV1u4noYEzL2/ZqCK8fjtOx3+nZK33SVaVbCpLrK1Jcp
 ePCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1m+rUUQDdIhjKXOvL3hkSq8B9mPmn1aBAZoQylBeiLM=;
 b=WycMs/xGv47FfR6daTC1TpkU5nReaI3e1qZrm6nVL2UkNCI1B3FgfVqKZviw/rCPuM
 Kbu+vJ5IYSYZ+ClcUm8G3/HSLSU3sXiZ8I7GBh9F7FUbFxfwSwJuy3k9r0ioSeGmwWK9
 U/qKl6E3E8gJWkL4rauSvlpEl43i7tfDTkPw9dqBTY+4qXDp4j9waZYx4sWNe9ygUF3Q
 XHlyEbOgJzMbL2qkVxrMBnVF9Iw57GGrbNgwmhVbWSh7OH+HLxkM21tFeVyuXA+nT3O2
 xB7KKS5xcY71hdqtlB0W4U3d4DGGU/4HM2IpnBub3xdzr5WXzN/zbtcRF/yRZLB3rEs3
 IJFQ==
X-Gm-Message-State: AOAM532CoHnKz3i2mAwOpbN5s5WV2WE5C10+qtsyOPLLxvp77FYHoWoj
 2KicyNsk6bVD2LaBBpBI/suEo0ReXcYoe4x/0Mc=
X-Google-Smtp-Source: ABdhPJycCXTt6CPDhf5rSe5BpyIHmuyVLqOnWDvQyfIQJk/8LVbuHSNzR2+YhxDf2Aqi/p7Kc+CLxDrXgStx3ExNV7U=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr217722pfk.73.1610990611337; Mon, 18 Jan
 2021 09:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-9-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-9-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Jan 2021 19:24:20 +0200
Message-ID: <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ASoC: arizona-jack: convert into a helper
 library for codec drivers
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
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

On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Convert the arizona extcon driver into a helper library for direct use
> from the arizona codec-drivers, rather then being bound to a separate
> MFD cell.
>
> Note the probe (and remove) sequence is split into 2 parts:
>
> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
> jack-detect specific variables in struct arizona_priv and tries to get
> a number of resources where getting them may fail with -EPROBE_DEFER.
>
> 2. Then once the machine driver has create a snd_sock_jack through
> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
> the codec component, which will call the new arizona_jack_set_jack(),
> which sets up jack-detection and requests the IRQs.
>
> This split is necessary, because the IRQ handlers need access to the
> arizona->dapm pointer and the snd_sock_jack which are not available
> when the codec-driver's probe function runs.
>
> Note this requires that machine-drivers for codecs which are converted
> to use the new helper functions from arizona-jack.c are modified to
> create a snd_soc_jack through snd_soc_card_jack_new() and register
> this jack with the codec through snd_soc_component_set_jack().

...

> +int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
>  {
> -       struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> +       struct arizona *arizona = info->arizona;
>         struct arizona_pdata *pdata = &arizona->pdata;

> +       int ret, mode;
>
>         if (!dev_get_platdata(arizona->dev))
> -               arizona_extcon_device_get_pdata(&pdev->dev, arizona);
> +               arizona_extcon_device_get_pdata(dev, arizona);
>
> -       info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
> +       info->micvdd = devm_regulator_get(arizona->dev, "MICVDD");

I'm wondering if arizona->dev == dev here. if no, can this function
get a comment / kernel-doc explaining what dev is?

>         if (IS_ERR(info->micvdd)) {

>                 ret = PTR_ERR(info->micvdd);
>                 dev_err(arizona->dev, "Failed to get MICVDD: %d\n", ret);

Side note: at some point perhaps consider to use dev_err_probe() with
functions which may return deferred probe error code.

...

> +       info->edev = devm_extcon_dev_allocate(dev, arizona_cable);
>         if (IS_ERR(info->edev)) {
> -               dev_err(&pdev->dev, "failed to allocate extcon device\n");
> +               dev_err(arizona->dev, "failed to allocate extcon device\n");

Ditto about dev.

>                 return -ENOMEM;
>         }

...

> +               ret = devm_gpio_request_one(dev, arizona->pdata.hpdet_id_gpio,
>                                             GPIOF_OUT_INIT_LOW,
>                                             "HPDET");
>                 if (ret != 0) {
>                         dev_err(arizona->dev, "Failed to request GPIO%d: %d\n",
>                                 arizona->pdata.hpdet_id_gpio, ret);
> -                       goto err_gpio;
> +                       gpiod_put(info->micd_pol_gpio);

Perhaps move before dev_err() ?
Side comment: Do we need dev_err_probe() here?

> +                       return ret;
>                 }

-- 
With Best Regards,
Andy Shevchenko
