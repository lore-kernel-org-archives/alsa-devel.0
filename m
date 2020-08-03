Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E7C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:40:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066C02067D
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H52BJjez";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gYG3VprT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066C02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6414186F;
	Mon,  3 Aug 2020 11:39:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6414186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596447648;
	bh=TgDQ5Vc+JMPRO31HA38oWRNDQ4lecpFLyLECrhsMEP0=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H52BJjezc2oAm+14vwhYP7aaMo3YDxDoje5VxH6l9tlZotGDoInXWJKyyUrIp+7p0
	 08b2CnRkHd6F5kNgMqyI+CGdomKtFwenIpoYQMIGyz5TU83YvJYsBQfN5oZjQlQVjr
	 vpwT+983zkjNGrkADcUDlnaoRyps06ioVKrdwVSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E339DF801F7;
	Mon,  3 Aug 2020 11:39:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7735AF80218; Mon,  3 Aug 2020 11:39:56 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5442EF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 11:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5442EF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="gYG3VprT"
Received: by mail-wm1-x342.google.com with SMTP id 9so13696620wmj.5
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=6QUUCiSRWx0cpMWOE+7etzD4gWREdtJncDtY+oNf8Es=;
 b=gYG3VprTs39JpS6F3wLhind763Vo+uclDbPkuI+6Pkn/YS29u+xaRKlRafTLv63V/z
 aZkt5f7bm2mKcjdiCWHT9qNOvY3TbEla3amVSPXxkmuEfR9LWdbYYlJTzuz+D9CUd1dy
 mca8nkKUjunMQ3rG2n2wpEgUvzRYZj40yS/eaatotlKiJXu4H/hHK10/rMpRi5+2em2m
 k4QherY/oEIrWzKQGkQDiGOjVh5lrzK0BXSh/YzoacVwkNI99bz1yXMFjKZgpDvIj+GS
 XuA3eI1AfF/YBVbEGnTTB6PqlsvMi/gE+Qx9K65T4xZreeS/8Q/eoHUfI1cDJn4WQphG
 cibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=6QUUCiSRWx0cpMWOE+7etzD4gWREdtJncDtY+oNf8Es=;
 b=b9CGYjOsWu53DCOrx2wCW89AcEkDzrN+2txviZysF+7WQo2RB7fgcWhjIpub58Hm6k
 iOoAtTyeF+i8wXsnImMUdabHrIqF3e53szScEfSNz7diCX7PdYxHLv83f9EuCu7zjhez
 ouXIOXhrQsGYLw1CuzpcLHlQQxzDYwck2I1UVFEtJlsny+aVPD1gQfhf1izwIBo58BRk
 WjfXOYugL62zxIaC1gNJ8sn+68N0/3nrK4f2/CkIMbLI+1n2IVWvj4OfZdABcclbrxKd
 v6bKT1jtephRdPy+Znd7baC0p1a5L2A/dmVmQruu6ww+uci/GX1EFxY0ZCUQEvuCjc3a
 WL+g==
X-Gm-Message-State: AOAM530AuGSxzekpkL4hRWX1kRq8B49XCNY9w0zc3ozcy4TSgPNaYA3o
 y0wD7ZawZlgf9gJpZxBxqDsDpQ==
X-Google-Smtp-Source: ABdhPJxS2SJ6y3vngrEeM+aLBXtDZLuCLohsm6eDSyYvd+X0PiQtu6SlZw7r9qMWVXMHVjHrMzOoOg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr16145691wmi.65.1596447585766; 
 Mon, 03 Aug 2020 02:39:45 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id 124sm5166278wmd.31.2020.08.03.02.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 02:39:44 -0700 (PDT)
References: <20200801100257.22658-1-stephan@gerhold.net>
User-agent: mu4e 1.3.3; emacs 26.3
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: core: Add common helper to parse aux devs from
 device tree
In-reply-to: <20200801100257.22658-1-stephan@gerhold.net>
Date: Mon, 03 Aug 2020 11:39:44 +0200
Message-ID: <1j5za02hlr.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-amlogic@lists.infradead.org
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


On Sat 01 Aug 2020 at 12:02, Stephan Gerhold <stephan@gerhold.net> wrote:

> simple-card.c and meson-card-utils.c use pretty much the same
> helper function to parse auxiliary devices from the device tree.
>
> Make it easier for other drivers to parse these from the device tree
> as well by adding a shared helper function to soc-core.c.
>
> snd_soc_of_parse_aux_devs() is pretty much a copy of
> meson_card_add_aux_devices() from meson-card-utils.c
> with two minor changes:
>
>   - Make property name configurable as parameter
>   - Change dev_err() message slightly for consistency with other
>     error messages in soc-core.c
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

When you send multiple patches like that, you should a cover-letter
describing the overall purpose of the patchset, then the patches

If you look around on the mailing list this cover is usually starting
with the subject "[PATCH 0/X]"

Apart from this, the change looks good to me

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
> I have another patch set that I will submit separately which makes
> use of this function to parse aux devs from the device tree within
> qcom_snd_parse_of(). This is preparation for that patch set.
> ---
>  include/sound/soc.h  |  1 +
>  sound/soc/soc-core.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 5e3919ffb00c..a0918d159fd3 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1331,6 +1331,7 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
>  
>  int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
>  				   const char *propname);
> +int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname);
>  unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>  				     const char *prefix,
>  				     struct device_node **bitclkmaster,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2fe1b2ec7c8f..bf46f410c8c6 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2827,6 +2827,37 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
>  
> +int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname)
> +{
> +	struct device_node *node = card->dev->of_node;
> +	struct snd_soc_aux_dev *aux;
> +	int num, i;
> +
> +	num = of_count_phandle_with_args(node, propname, NULL);
> +	if (num == -ENOENT) {
> +		return 0;
> +	} else if (num < 0) {
> +		dev_err(card->dev, "ASOC: Property '%s' could not be read: %d\n",
> +			propname, num);
> +		return num;
> +	}
> +
> +	aux = devm_kcalloc(card->dev, num, sizeof(*aux), GFP_KERNEL);
> +	if (!aux)
> +		return -ENOMEM;
> +	card->aux_dev = aux;
> +	card->num_aux_devs = num;
> +
> +	for_each_card_pre_auxs(card, i, aux) {
> +		aux->dlc.of_node = of_parse_phandle(node, propname, i);
> +		if (!aux->dlc.of_node)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_of_parse_aux_devs);
> +
>  unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>  				     const char *prefix,
>  				     struct device_node **bitclkmaster,

