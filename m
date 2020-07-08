Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15FDC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2C620774
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t9KPWrP7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdQj6NOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2C620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF38415F2;
	Wed,  8 Jul 2020 07:47:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF38415F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594187329;
	bh=odr9trJsY+/VsC6Xosek0mSc+vQ6GbRDKEYdCCZMdSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9KPWrP79yn+VXa23kV2ogWI5zCBJsWxpuB+GP04KoCRrsXVrVShldI23VQfYKJNy
	 IJ+ZwKz1jv245fnmQDHT0e9WQtbzG/k4Gr0JrUDUKPEGRnewLYOP38ThokH8RfE5lX
	 XHku0ykZgj98+5UHANs653PfZKWxb9G3UL1U1Rw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FEA5F80150;
	Wed,  8 Jul 2020 07:47:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71531F8015A; Wed,  8 Jul 2020 07:47:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA8FF800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 07:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EA8FF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QdQj6NOX"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BCFF207BB
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594187272;
 bh=odr9trJsY+/VsC6Xosek0mSc+vQ6GbRDKEYdCCZMdSo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QdQj6NOXnMcIaEde9I8wnVhX5udKqmtjfCgAjEZarbwMx7wP1jDq6Mlf33L4TJqH4
 ZxcsR5Xjg4pSyqPWParZr08LHAL9T2pI+rblZ2uZt92Gwmq0vFbocy33ZYi3qpz2WD
 0FmZsuP+AWos9zMRlXTvxQ2FSgIiXfx4mRj7Wd5E=
Received: by mail-ot1-f46.google.com with SMTP id d4so36130242otk.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 22:47:52 -0700 (PDT)
X-Gm-Message-State: AOAM530RU4q5LYhS4OyhsDMLPYTo+JRLCYASoyMxINZphlPm0bAGWxS4
 5+ljlsZ91M33JZW3AZM3Isb/zL3bGgvMWC/AmEM=
X-Google-Smtp-Source: ABdhPJxVYM8G/B91PuoHI3iKlcsxr9nlkQXIwunWm/EyQD8zmmYal7JTvWLeKxe5TkUvrvVN48Cl7uzrWGntQzgKkMs=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr7858191otr.90.1594187271970;
 Tue, 07 Jul 2020 22:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200707185818.80177-1-ebiggers@kernel.org>
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 8 Jul 2020 08:47:40 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHPazApxFDK9nz=1V+-dyu7dStiMOu=LdD=i9NXqxjY=g@mail.gmail.com>
Message-ID: <CAMj1kXHPazApxFDK9nz=1V+-dyu7dStiMOu=LdD=i9NXqxjY=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] crypto: add sha256() function
To: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 linux-efi <linux-efi@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Hans de Goede <hdegoede@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Tzung-Bi Shih <tzungbi@google.com>, mptcp@lists.01.org,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

On Tue, 7 Jul 2020 at 21:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
>
> Patches 2-4 then convert some users to use it.
>
> Eric Biggers (4):
>   crypto: lib/sha256 - add sha256() function
>   efi: use sha256() instead of open coding
>   mptcp: use sha256() instead of open coding
>   ASoC: cros_ec_codec: use sha256() instead of open coding
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Feel free to take the EFI patch through the crypto tree.


>  drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>  include/crypto/sha.h                     |  1 +
>  lib/crypto/sha256.c                      | 10 +++++++++
>  net/mptcp/crypto.c                       | 15 +++----------
>  sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>  5 files changed, 19 insertions(+), 43 deletions(-)
>
>
> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
> --
> 2.27.0
>
