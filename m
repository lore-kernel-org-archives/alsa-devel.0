Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A4EDE987
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 06:37:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E67D3A4E;
	Thu, 14 Sep 2023 08:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E67D3A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694673440;
	bh=sevoNV3/X2PAmaYm2KSnDHJzBfc21SOc9J1H9OJzUbg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=os9V1/keS0ed/7CgdrogzvAZGlcGLABPu7YQRwYTjNTZH8gHrWNCmDioFhN1bfn0U
	 CorQktka3NXMZW4zOfeHmpnw6btjWlaoe/+pbfQW5VxRnVZhX1MrbkOTBiNrTDlx8R
	 tg+SI1ZVTCH36n6u+CuNxdai29BWLqOYo6JBKZQE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8F66F805CA; Thu, 14 Sep 2023 08:33:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1E4F805E4;
	Thu, 14 Sep 2023 08:33:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA795F80246; Thu, 14 Sep 2023 08:32:47 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 204B2F80425
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 08:30:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 204B2F80425
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCF2C1A062C;
	Thu, 14 Sep 2023 08:30:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8536E1A0640;
	Thu, 14 Sep 2023 08:30:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 99B83183486C;
	Thu, 14 Sep 2023 14:30:41 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 3/9] ASoC: fsl_asrc: move fsl_asrc_common.h to
 include/sound
Date: Thu, 14 Sep 2023 13:53:59 +0800
Message-Id: <1694670845-17070-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694670845-17070-1-git-send-email-shengjiu.wang@nxp.com>
References: <1694670845-17070-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: BS6K7QM6JKXHIZLSCJX2FAQGZCANSMNI
X-Message-ID-Hash: BS6K7QM6JKXHIZLSCJX2FAQGZCANSMNI
X-MailFrom: shengjiu.wang@nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BS6K7QM6JKXHIZLSCJX2FAQGZCANSMNI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Move fsl_asrc_common.h to include/sound that it can be
included from other drivers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 {sound/soc/fsl => include/sound}/fsl_asrc_common.h | 0
 sound/soc/fsl/fsl_asrc.h                           | 2 +-
 sound/soc/fsl/fsl_asrc_dma.c                       | 2 +-
 sound/soc/fsl/fsl_easrc.h                          | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (100%)

diff --git a/sound/soc/fsl/fsl_asrc_common.h b/include/sound/fsl_asrc_common.h
similarity index 100%
rename from sound/soc/fsl/fsl_asrc_common.h
rename to include/sound/fsl_asrc_common.h
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 1c492eb237f5..66544624de7b 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -10,7 +10,7 @@
 #ifndef _FSL_ASRC_H
 #define _FSL_ASRC_H
 
-#include  "fsl_asrc_common.h"
+#include  <sound/fsl_asrc_common.h>
 
 #define ASRC_M2M_INPUTFIFO_WML		0x4
 #define ASRC_M2M_OUTPUTFIFO_WML		0x2
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 05a7d1588d20..b034fee3f1f4 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -12,7 +12,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
-#include "fsl_asrc_common.h"
+#include <sound/fsl_asrc_common.h>
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
diff --git a/sound/soc/fsl/fsl_easrc.h b/sound/soc/fsl/fsl_easrc.h
index bee887c8b4f2..f571647c508f 100644
--- a/sound/soc/fsl/fsl_easrc.h
+++ b/sound/soc/fsl/fsl_easrc.h
@@ -9,7 +9,7 @@
 #include <sound/asound.h>
 #include <linux/dma/imx-dma.h>
 
-#include "fsl_asrc_common.h"
+#include <sound/fsl_asrc_common.h>
 
 /* EASRC Register Map */
 
-- 
2.34.1

