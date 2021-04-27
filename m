Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707ECC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:51:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE255613BC
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE255613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D4B716DE;
	Tue, 27 Apr 2021 12:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D4B716DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619520663;
	bh=TOtUd3yP7V+11B2s7KmjDKKjR6kiSRraV3W0HX/ToIk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bZ5rd2gr7qGiOJ038wionDwKleG7CyYqoy+sOivhxpZwm31zvEeUluyYRHDhyr5IG
	 JBlMPYwlF4xNoP8Q5BYrhfKKlfZkkmAlooDFplnByPBM2kIaH9icPpFQmRz2DgTdst
	 Oy4l83wmW8UoXHoXKqyFjQlb4U+BTgTPt/9Bfi0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B117DF801EC;
	Tue, 27 Apr 2021 12:50:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D466F801ED; Tue, 27 Apr 2021 12:50:11 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73ACEF800C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73ACEF800C0
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B56251A164A;
 Tue, 27 Apr 2021 12:49:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DDC51A0A59;
 Tue, 27 Apr 2021 12:49:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F03E4029D;
 Tue, 27 Apr 2021 12:49:49 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: [PATCH 1/2] ALSA: pcm: Add support for 705.6KHz and 768KHz sample rate
Date: Tue, 27 Apr 2021 18:34:22 +0800
Message-Id: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

Some high resolution codecs support 705.6KHz and 768KHz rates.
So extend supported sample rate to 768kHz in pcm.h.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/pcm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2e1200d17d0c..88056824ffec 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -121,6 +121,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
 #define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
 #define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
+#define SNDRV_PCM_RATE_705600		(1<<15)		/* 705600Hz */
+#define SNDRV_PCM_RATE_768000		(1<<16)		/* 768000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -136,6 +138,9 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|\
 					 SNDRV_PCM_RATE_352800|\
 					 SNDRV_PCM_RATE_384000)
+#define SNDRV_PCM_RATE_8000_768000	(SNDRV_PCM_RATE_8000_768000|\
+					 SNDRV_PCM_RATE_705600|\
+					 SNDRV_PCM_RATE_768000)
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
-- 
2.27.0

