Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF979C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:22:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE902072C
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fasmpONI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t5eF1GPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE902072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 964F51670;
	Mon, 17 Feb 2020 04:21:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 964F51670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581909746;
	bh=HmlHmnFPoCCmRSldrX41Sk+Fhg9A7sumnHVC2KOBCsA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fasmpONIL+FkH+dQuSwan4N5DDoEkhk+r+NQ+EvlLdzGL1m67GnHz0Xxys41sOHQH
	 EX7VAJTXHkM9NJYZZsdcZGWrK4DBCDkOb/1ovpnBwAsDF55FLfIzIxPNjhwk8yRUAU
	 OwXSC7nirqYqitZSnuPCTBcrSYEyat5ZhpM3Nc2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2343FF8015E;
	Mon, 17 Feb 2020 04:21:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36FBBF80172; Mon, 17 Feb 2020 04:21:34 +0100 (CET)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D5A4F80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:21:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D5A4F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="t5eF1GPF"
Received: by mail-io1-xd44.google.com with SMTP id m25so16832387ioo.8
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+kmg82PrP5LICQsxhHiVbN5R5NBrtOLNvQPwne/NGOA=;
 b=t5eF1GPF6GoODdlqsDLhBm9YZ93XeswOThOt26rhz68lYQtokb/vXMws9molPaNGgn
 YCzOzoa4OJo6ampwllRBwhc5V2yPxbfiAVCz+I1MVhcXgH0sClaKrchJASLbszzXDUc5
 PcKhaD5sp2Sny4fXmTCuj6e69ZrN5k6XoHp1YwNl2Xe3sHsf1drXgW6CMzXCk6358oVS
 f5+s2M0Hr2BmZ3zq8SGg3NkgrcKyQNCwtu34tk6FDP+xLSk5ABatZ9hwybmW6g0VRCur
 0g3whXZ0pdOD5SUi4ogFS8o8RGJpUzUaOmyI1a4Pj/3IQUZLw9vKtn8equ5zxAKJwZA6
 EfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+kmg82PrP5LICQsxhHiVbN5R5NBrtOLNvQPwne/NGOA=;
 b=gDynKrga9RUiY6oRZ41ARQ3LKW/9c0rHJsr6WXV+P5g5VRtZP/4Clkct97rKcyGIR+
 S0Cg/d0/+ZDHr2BbBhLoPyi4gh+NdxDQf5nosQfDgggoB7zHeuNqI489nVG3Gdf/ahaQ
 j7hY0Y/dzdeljJoahpKupzpGsRzayVnS6JQtS6qSKl9b9376KRt6OtzYStPkssG6ESEd
 P5NY3wCTwVtuhImrtzDKPU3aC6aDcBAjWSwomkCtD2YXRmkISD+16rLNwUBlymvBbshS
 w3UZezPBA80qOuQCEVLQGw59SpA5I0nyS0knCKcxaDakvjCT8nI94jUUeb8i5/8ZNcxx
 GsgQ==
X-Gm-Message-State: APjAAAWxwUCTDHp1ONCHxp8mm/I6gHMa26+i/qNjiQFJd5g/J83w3B+3
 OAh8fIAZrE9v2x3ddln6fY3dBVYJ286kAFWrbyUNWw==
X-Google-Smtp-Source: APXvYqyaPVYhmq/h7UBs6n0tcjgftHnCsB9jpo4a+DwPuDtd3EIywxxxx8zFkzSw8qKGVwWf4dYIvkD+9m0g64cglr8=
X-Received: by 2002:a05:6638:538:: with SMTP id
 j24mr10587053jar.12.1581909688631; 
 Sun, 16 Feb 2020 19:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20200213153226.I477092c2f104fd589133436c3ae4590e6fc6323b@changeid>
 <1581664042.20487.4.camel@mtksdaap41>
 <CA+Px+wW0BWz0-8L_UXJ-OYbwG6W9vmCWRr7kevpk0yokp+NKKg@mail.gmail.com>
 <1581669243.29925.13.camel@mtksdaap41>
 <CA+Px+wUacX+HbgLTSjAuq0feoeYNb5pp=1w8C4_zm=0jGVcHUw@mail.gmail.com>
In-Reply-To: <CA+Px+wUacX+HbgLTSjAuq0feoeYNb5pp=1w8C4_zm=0jGVcHUw@mail.gmail.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 17 Feb 2020 11:21:17 +0800
Message-ID: <CA+Px+wXQGh3rX54TE8Ks8tfFhHPQXUV2PhK2qzME_LFQ+USUQg@mail.gmail.com>
To: CK Hu <ck.hu@mediatek.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, p.zabel@pengutronix.de,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Dylan Reid <dgreid@google.com>, linux-arm-kernel@lists.infradead.org,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] drm/mediatek: fix race condition for HDMI
	jack status reporting
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

On Sat, Feb 15, 2020 at 7:59 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 4:34 PM CK Hu <ck.hu@mediatek.com> wrote:
> > It looks like that even though sound driver is removed, hdmi driver
> > would still callback to sound core. This is so weird. After sound driver
> > is removed, hdmi driver would callback with codec_dev which is invalid.
> > I think this may cause some problem.
>
> Will do some tests and get back to you.

Please see https://patchwork.kernel.org/cover/11385055/ for the
proposed solution.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
