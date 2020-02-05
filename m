Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8EC33CA1
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859F21741
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hV1ZLHmA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MPdYJEe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDD301616;
	Wed,  5 Feb 2020 10:38:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDD301616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580895539;
	bh=xI+JEtnYWbyo3hx4DrcxuOLzKxfC4s+OiFEWv80E/ss=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hV1ZLHmAvUIQg6xNxGf6QgLoNmJdROW6sFI2XGwRasvB0SiwpkM2ZAshVEHbnFYw4
	 PhEjhc1KrAvtxufb5ohCMi4CI4hpqsOGITyAGkV7sC+oWGVvMOMWXH4uc8zR+xqrwH
	 ML76DmDr4Uh+cPDP4c7L1j5ZUCrarHvjw9/x1p54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FF19F80142;
	Wed,  5 Feb 2020 10:38:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E5BCF80148; Wed,  5 Feb 2020 10:38:07 +0100 (CET)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B87FF800E2
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 10:38:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B87FF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="MPdYJEe/"
Received: by mail-qk1-x749.google.com with SMTP id y6so880582qki.13
 for <alsa-devel@alsa-project.org>; Wed, 05 Feb 2020 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=t+hNfXtjwFMsmQ+t75tk3QCZWXLmXlUbrDyATbIS/Bc=;
 b=MPdYJEe/X6+UOZ/iI1BO4xiJs31/Seqbo6Q05MkN0brP5sV4pUta35ASqc5ULG8ziQ
 MIUHRAe8OceKhjKHENrwwX88Qlu0xqxjT9OFOuFAAHORAv2N3GXNou/tSWw1lGrfXJoc
 1O9xQ4fansGi92J16e/+mBRYDj8j0Pb55onstvRNM6TkiRBJJOdqXPfRsL4YUzImAPeD
 gVXNWPUqdg9Cw6znnQcyC87bJXikYGVVqErTVVC9yv9HOZvUaMY94ZIEwBU2Y2wQGjGV
 t3LQeT3oP6JZ1MG+jwnSUPEbUi1mKjw1OJDzO4MlWdnEkb+z4ifpd/IdsuYlVLNIaIdZ
 rWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=t+hNfXtjwFMsmQ+t75tk3QCZWXLmXlUbrDyATbIS/Bc=;
 b=CCd0AofNKVycT537Uq8JldK0Z6Nno2DL+V7av9453Ix7iWyq5ehjcqQ6G+aX1RxlUl
 YaSgW9eihDNoQQoxnABmFj8QD2WcZpREAh/lm2bL6AkxYvo2vJ43zjeHVX/CAq8PezAm
 66dCkWGXmuKi547i8Km1G+TpEd/wYR10SNXB67csz+l8uGa8aD9tRqcP/zUkuGadiuXs
 cdUQizF9YbqMaplfbwimYZ9rRKAG9AqxVPRdglEfQGQx8H7ZzSbulA85oluTN/zky+GS
 tBTpFcx1ABrCOTpRz4ER399QxYxAp0uI+HiOQV6PYi0DfgCujg2xBdUDvKkdPxju+EOA
 u/uw==
X-Gm-Message-State: APjAAAVriss5bS0hC2ZFPd1/zBH/yA8wXmvvd/9pVxCBVYNCc1JJFuWf
 8s2SRFuQa59baPPprEdPWva2mxQ92rRq
X-Google-Smtp-Source: APXvYqxWq6o7mBKpCGRPGamchrFfwa2yARrxJ2bCNGi7q5SP7eZKkfVJhzmt1ZrNjdgv4w8hfmP3yhbrXV7A
X-Received: by 2002:a37:de0b:: with SMTP id h11mr9177628qkj.274.1580895480903; 
 Wed, 05 Feb 2020 01:38:00 -0800 (PST)
Date: Wed,  5 Feb 2020 17:37:42 +0800
Message-Id: <20200205093745.79298-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 0/3] ASoC: mediatek: mt8173-rt5650: HDMI jack
	reporting
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

The series supports HDMI jack reporting to mt8173-rt5650.

The 1st patch is less related.  It stops running in probe() if failed
to register audio driver.

The 2nd patch supports jack reporting in DRM driver.

The 3rd patch supports jack reporting in mt8173-rt5650 ASoC machine
driver.

Tzung-Bi Shih (3):
  drm/mediatek: exit earlier if failed to register audio driver
  drm/mediatek: support HDMI jack status reporting
  ASoC: mediatek: mt8173-rt5650: support HDMI jack reporting

 drivers/gpu/drm/mediatek/mtk_hdmi.c       | 52 ++++++++++++++++++++---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 17 +++++++-
 2 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
