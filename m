Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBDC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 08:22:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBA4611BD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 08:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FBA4611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E062A83B;
	Tue,  9 Nov 2021 09:21:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E062A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636446123;
	bh=DKVg9sxFF7KkDsYsJ2kyK9iOAkgZCIk72eYOX0sPY7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QICkuYpESjqw00ZXAbcKGNf6MZHugFDf/myrI0gBmQmSqO1MFWWBmF+JAa61oy6B9
	 FysJ4Sf1Ziikien7A/5OcF6W3y2PPOMlme1y+V9RiM3xXoulkNoMTYgC01OpUnJs25
	 xjhVs7y0OyuooKS72xqrGpjB89l1HcgvcovcyTQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A435F80224;
	Tue,  9 Nov 2021 09:21:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DD5EF802D2; Tue,  9 Nov 2021 09:21:08 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED01FF801D8
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 09:21:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED01FF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qcqOzcb+"
Received: by mail-pg1-x529.google.com with SMTP id j9so17821994pgh.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2021 00:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DKVg9sxFF7KkDsYsJ2kyK9iOAkgZCIk72eYOX0sPY7I=;
 b=qcqOzcb+4K1liquhkvg0C6k9R6kPGF+XGZY3Jt57IOJF4Kog3dkDHhVlcIFKj9jUWG
 EkOD5mIo/yMJ1/pDLUKXqhZnaIY1zClvP9oYbhtcf79UtIYa8d8uippHbO5C7n2dBI6D
 iF7NRgtSFKPiEH8s/tuOVmnlpXg/2RBrAwSD+FBt4TnETGDdxp5HeiDH2T+rGuOnC4nq
 F+vvowMTPZrDJ/DXfB6MR6L32XYafWSlhh6Q1DISoxSUoemkEaaaQ8NrUBYN0Bh93df1
 HnQWoVFmv1QQaVZMq+7A1TW5nyEJfOgAfLqCi6qt8Mj2h+gY4xtY/uZA/FQNLdzUIBLm
 zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DKVg9sxFF7KkDsYsJ2kyK9iOAkgZCIk72eYOX0sPY7I=;
 b=mA23CfUfwCFfz+gm27lEaSFagh4CaUQbBaQkEYxAJcQk4aP1uLOsMVoZWzH/2LhYFY
 h3pg3yrvuvNrXXg8m+iXjNXS0iocwIe2V10zLwv0WUp0tGTD8ljObTuSdbt5E3gVW20R
 Nb2qSddWvisMcUbXzAy5CfS7gZES/zSJcpX8ZC4uS6LR5MRnaBs8vAnYIdcN99Gw8k/h
 zP+a/q9RCHCDfLMoIn7keCqmWJ8GubStBqN1IvMzMJfcdmYGcLx5ibLdcFK6/84Mw6S2
 TdGqtjTTgrICqWUnxuN9xXbNx/5+x10/BSXTp9xp/DniQhO5mdeOdStCJUrnTzIaaIGu
 IbKw==
X-Gm-Message-State: AOAM533OMMQT/XLU4O6om6zTDiTTMUxib1IHljX7T231G9g0hk3YFwCt
 1mbd5543Rbybd/mlNpsd1nXrPmdGrEdd0I/K12E=
X-Google-Smtp-Source: ABdhPJzJUjRLlyo7JdDdyBu3gcVbAsM6kHhBtoT1Aw3Ze+/090Iz9heLoRZeZ4XrugWpuCyngZl+ic8HFm4NJBmP1r8=
X-Received: by 2002:a05:6a00:15ca:b0:49f:d22b:afff with SMTP id
 o10-20020a056a0015ca00b0049fd22bafffmr6214367pfu.35.1636446056399; Tue, 09
 Nov 2021 00:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20211109003742.GA5423@raspberrypi> <s5h5yt1c0di.wl-tiwai@suse.de>
In-Reply-To: <s5h5yt1c0di.wl-tiwai@suse.de>
From: Austin Kim <austindh.kim@gmail.com>
Date: Tue, 9 Nov 2021 17:20:47 +0900
Message-ID: <CADLLry6o=NmreEhe1BF2czW4dhKAUyi271uQEfUrGoObjpy7QQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: missing check for possible NULL after the call to
 kstrdup
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alsa-devel@alsa-project.org, tiwai@suse.com,
 =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
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

2021=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:24, T=
akashi Iwai <tiwai@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, 09 Nov 2021 01:37:42 +0100,
> Austin Kim wrote:
> >
> > From: Austin Kim <austin.kim@lge.com>
> >
> > If kcalloc() return NULL due to memory starvation, it is possible for
> > kstrdup() to return NULL in similar case. So add null check after the c=
all
> > to kstrdup() is made.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
>
> Thanks, applied now with a minor coding-style fix (we need no extra
> parentheses), the correction of the subject line with the proper
> prefix, and the addition of Cc-to-stable.
>

Great, Thanks

BR,
Austin Kim

>
> Takashi
