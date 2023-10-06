Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965CE94115
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Oct 2023 20:24:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEC311F2;
	Fri,  6 Oct 2023 22:23:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEC311F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696623869;
	bh=Xmi5ddo42zY8xD/rYxJSEt+z2qmu6CIOL45QINGU9Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ICe00oQY8J99optKAdHstzggjINeW2TWaMQNY15u4x5vy1BsBG/+gRaR15Ub2CIER
	 P14w8aYdeaDgxZsevlcxkQCSSXa6b59OL56iPLrhFgP4DyNVunJ3kdJIezMNI9Tab9
	 CEWA0WL6LV0XtMRflz+Y+llcl6hV5/Vqbw1L/kTI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26C5DF8047D; Fri,  6 Oct 2023 22:23:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9C56F8047D;
	Fri,  6 Oct 2023 22:23:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D727F8047D; Fri,  6 Oct 2023 22:23:05 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23029F80166
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 22:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23029F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iJ8B72vH
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57be3d8e738so1332085eaf.1
        for <alsa-devel@alsa-project.org>;
 Fri, 06 Oct 2023 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623777; x=1697228577;
 darn=alsa-project.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=iJ8B72vHdlwj3UkXt3+1j873WMszI0+0TprJ/EWurtOsv2kPfFsylyZuir+B0jf0QJ
         tZ1JvLyJD8/Nok96IdOPD/IqNYkEst1zF3wydAjDara9RUrk2WyqzH4q0zScNF8dj33e
         +imnlBX+brfULPteRGVH/hP6AoDpuAf0n09Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623777; x=1697228577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=lgmBtv7rIA1IlMETF4xZHHZqQB0fCq7wuOGfuFEeHxBquVNDlQP2L1nSAFjQWgsoax
         Iy7lLjAaxgbEQZjrczqFspc6sDbAontabEfiHuSGUjRxFNvVj7MEWh0KxM1/wwXOK5oH
         fDzzce8fh7oj6EfNeenvnOXI05El+XLPB88VQo8XfMv95mq2Fe+FwuhJXtKAkf4ga1qx
         ewfEsF9joVc/9PDIZP8XXawpD4J802yE9m1YZzXz4B7yelEt9voaxFX9LfC38SdY1AVg
         MyFg6/csec20Fh9SvXbBtWWbB4lQHFdntkUqdeiKkBZLVpMkhOjZL73UnQ7Yrx2kp140
         Nw2A==
X-Gm-Message-State: AOJu0YwtEHNRJHmjG3P0lL2fKjZECQqdID5vqv7sFljf+hz78hfNXrWm
	Hl65D42CSgf8zX4VQm0KwXIVOexcVb5xfhSNRXI=
X-Google-Smtp-Source: 
 AGHT+IFJgYFdXQLoiEQmx+lFHyuC0qUrDFQKLIKGfw/wrLmvAN6GJdpM5ZD/9ihDG8TtTiEFnZjYhg==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id
 o17-20020a056358969100b0016487420525mr1346056rwa.17.1696623777190;
        Fri, 06 Oct 2023 13:22:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 19-20020a17090a1a1300b00273744e6eccsm4271576pjk.12.2023.10.06.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:22:56 -0700 (PDT)
Date: Fri, 6 Oct 2023 13:22:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
	alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <202310061321.E7247C52B@keescook>
References: <20230922175050.work.819-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
Message-ID-Hash: 7QLAMMT7APF6KGZ53CKTJH7DNZQY3GNX
X-Message-ID-Hash: 7QLAMMT7APF6KGZ53CKTJH7DNZQY3GNX
X-MailFrom: keescook@chromium.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7QLAMMT7APF6KGZ53CKTJH7DNZQY3GNX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.

Friendly ping. Mark, can you pick this up please?

Thanks!

-Kees

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Martin Povišer" <povik+lin@cutebit.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: asahi@lists.linux.dev
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  sound/soc/apple/mca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
> index ce77934f3eef..99e547ef95e6 100644
> --- a/sound/soc/apple/mca.c
> +++ b/sound/soc/apple/mca.c
> @@ -161,7 +161,7 @@ struct mca_data {
>  	struct mutex port_mutex;
>  
>  	int nclusters;
> -	struct mca_cluster clusters[];
> +	struct mca_cluster clusters[] __counted_by(nclusters);
>  };
>  
>  static void mca_modify(struct mca_cluster *cl, int regoffset, u32 mask, u32 val)
> -- 
> 2.34.1
> 

-- 
Kees Cook
