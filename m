Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB0C46CD2
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:53:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 172BB204;
	Wed, 24 Jan 2024 21:52:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 172BB204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706129582;
	bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SOJ0mHkarXKtYSwKqMaKpIKGUTtgTZkLTkcCwA6KzZokgxGA4EsKSbdG4sa+vLQNa
	 qJaS5bO4OWUTkeicU7x7Er9FRvmPO5DfPGI1sSa2K1qTSjfRsDTwI26FHJFIDkgCQz
	 mQQPDDt6i/6T+dPmnPwbrQb2q6Kh0X/eRdgI+RdM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3EF8F8057F; Wed, 24 Jan 2024 21:52:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9528F80580;
	Wed, 24 Jan 2024 21:52:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD6A5F8028D; Wed, 24 Jan 2024 21:52:21 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E6A7AF80149
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2024 21:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6A7AF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Fgbx/J+F
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2e0be86878so10358766b.1
        for <alsa-devel@alsa-project.org>;
 Wed, 24 Jan 2024 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129536; x=1706734336;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
        b=Fgbx/J+FJCWJy3jUBfM8+EvTIbRnqHh19Nzq8g7dGu7Sl1L/4Z8zEVfGDRDSX1nbo9
         RMa+uzC4G6t/kUdW62RABruX/nZ5T7zYOfNzCmAQ17mipmpaAF0tBETURs/arB9icl2d
         q0JntN0FjrdMIZ+lyIPyTZjfUrF6THbSDqEJulQ3Jb88HIBSzSlRucqnQ5QiRuPthN8G
         wUdfEX3cb+5WG3t5WkIZaPa17VSMLuMrhBoUmC1P/LjQOr6XbSB3X8Fo5iZt4Y611s3d
         Zqh3js+t/UWma3vYkluTdBFa7d97LYyChr1WXoNWz1F4YMLbnezNlYO5YKIinY4y9yyN
         FqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129536; x=1706734336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
        b=Vkj+p9D4rPxSTKQo50Lr1K81S4dPWgbEyQqxHGAOXPExNsk6qpt6eig9zmCE5K8S4K
         eVKnjyGkHKpokPtrz2QBJA6RrI5tyrFA7R+Im6NYOEOdOT6y53r3xR25BcgqPR7Ux+wV
         IYEsO0pJgDXccqfN/B4UvDZiL8cptJPB1Cev/kYE60NznC4H9MLMOCyONaW0wMkQxO7j
         nTXH9RxzXEaylwAiF72rFXNfnNClDt8cVLmSN6cyF/vCC1XCKupbST9eLD5AaBnOWefu
         rl+DJBV2/m3v2JY0UiK06WrgOQDVST8d2TJnvmTcHx3gFqJuZiMJURJW+PNnKYowCqU1
         NKGA==
X-Gm-Message-State: AOJu0YzjiD9R2VJC15SvEkovXV3F3Jp4kCRD59YpUqNVU3CmigUp0vDM
	8f/bkNYd/hkqvLInJWdWEa196BvqQKGZmbAWyy2nZIntC5SCmd61cClHUGy8e+SWGlIff6TBG9f
	BBwZ0nVyk8kRqPPRwKpMbiZEsBYo=
X-Google-Smtp-Source: 
 AGHT+IEYFWPLw+3WJbyvV8ucSHMH4Lcdn82CMUL29kZl3sSg/w0RroU7mSwAw1vM6+VvVYDIjYKl/NL56kcNCOtPiGM=
X-Received: by 2002:a17:906:ce5c:b0:a30:e1b6:2879 with SMTP id
 se28-20020a170906ce5c00b00a30e1b62879mr243561ejb.1.1706129536440; Wed, 24 Jan
 2024 12:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
 <20240124153016.1541616-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124153016.1541616-3-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:51:39 +0200
Message-ID: 
 <CAHp75Vf=3U3pjFXck8isd7jcNuDbrPWRLCtN=RL5U+wFxZp0sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mfd: cs42l43: Use __u8 type rather than u8 for
 firmware interface
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: PKYYEE4LGO2NW27FC6OSGBENDMBAGZOT
X-Message-ID-Hash: PKYYEE4LGO2NW27FC6OSGBENDMBAGZOT
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PKYYEE4LGO2NW27FC6OSGBENDMBAGZOT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jan 24, 2024 at 5:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

Hmm... Don't we need a commit message, even if it mostly repeats the
Subject line?

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>


--=20
With Best Regards,
Andy Shevchenko
