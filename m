Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC8CA9EA9
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:40:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9272821835
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TDJL6FJz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o/AVbTpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9272821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A15284C;
	Fri, 18 Oct 2019 20:39:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A15284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571424028;
	bh=0M8yrAB1TypbvXOS4XVUhuQyqnPsdj+4u3+4vJjpCL8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDJL6FJzGdfRmrJlyZL21cuXH0/LIHXk5DSKVBArwq/OK35w/G85/lEmJtOaQn+i0
	 7DlD0wopSrHmkYt42X0svAnPPJjlnRA0kSlLpL3dW+wVXKo0ofCRq3yTo0UGqJHYlZ
	 RVRyZJZtV5+YKUAXDdvRgR0lVz9yqyDXI4+6Qong=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA7BBF80322;
	Fri, 18 Oct 2019 20:39:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E6E7F80362; Fri, 18 Oct 2019 20:39:36 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE942F800D0
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 20:39:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE942F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="o/AVbTpu"
Received: by mail-oi1-x244.google.com with SMTP id w6so6020049oie.11
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ehXsduEufI5Z+LBu/3xJfIT3IHAbo4RBsjs4lfnOsVk=;
 b=o/AVbTpufUwVlLw2IH/kyrPmX5xyRp44PPCK3+dvQqhbPzdxFfvfgvRB824YVwCV0b
 mHqfyg6EpZaITHapp0pRDP2YbEiJYwY0ogseEBdeB508tsHikcI+3IU9/gwOyYLdFeZJ
 ZbUxVMHy/OfJqH5PJ5xLmgv1zZXoykz9Po7XmLQb38fzB/GL5hehWemXS9xrd6SDM7CQ
 Q6PjTvwvLbbIl3HV57RNVYg7yCrIN6cLFa3oI4z8jEAZrX9JkRhkeU1Nyckec2RDdohC
 oTcePShT2dSO6AZn7lKOwlXD/Hxbl63zjBDfrabfW33D13eqDuR+PLGHRlyL5s4xbSe6
 kFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ehXsduEufI5Z+LBu/3xJfIT3IHAbo4RBsjs4lfnOsVk=;
 b=ed1uGTQBWp3DxqYKSXfr3o0gLDmf4QqbYlA7to5630iqbdK5cdr6TPSqb8TLqniHxM
 TbAoa4KcUp1WEriMwAN9vs/79i2sOPkl0atGDCYzbJv3DlTb0L9A6uYVNOW1ZDZ/GGpf
 m5rUMPkuToXSMOqh1WNXjXwVB65z9y8/D+0V4QzaU4XmSz/R7Aa7Er1aeKCjzKxjM0+T
 eQ/f1DTehPzYJsAxkFwAQlmRDojxIHJDdIA4sClqukhRN00CDoxjOFEMcpXw1tnx3JFc
 i/hBvlV1Ii+/2QtiBbLKdvmsLdnrxeJhVm1+tyikol7Y2W+UJo4jnXrM9R/jkDV8DrZ8
 7b0w==
X-Gm-Message-State: APjAAAX9uKaDy5gUveKYJxgHnSyuW19Z/6KJNcbjMl4iA76g368UNZ90
 MN9qwxL8SFeDbO4D4D475fgh2JdAp/ZrgBGs6RsCPg==
X-Google-Smtp-Source: APXvYqxcAVv4IVYlFSWySPq8REWSKrEYBWbH7O/dQ1RvjD6j98hFsYaeP0zxpJA7Pbnh2oTn4bFCnA5uGkjCuSXZ2nQ=
X-Received: by 2002:aca:1a18:: with SMTP id a24mr9341535oia.145.1571423971400; 
 Fri, 18 Oct 2019 11:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191017213539.00-tzungbi@google.com>
 <20191017213539.07.I5388b69a7a9c551078fed216a77440cee6dedf49@changeid>
 <20191018172220.GC4828@sirena.co.uk>
In-Reply-To: <20191018172220.GC4828@sirena.co.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Sat, 19 Oct 2019 02:39:20 +0800
Message-ID: <CA+Px+wXCjaP1uktHLffRCe2C1P_D21f2+A=HDdhutoGv-BVzZQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Gwendal Grignou <gwendal@google.com>, devicetree@vger.kernel.org,
 ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Nicolas Boichat <drinkcat@google.com>, robh+dt@kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v4 07/10] ASoC: cros_ec_codec: support WoV
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

On Sat, Oct 19, 2019 at 1:22 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 10:00:12PM +0800, Tzung-Bi Shih wrote:
> > 1. Get EC codec's capabilities.
> > 2. Get and set SHM address if any.
> > 3. Transmit language model to EC codec if needed.
> > 4. Start to read audio data from EC codec if receives host event.
>
> This breaks the build:
>
> ld: sound/soc/codecs/cros_ec_codec.o: in function `calculate_sha256.isra.15':
> cros_ec_codec.c:(.text+0x119d): undefined reference to `crypto_alloc_shash'
> ld: cros_ec_codec.c:(.text+0x11c1): undefined reference to `crypto_shash_digest'
> ld: cros_ec_codec.c:(.text+0x11df): undefined reference to `crypto_destroy_tfm'
> make: *** [Makefile:1094: vmlinux] Error 1

Thanks so much for pointing this out.  Yeah, I forgot to select
CRYPTO_SHA256 in Kconfig.

Looks like there is a blind point in my local build tests
(allyesconfig, allnoconfig, allmodconfig).  The config in the build
fail case could be "CROS_EC_CODEC=y" and "CRYPTO_*=n".

Could you tell me how you get the .config (to enhance my local build
tests next time)?  I tried randconfig several times but it seems not
easy to hit the case (i.e. CROS_EC_CODEC=y but CRYPTO_*=n).
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
