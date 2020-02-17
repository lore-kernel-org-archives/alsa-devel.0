Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14586C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:56:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911E72072C
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OWlBFvOx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gxFKXkh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911E72072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03B6B83B;
	Mon, 17 Feb 2020 04:55:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03B6B83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581911792;
	bh=/C7epqqg7LAIND+pRlmG5yRnXdXQYg5+7ntc2FcUmVY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWlBFvOx/oAbHz4vKRiia11HkIVVpJWRzBx79cJsJF+jkh8htoiIIWQbF7nqyPBEf
	 J9gKUYJUk2y+5xf4c6pDmDkv9hUdLJprc5543pEuvq1hGCBf3aKsY5Khu19iiwVb4O
	 sgqbCRGYOwmKqhB5jv31c6LUP5WtsKMVFVYORQy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8984F8015E;
	Mon, 17 Feb 2020 04:55:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB0CBF80172; Mon, 17 Feb 2020 04:55:38 +0100 (CET)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FA7CF80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:55:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FA7CF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="gxFKXkh2"
Received: by mail-io1-xd43.google.com with SMTP id x1so5483421iop.7
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MDRwOw0qxHT8lr0hMdZ3Qai+ub8w2eSiYOEUSVqxsao=;
 b=gxFKXkh2sDRFMwdMCiVPpZM94a7Wqh//+i/PPGKzGqg109MExjedklZrYzYfEB1dOn
 1RSy4HwVcYyZEyQT2/50sKFaxsQXYw/KUtPQSDP0SgMbgkHZYACNmTy3pk+RfjP8wJ8H
 vIQbzTSkumfZSiOX1QkrO62yBG89y3JCzRkpualHWXG0WOZs2WCVsNdPN/uMBuN1PInl
 oqcehkB6H/Yc1VLJ3pAYtnF9A9V2mJze/G9H/eo22rOrbk+WDlH62AIzov8o++KQFpd7
 KP75BTi8ZU1s49FOmVefZoWDFS4sgNo3WYKRPRPKOjsYYbG/apbzhJqjc7u5AOkSY0o2
 u4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MDRwOw0qxHT8lr0hMdZ3Qai+ub8w2eSiYOEUSVqxsao=;
 b=oCecx9+X/fl6YWIt2A741Oho6eGoJ678ZQwohD4NGQixXFST9CCbxQFOKz1buI+t2P
 0ePD3anOYyGRMdrO2OOmwhjXIuYa//BpZBC1c5cucscRsau+g0lfVSLJ78hwhvdUMbND
 b0LRbQilnRvIFBe/42vz8rHGLkdDINGhLTUVIMRwHCW0mQuRxK25E5CvOpF+YF5GBFOG
 Li2utBtynmxx9kR438u8kBmavvx1ZQoQv8e9b8DsOU3DdXejb1cakRCO0Rr+sLO64aac
 GmcRRRHn9NNUWSLElb2utBaaI7pqUAlDeY3TnRAuoagDXOUP4OzRChrdfXH/TPrxTlnl
 dtKA==
X-Gm-Message-State: APjAAAWD3muLp3eyy5IUPE18UnJJ0/gw4fwYxmwTnxFlsK8414W4ESM+
 vCrPHbi17lew/8Vfp30aa0RL2X4SntIsPovO6ZSslA==
X-Google-Smtp-Source: APXvYqzvM4FCMTrCi0v8wV4k9sbQWYIUffnsL+Kp3MW2/ZQ6XXOz2og41iziG0mONHGsGItgPmiMVNuzIdWL8NvO3J8=
X-Received: by 2002:a02:2101:: with SMTP id e1mr11084540jaa.29.1581911728799; 
 Sun, 16 Feb 2020 19:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200217031653.52345-1-tzungbi@google.com>
 <20200217105513.2.I477092c2f104fd589133436c3ae4590e6fc6323b@changeid>
 <1581911058.12629.1.camel@mtksdaap41>
In-Reply-To: <1581911058.12629.1.camel@mtksdaap41>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 17 Feb 2020 11:55:17 +0800
Message-ID: <CA+Px+wWRn1-t2fd+bD-PGRVjyLaAHqm1wF3W3T_GMUh0GXkA_A@mail.gmail.com>
To: CK Hu <ck.hu@mediatek.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, p.zabel@pengutronix.de,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Dylan Reid <dgreid@google.com>, linux-arm-kernel@lists.infradead.org,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH v2 2/2] drm/mediatek: fix race condition
 for HDMI jack status reporting
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

On Mon, Feb 17, 2020 at 11:44 AM CK Hu <ck.hu@mediatek.com> wrote:
> On Mon, 2020-02-17 at 11:16 +0800, Tzung-Bi Shih wrote:
> > Fixes: 5d3c64477392 ("drm/mediatek: support HDMI jack status reporting")
>
> This patch looks good to me, but please merge this patch with the patch
> it fix.

5d3c64477392 ("drm/mediatek: support HDMI jack status reporting") has
applied to ASoC for-next branch.  This is a fixup patch.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
