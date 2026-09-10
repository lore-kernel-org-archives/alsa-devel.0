Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBE7C79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:34:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5881F602A8;
	Thu, 10 Sep 2026 16:33:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5881F602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789050840;
	bh=SUENRTJhLPbN4I6eA/VBHUJ0VY/0q4ahijBhdl2mxuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vuyEmi+Ya6olEDZRFLAoIe6JKUX5XTVS5otU0Wsr96orfc2HmrXAAaQTgg9uwi9wf
	 ZlXBnGj6SOg9ftnD1yGgQ0Fj9UJ8PytOWvdRpSL19+Km+RrKcj+hq/mM/oLX/hNimL
	 2lqA1e7PSIvD+zvvYhEj6ZAIULeCJtFhm/z3anB0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A8F4F805FE; Thu, 10 Sep 2026 16:33:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06FA3F80601;
	Thu, 10 Sep 2026 16:33:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27CBEF8051D; Thu, 10 Sep 2026 16:33:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789050791;
	b=rRcVNDoI2IasWcesh7QJ6g7sVD273Of4RmGQFaGqYZJZZap0nTkVunM09MoQyR13Y/MU
	 JGPohFA31tlVCwABEpJUzhd5EiiW1g5x3SfysgGaNU/tHETD9Z3MG2R1clgDFNojKDI/g
	 SZ9t3to/GQkfqZq9QSyfi546yt0v6uVF2Ydc60naPfrru3+0QFB2z/ylyWn14SWe3lbmc
	 7g+Pnfs/zHlKbICv9AJCRn1SBE/aqWBWDqmgt2YxCNO2mnmUJn1idH7tLJ3g1NVgXP/Py
	 UfrBpE1Gvr8I8nRksKL7lHQG6QPCrieiDjOo25JYU4TM61CSjarcMZ5BzZEfmJODKOw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789050791;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=SUENRTJhLPbN4I6eA/VBHUJ0VY/0q4ahijBhdl2mxuc=;
	b=bSfZcTocolE3xHqezCSflAQuhwPBLKXt4eULLnNKagG9ax1nJxi1Df14CNJM3VTDg6GA
	 3dvzJXZmyLIDDhmYQdiri2oaZkZBJHPv8NW9QKCI70H1zUu3DrMXpm7X/CzMu16Bqy4aC
	 bpcAlJRrsQL9xM3WIHzayTbGZ1hD3ByJfvH0pXWef0KYIDHppz1+7gyR8WhN5VapxzS70
	 ewnJ7ry4TZj/51gee6E7AnUKoOrOBnDMD0i7Cn6k+Vj9GSg42wzhYvXmqZOdAMBn6GqKN
	 QdWhY2FQ6cWd7mnPbvzYFMfokh9dFOHOOJEn6+S92xTh2bMyczg7KWRs5RQq1l36p7Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aKqlMyyw;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57FBEF8003C
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 16:33:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57FBEF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aKqlMyyw
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c294183384fso279640266b.1
        for <alsa-devel@alsa-project.org>;
 Thu, 10 Sep 2026 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050789; x=1789655589;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DzU6DG6XG594yeHbl3kw8jAUPKuarqka9GmRxsQr0QE=;
        b=aKqlMyyw5IekRJCE3DJ4BRz0cTy4spwdQa/QP8YJn28nMzR+L4yD0orAEvpr8LkZLq
         g2cupw11BTgaF6+aEJM2km46gccIFLOyyVcbsAnp4xPTb57jSnRj9FWofkqeLGkbYTDm
         j52wKBNL6/ucQGEsPb2wl9jKZ8Kt5oJEdsBw9qiYoa1h1MBC4S9XPKBqekMFRjzP1V7j
         7YGPrEb30Q+SG5APg9Xpa0CiwW5Gb5oxzIJ0GZWP1IRTGPYv0lvIKDT0IfSCOojxP8qc
         UGskurLHPVMgo42kHbQAVOhdHB1YvQiM+GeQSai3ezRucmPeTgmM20JapxfUwRnCCXu5
         cI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050789; x=1789655589;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzU6DG6XG594yeHbl3kw8jAUPKuarqka9GmRxsQr0QE=;
        b=al8N/bjmtvNmRH87V0GFpg5ytgBS534Y9EuCApbFogFyEH9K2VY9tjySDV6ssfN0Oa
         Szrfx+4OwPZIOeiV7AOuAQrvEvWX9YxrKDrXywXN6daotJXkPjIDmfcodMsz2rnCy/Gd
         ZQAdkFSXCtjsj9u4TXmk3dUFzVS9UZSYZHKtxZbPrxjpS4e4LwMFpYut/F9ka/AgeFfR
         /nNT11o//ET8Wg3/JCL2Cy52Qo8QTlRnMW0kTmUy+kc6QneFoZ46jI09a+zfm85NWr35
         l4/JQP0ENYjWxdVnANc3usvMHvLM7m7mH173he6VvXKCNyHr77cAotSOuhYL02muZBGH
         lifQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/XJFlmIwdSb3Uj8r/c/48SzalQULXVHiWGrJjAVTonkUddxlUCgyZkiDz8eJjL9elz8CZ0w+n9wx3@alsa-project.org
X-Gm-Message-State: AFuF++kzf/AXFf8l+7ELjKhXXHseN7N5bmrQGBz6MRmhF/a5T6JXX7xm
	/ZaQyDP7cK17SVvToPHVhkq9Kxh+zNcCDvpdj3akxWbtBPIuyXvBBdFK
X-Gm-Gg: AYBFou0ycimjwY14qfleJ5BFf7zNlSlUrQMkWVln90Hft7NVcBWkKRwZD0WUZwkGvlQ
	zllaGV+T3jJn0dP711nnHMhviDeb2JEAxK0ZLijayz98ZoeZ/oUqFYMzbY7khji4goGNZlNcpmv
	nfbw43unbtg5KnrDgQTG9Hj2suEIXpMbouD2XQYd1dIcPupXD9GJIMQIHDvz8oHF1zDXBEE6SeI
	4zajOEkh+BiuhFfIIocPbnFxUzYF1jG9fJTCB7QCrpmUhYXsPRSEfd6Uq5V/I4NY/6Mc2ETRdaY
	mapdq3A0qK+GWi1aXblqX7IL9SkPad8Lzemz3XjzBTaA1ovLPNCFCzsbT/Ftr9zym9ZlT2xheSu
	dlS9AVwyfIFQN31YU85GxQrtt/Jrhk/zflcOIAZLOcR7XEOOsIhurSEqL0IcyzcNYqtNlpmStuR
	EOl7z257CKiMs/KR5Usj4sothY2jvm5GBD+Sx+9G7s/weVyFkKSQU6G3nwW9yy++mbFT8=
X-Received: by 2002:a17:907:724a:b0:c29:52dd:317c with SMTP id
 a640c23a62f3a-c2952dd43demr140890666b.30.1789050788988;
        Thu, 10 Sep 2026 07:33:08 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c293d20e257sm204160566b.57.2026.09.10.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:33:08 -0700 (PDT)
Date: Thu, 10 Sep 2026 17:33:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v10 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <aqK_oOpMAXVhxkHJ@stanley.mountain>
References: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
 <20260825021644.1203076-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825021644.1203076-3-YLCHANG2@nuvoton.com>
Message-ID-Hash: 6Q5EY64BBQJ2FFZU6DZFP65WSR27YANC
X-Message-ID-Hash: 6Q5EY64BBQJ2FFZU6DZFP65WSR27YANC
X-MailFrom: error27@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6Q5EY64BBQJ2FFZU6DZFP65WSR27YANC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Aug 25, 2026 at 10:16:44AM +0800, Neo Chang wrote:
> +static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int *item = ucontrol->value.enumerated.item;
> +	int ret = 0;
> +
> +	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
> +		dev_warn(nau8360->dev, "changing path is not allowed during playback");
> +		return ret;

This is another case where I would prefer return 0 or return -EINVAL.

> +	}
> +
> +	mutex_lock(&nau8360->lock);
> +
> +	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);

Not related to your patch but the comments to snd_soc_dapm_put_enum_double()
say "Returns 0 for success." when really it returns true/false on success
where true means it changed something and false means nothing changed.

regards,
dan carpenter

> +	if (ret <= 0)
> +		goto unlock;
> +
> +	nau8360_dsp_switch(component, snd_soc_enum_item_to_val(e, item[0]));
> +
> +unlock:
> +	mutex_unlock(&nau8360->lock);
> +
> +	return ret;
> +}

