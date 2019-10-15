Return-Path: <SRS0=gwzj=YI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4454ECE588
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF85E2168B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E2t/OrUt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XgpucEun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF85E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B405844;
	Tue, 15 Oct 2019 17:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B405844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571153902;
	bh=y/YsG7SHLgzLY6uDHMI7B9ipi6yQXqg6BsSb0U+0H4I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2t/OrUtcv1FzpSvqf1ub/OFAg4tXA/fqwcSHu0TeedBsWTYr879Le+6zMOFkJ8+y
	 9jnKLq7J77Sne/8Cm3ciiAITcsL5hlhxxMHIhifPOL8RQ2T5pE0eZS1QwWsUroTNqW
	 Cilw3lnQvacAKULpPXdL8koslsH3ZcE/WRBL5CBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D830F80323;
	Tue, 15 Oct 2019 17:37:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A99EBF804AA; Tue, 15 Oct 2019 17:37:29 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65612F80323
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 17:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65612F80323
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="XgpucEun"
Received: by mail-ot1-x341.google.com with SMTP id 41so17305405oti.12
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cgNM0n5gGfcK7ckXF49wd8P15GFoQ8+bReW9zILWg9Q=;
 b=XgpucEunT3K6pX5ErPI6Wn+W0xlCbsc7WiKcxyEvdXZKAwGdGprhSgYi2SFRsIzoZY
 S9yz5o6ITvJawDH4K4rU5vXRK9KwEay/uKmLzPuYGcX3ldv2jHavQm5wgfvbyXIZ/jMh
 +w5rpwQuyMbqnhHAHz02NJdZ76o8rQPJOK2dZ3x27deuED/Ey41iqCmBy+FZoxlVLr1L
 GYI5nw2WvBk5mHxGH4/pu1lDCWwHqNGYvMNeBKiv7yddiRXeWYixYQggIgo6KurmLGCK
 1AnVQlthnckQAokX3wYX9Wht5MHsd/LxEa6OpILGleosdgIDTA4YX/cgoaJ0toeAD4lj
 5URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cgNM0n5gGfcK7ckXF49wd8P15GFoQ8+bReW9zILWg9Q=;
 b=qeHYrk58Tq0g0Uti1Skkf+knrwUfDkL8cuohE7MMdkNjYHE0agnbOvYYrV4rr5WXig
 HJNRmj1Vb9jOBxH8XeIJQAToSOscPYyFc+8e7PPOXJwinerHRbdxb/szGLTy0/ZBpdLf
 FssMTySS09nMeA6q+9hL+pE/dY4HpVQe4QBFywWvRGfMWpBpVe39ekmrPrmLyw45uf6C
 /IRJxlzHWNL1vt+XZpQ9dIsAiZsEfrbYZx15GA/eoJKyHe6A7WtcIf+F10llrz7zHLZd
 Jmkk6VohiihntkoP4K8QINcq9lN9rMswgMMSWKMZ5YR0pjJjWe99kjG6kLJ4/EfaGnwa
 3KWQ==
X-Gm-Message-State: APjAAAXKyDZA/EMh+pLLpXNLJtUtiWWvQfQSuNmsJTK3vichEN9zW+O6
 VxbqA6AMWHRDoc+y2W4U3zO4AB/ROUq1SON0Ef8S6Q==
X-Google-Smtp-Source: APXvYqyqTW0ikCL03cio+d+Gzmk4cTMFD83hv3qpHaLEzcsV2fmsdLrCaYZWZY0tNV/gtoVbZOAtyOnX7jjws/nqq2o=
X-Received: by 2002:a05:6830:14ca:: with SMTP id
 t10mr13652260otq.182.1571153843870; 
 Tue, 15 Oct 2019 08:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191014102022.236013-1-tzungbi@google.com>
 <20191014180059.01.I374c311eaca0d47944a37b07acbe48fdb74f734d@changeid>
 <20191015114854.GB4030@sirena.co.uk>
In-Reply-To: <20191015114854.GB4030@sirena.co.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 15 Oct 2019 23:37:12 +0800
Message-ID: <CA+Px+wXoLTdSYQLsg9oTXOW3r9=xqCU4evNcbDjoTcctrtVbPw@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Gwendal Grignou <gwendal@google.com>, devicetree@vger.kernel.org,
 ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Nicolas Boichat <drinkcat@google.com>, robh+dt@kernel.org,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v3 01/10] platform/chrome: cros_ec: remove
	unused EC feature
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Oct 15, 2019 at 7:49 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 14, 2019 at 06:20:13PM +0800, Tzung-Bi Shih wrote:
> > Remove unused EC_FEATURE_AUDIO_CODEC.
>
> What's the route to getting these platform/chrome changes reviewed?
> They don't seem to have got any attention thus far and this one is right
> at the start of the series.

Enric, could you help to review the "platform/chrome" changes in this
series?  All changes have merged in the EC firmware code
(https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h).
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
