Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F028C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:25:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF07620C56
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d6nKlY0U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EawcP4Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF07620C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65A711616;
	Fri,  5 Jun 2020 14:24:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65A711616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591359944;
	bh=2XUGZR54jn4NwjK+Ez8x0NFFsobIka+zfI9ayPRtjBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6nKlY0UQv0xhPb0E93Mcprjk9qZzSihiRpF+Wg9T4m5kAaGAspa+wr2BQ6UyEkYW
	 THbBjeo/e5yYco851SlFp57vdE2KG/mbgJOq4iOyEpgkTSj0o7bmF5/3e3B2bRACL5
	 Dy0maAvHqr2o3/KtctuROdoFsU2HcsqAD3XIeH+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA565F80132;
	Fri,  5 Jun 2020 14:24:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17C2BF801ED; Fri,  5 Jun 2020 14:24:52 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA1A0F80132
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 14:24:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA1A0F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="EawcP4Ep"
Received: by mail-il1-x142.google.com with SMTP id g3so9287821ilq.10
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2020 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kIfn0QHMP7CK4Hmgml37SRcHqGH4aTtKIuqHQUCLWRQ=;
 b=EawcP4EporkwrqfLPgvSKZWlEE1ID85TieWCHY9LwiKd+HIWVF0QxVSawt8hyzZZA8
 QXJ2pNFwn2Ify3QvL2OneyDAR505YIqjhKzJNYhUVvWgjj9lx52Iq2Aqz4dkftCr4YN5
 esT7/cpbLK9xB2nYLvrPz1qbc1Jt6Uo7VHWrud5qxemkEHW91lVv59CjdFHDnMAbn/BD
 kkCNiXNYmNFMH635f2w+rTyfZuBaHtwXgUEm3k2UI4/y5jZ373klw6RMSRCkefE+qdjy
 RqUsL1NqHhjxO/v4NWOxFztHbXvT7SRoAUQpFoeWdvf/XV9bU9cHguBRm9pITOknMnBd
 2W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kIfn0QHMP7CK4Hmgml37SRcHqGH4aTtKIuqHQUCLWRQ=;
 b=eYp4RZef/eQcPju6FbgZC5IvvPHLKdKy2FUbEUEuvMOXgK83ZfpEh/QP6U8O7m0wYd
 +M07UkTKTKVzK4hYae+Rw7H/ifBy7LHzCw3u1bxACv4U256UU/521gm3c99+kGz5bHdL
 y+Dal5hAYrAhYk0DwSGGx6obP35lqW+t3e/xUuxYICK18ksdUJKj3cImQ2B4dmli6WPm
 LP+bmyfP7Dl+uZ9wBWK7g+3h3IAuKa995TUXfsBSbNbkCJDR+CRi0hRnyGM6dwxwPkyI
 +5iMfC+pxAosyrRnWEb7qB+vP/Uc4Ypep4P9wVbj+2KRcLtN+/VfirUamcE4U7DfdEwq
 JSoQ==
X-Gm-Message-State: AOAM531tB/hNX61s+ALkF7FandA7QY5zIPhu2CIjhWATZLhVhgOiXs97
 eb0y0aZZxZQMBKSRHvH4uuYyYdbP3nr6EUGWxzJskg==
X-Google-Smtp-Source: ABdhPJxIJRIn8uLBn8iAB1Nr4R5l0zbAftEc1md7w19YTUWpfcp8liEx8XFB8UBZsNB8M/Dg27ZKhc4KMp4ZpswjQ+Q=
X-Received: by 2002:a05:6e02:1350:: with SMTP id
 k16mr7686913ilr.213.1591359882249; 
 Fri, 05 Jun 2020 05:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 5 Jun 2020 20:24:31 +0800
Message-ID: <CA+Px+wV8U6Y-tppLPUdoOgQhpss-DUm-YDQX7TZ1uHHH7JMyZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 howie.huang@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 5, 2020 at 6:37 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> Jiaxin Yu (2):
>   ASoC: mediatek: mt6358: support DMIC one-wire mode
Has done previous round review on https://crrev.com/c/2230089

>   ASoC: dt-bindings: mediatek: mt6358: add dmic-mode property
Has done previous round review on https://crrev.com/c/2230086

>  Documentation/devicetree/bindings/sound/mt6358.txt |  6 ++++++
>  sound/soc/codecs/mt6358.c                          | 23 +++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)

With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
