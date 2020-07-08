Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B5C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 02:31:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAD220786
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 02:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CFeRcusL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="isZVmxyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAD220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43F9110E;
	Wed,  8 Jul 2020 04:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43F9110E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594175460;
	bh=5k/JGsyD2+esKCntA7d0GqlyFPWtT12zUQKTXZD4ijE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFeRcusLepQnPeGaEUXAQKmVX2vemoRei21pmNLb0uHnqsjRDv3lyNtpPvULJOkbv
	 tX9v0N9xqNvaUdHam/2La1s9w3TaGzRaQxmZJfn5whELZrXhurYLbiu/GsGZp71I0l
	 997f46bxuzLy/mAyuFx/N6z5vVhKrunBNlqI/QoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8BEBF80150;
	Wed,  8 Jul 2020 04:30:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E9CAF8015A; Wed,  8 Jul 2020 04:30:03 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4A0BF80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 04:29:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4A0BF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="isZVmxyb"
Received: by mail-io1-xd44.google.com with SMTP id q8so45404436iow.7
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5k/JGsyD2+esKCntA7d0GqlyFPWtT12zUQKTXZD4ijE=;
 b=isZVmxybBp1KSJIveFgxL3srASfZzBCe64vST1INaL9Tt0Cmc6eXvQpO4B1dFJ+Cxc
 5Tuih8iZIYCJd4H10Mtd6qVhyU1X0BkJJkRfx4yU084021EkVBccQIyas6oYs84CTpXI
 Bdig1CwUdpMuHwPdRHXj0iV0oBb3TpJcaSjS3tySv5jlSoYEWiiVx1TsvFfoWONXicbh
 y81teS+Q9Pm9GHmghEJw1LwzyBbyD/VGRf50t/K6S3iQQs4BsiAyPpv2yyMNa45WuUFt
 wwEEvCqTDvm0aPKIaS5lYv9vWOm1gJaF2RUw9C5feZiLgyh0+QMvydwCJPWsu+Q7iG1g
 z2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5k/JGsyD2+esKCntA7d0GqlyFPWtT12zUQKTXZD4ijE=;
 b=rGHiM7a/N1JPsGwXt+m6Ntcqd3TKrTOHwNbRqOp+87x+GgQbw+ITv8m3gPEVt/56K8
 8hzvvnY3rssJoSfs6a4NUUexJOhQFc12n5rckTvBwhFONPOxItmmMy3nmdpBoCaTU1mn
 opfB86KmtWF/YDRLq+FYGrSTDU97uErRHMkQ1zJSzbjesmWOEMpzWdK9Gx/k2IwMg/A0
 xTW1YWPT7xjm3es4SZlbA4b2KxIo8CKnKQZfOzDwd5Z26/pZt4+Jw005HLWKAIbGoSrN
 lge8JqnC5b/i3DuB8kJwD5ee+KNXN2rb+aMWvPZhenOJhBs15moxV+fQnTzkR5v311io
 iBgA==
X-Gm-Message-State: AOAM533nw+0kIUtpreRXYgLy+zg6WZyL/RzsVCOiiNWT1cCrSmLhmFP1
 qS4pRNjPwbBU8+YPSF/jPVUUkk8yABn8AnrTLaefcg==
X-Google-Smtp-Source: ABdhPJwNzd2zl5gOvT8AIEAOM+a58ORD2lFo8Gb3Ecuyf8uk0eDHHCA3AHnwqPXeDdhypjO8OflVcKhLfxbFpnb+rX8=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id
 l20mr34268706iow.13.1594175391947; 
 Tue, 07 Jul 2020 19:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200707185818.80177-1-ebiggers@kernel.org>
 <20200707185818.80177-5-ebiggers@kernel.org>
In-Reply-To: <20200707185818.80177-5-ebiggers@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 8 Jul 2020 10:29:40 +0800
Message-ID: <CA+Px+wUTqgbT6tAWg+5mek_ZtQdH4=7-ta6ned7PeYy8r_3rVw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ASoC: cros_ec_codec: use sha256() instead of open
 coding
To: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Guenter Roeck <groeck@chromium.org>,
 linux-crypto@vger.kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On Wed, Jul 8, 2020 at 2:59 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that there's a function that calculates the SHA-256 digest of a
> buffer in one step, use it instead of sha256_init() + sha256_update() +
> sha256_final().
>
> Also simplify the code by inlining calculate_sha256() into its caller
> and switching a debug log statement to use %*phN instead of bin2hex().
>
> Cc: alsa-devel@alsa-project.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>
