Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D366E728CC
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Sep 2023 17:28:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 540E1DF3;
	Fri, 29 Sep 2023 19:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 540E1DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696008491;
	bh=xzxuqTPJNC6jIlDZXyKtKxIyaIjO+o92cCcpHUB0X7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vs+C/7Z/ij3zGyndcFaPXUwnJWbNQQ9fa8F2sHa6pVoh1/gHk7+8d8ouBU4vU8dlq
	 Bm3f9xU/jqgWiSwBcFEE1G230tKc/OXz0JiBbjE/y+iQ3fqsLHDVbCTl3f0MGMkNEc
	 Ni61Dcmol1VsM5Z0IdQqVUVYdTskQaE1TE+DdFpI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30280F8047D; Fri, 29 Sep 2023 19:26:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BAAF4F801D5;
	Fri, 29 Sep 2023 19:26:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E68ACF801D5; Fri, 29 Sep 2023 19:26:44 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27FE8F80166
	for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2023 19:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27FE8F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=in3bLSzK
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2788993edaaso4908378a91.0
        for <alsa-devel@alsa-project.org>;
 Fri, 29 Sep 2023 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696008396; x=1696613196;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=in3bLSzKpxEDH/7jKCJoHuDKunxxhzQ7PYFqI5vP7osBRac12JCTG2LaCsN4mo5LUO
         PkFfx+TfKE+nZif9I0DI4Gtsry8dy9P1yeQg9OvVXUzvdPxLd3BysSlpqzaAHVYR7ldA
         3pCEZqlM1iFDrvsQLur1RAYvYouHGyAHaKbAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008396; x=1696613196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=ARYPnfXLM/BZCCFQ4dAb6QJFbvpflPpzIYK2/BQSlCMiApZSBXVYL6srESN5uydpcV
         DiEx7eOSN81xzIyC5atOr+7igpmIANAiAuNynA7tj4XbsBJg/xbIAhop1ntOaDW0bYrn
         v+3HrKUoAJQAXRbwyn6fom2M+5GfLN0ALjp16njYW8SwhldTlaZPelk/OcDDcGaCwHHt
         Ex57ufMgJ6zFpJvxE3A7kfNs6vmZAfQA0B38ucAixuJxw2MKQYHYbP6RvH+wUTnHxeWF
         Gncvn+dLcUUdozkHiBkrlvVESX5Qb/mP4qiepHBJXXgWMYf5+vt/n28OXMJcJEW6lsFE
         7KWA==
X-Gm-Message-State: AOJu0Yy5qcUbyTZ4Adv7t2gh7c1DUSD5W9owIWejA+3elVlKQQf+5oVy
	yoBBDYVVAufTGpE/XiW0gzCFz8cPiGKfVTwfRVA=
X-Google-Smtp-Source: 
 AGHT+IG3mCcEa8WVJpFPvOj0b5dGwRnh2/1kFQNVIYL87dKwC/DqhQALhB/xIzmN0rioBZhmbty5Cw==
X-Received: by 2002:a17:90a:bd8d:b0:268:e5db:6e19 with SMTP id
 z13-20020a17090abd8d00b00268e5db6e19mr4483958pjr.20.1696008396220;
        Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 oj3-20020a17090b4d8300b00276fc32c0dasm1701460pjb.4.2023.09.29.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:35 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:26:35 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 comm_runtime
Message-ID: <202309291024.14F6DA0@keescook>
References: <ZRb0WiViajjqcyKT@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb0WiViajjqcyKT@work>
Message-ID-Hash: ZFEXLFQDA5GDREV7J2GM7762OJUVZHO5
X-Message-ID-Hash: ZFEXLFQDA5GDREV7J2GM7762OJUVZHO5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZFEXLFQDA5GDREV7J2GM7762OJUVZHO5/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 29, 2023 at 05:59:22PM +0200, Gustavo A. R. Silva wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the objects following `receiver` in `struct comm_runtime`,
> among them some function pointers.
> 
> Fix this by placing the declaration of object `receiver` at the end of
> `struct comm_runtime`.
> 
> Fixes: ddb6b5a96437 ("ALSA: 6fire: fix DMA issues with URB transfer_buffer usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Should these mention -Wflex-array-member-not-at-end ?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
