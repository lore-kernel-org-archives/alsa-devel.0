Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765DBC432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 02:26:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B9D610C9
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 02:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53B9D610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A662E166D;
	Thu, 26 Aug 2021 04:25:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A662E166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629944788;
	bh=lHMnRMA4aLfvjvUNQZNiBKsyp8BWAq3H6nDzKVWcUlw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hoxcMAFjjgOWvIbIcr/JJFmf4SIA5D74z858Bd66PLTUlbB7g+Jn1v75QxxTv9AVu
	 9zhtRGKNHnJtxrjK2MENAHRl61jeFtkp//cVdfWd55qF8IyTQ5YZVJLtQr+ghjBNVe
	 cY+aJN0W6bXNeTn2ma5u3YT6VXZlBnNXKn2+WUyc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EBDEF8013F;
	Thu, 26 Aug 2021 04:25:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78E04F801D8; Thu, 26 Aug 2021 04:25:35 +0200 (CEST)
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5371AF8013F
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 04:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5371AF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="CNgzwNhG"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 17Q2OrSd027525
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 11:24:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 17Q2OrSd027525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1629944693;
 bh=d+AhyAERcvxh7BiYq2ElJkN7iLAXCwUv6UgSMsPKu74=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CNgzwNhGDlLum2EBrBPzXzIdyjpIas0Y+NGmekx/BDBP1E7B39hjx6NP8GxxzN8dc
 jxUGzqsab/nL5UXGq7eyHvnQLst1jqoH2G5HU2Z7uAqahoIiumWZL60vtzOA84ybQm
 Uh7MHhofTbhUAgfPNROwLJsKcUGdea4vVad0tZRjN1wBEMlJHjnF7WTcEiuktq5eyk
 ft80RzSYGRxTEeKtazr9OBbZ7buOkh/CMexm490CU+0JiQlxbZBTsQ1i5EUXbwZroa
 Q6NEhp6o1PtbnyOkcLONBqoQt2z6Lwr84DxJcnqTUiL2jjBcNXTLAyupBjah3P3tan
 Njey37RG80jsw==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id
 j4-20020a17090a734400b0018f6dd1ec97so1246672pjs.3
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 19:24:53 -0700 (PDT)
X-Gm-Message-State: AOAM532XnLiNVGATSiLPIuNMAeuw6c4zP4O73r+rddWjRAcBpQKcAzvd
 v09V96iPI6tqdtO2xmDDohfRyx7AmaK91S8Y9kI=
X-Google-Smtp-Source: ABdhPJw2EzwVb2S7fExRdpLksQsCs6YsBhQqntXqcomXVhX20PH/b2rdtnGXTKMbAl7GvXo5xuFBUf00afHREEkilBQ=
X-Received: by 2002:a17:90a:a581:: with SMTP id
 b1mr1441813pjq.153.1629944692537; 
 Wed, 25 Aug 2021 19:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210825041637.365171-1-masahiroy@kernel.org>
 <boris.20210825172545@codesynthesis.com>
In-Reply-To: <boris.20210825172545@codesynthesis.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 26 Aug 2021 11:24:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-NhR=94uHYcZUhRkdUEm=dYZSRbGKkB5zJJGNRw0z2A@mail.gmail.com>
Message-ID: <CAK7LNAS-NhR=94uHYcZUhRkdUEm=dYZSRbGKkB5zJJGNRw0z2A@mail.gmail.com>
Subject: Re: [PATCH] kconfig: forbid symbols that end with '_MODULE'
To: Boris Kolpackov <boris@codesynthesis.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, linux-wireless@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Luca Coelho <luciano.coelho@intel.com>, Networking <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
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

On Thu, Aug 26, 2021 at 12:42 AM Boris Kolpackov
<boris@codesynthesis.com> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
>
> > Kconfig (syncconfig) generates include/generated/autoconf.h to make
> > CONFIG options available to the pre-processor.
> >
> > The macros are suffixed with '_MODULE' for symbols with the value 'm'.
> >
> > Here is a conflict; CONFIG_FOO=m results in '#define CONFIG_FOO_MODULE 1',
> > but CONFIG_FOO_MODULE=y also results in the same define.
> >
> > fixdep always assumes CONFIG_FOO_MODULE comes from CONFIG_FOO=m, so the
> > dependency is not properly tracked for symbols that end with '_MODULE'.
>
> It seem to me the problem is in autoconf.h/fixdep, not in the Kconfig
> language.


Partly a Kconfig problem since autoconf.h is generated by Kconfig.

So, what is your suggestion for doing this correctly?
(of course without breaking the compatibility
because this is how the kernel is configured/built
for more than 20 years)




>
> > This commit makes Kconfig error out if it finds a symbol suffixed with
> > '_MODULE'.
>
> I know you don't care, but I will voice my objection, for the record:
> Kconfig is used by projects other than the Linux kernel and some of
> them do not use the autoconf.h functionality. For such projects this
> restriction seems arbitrary and potentially backwards-incompatible.

I am not sure what your worry is, but this check resides in
"if (modules_sym)" conditional, so projects using Kconfig but
not module functionality (e.g. buildroot) will not be  affected.



-- 
Best Regards
Masahiro Yamada
