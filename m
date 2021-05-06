Return-Path: <SRS0=TimU=KB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2AC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 02:54:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C4D613BD
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 02:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4D613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99DE81676;
	Thu,  6 May 2021 04:53:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99DE81676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620269649;
	bh=ychGU1Mw9dyykfsD5KN4mnUGeX2MeZj8D8RdDiqLBnw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jIH0hAdgD6TEjAK2g/JaIlGUONW9DlGyohHjk0tvRNYkzZEAssTjHYJWN73rQUyoI
	 erqSC25X3jJgnGrQ3+iKjgP8YOsEwzWHZ+jgCf3Ew8pYY4yZewdbzg/WkHjB+ir8NT
	 xakSV/apWe5CSNSBPHydcfnF7ZQRlt7jh601ZdwE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13B3AF801F7;
	Thu,  6 May 2021 04:53:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41B0AF8021C; Thu,  6 May 2021 04:53:16 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 272BFF80139
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 04:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 272BFF80139
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54BEF20065A;
 Thu,  6 May 2021 04:53:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F71320067D;
 Thu,  6 May 2021 04:53:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C6AE44034D;
 Thu,  6 May 2021 04:46:35 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in
 assignment
Date: Thu,  6 May 2021 10:30:40 +0800
Message-Id: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

The format in rpmsg is defained as unsigned char, there is warning
when convert snd_pcm_format_t to it.

sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    expected unsigned char format
sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    got restricted snd_pcm_format_t [usertype]
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    expected unsigned char format
sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    got restricted snd_pcm_format_t [usertype]

Refine the unused RPMSG_DSD_U16_LE and RPMSG_DSD_U32_LE for these
case to fix this sparse warning.

Fixes: 3c00eceb2a53 ("ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 4 ++--
 sound/soc/fsl/imx-pcm-rpmsg.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 875c0d6df339..3f5913adbfb0 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -161,10 +161,10 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_component *component,
 		msg->s_msg.param.format   = RPMSG_S24_LE;
 		break;
 	case SNDRV_PCM_FORMAT_DSD_U16_LE:
-		msg->s_msg.param.format   = SNDRV_PCM_FORMAT_DSD_U16_LE;
+		msg->s_msg.param.format   = RPMSG_DSD_U16_LE;
 		break;
 	case SNDRV_PCM_FORMAT_DSD_U32_LE:
-		msg->s_msg.param.format   = SNDRV_PCM_FORMAT_DSD_U32_LE;
+		msg->s_msg.param.format   = RPMSG_DSD_U32_LE;
 		break;
 	default:
 		msg->s_msg.param.format   = RPMSG_S32_LE;
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.h b/sound/soc/fsl/imx-pcm-rpmsg.h
index 308d153920a3..8286b55f00ae 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.h
+++ b/sound/soc/fsl/imx-pcm-rpmsg.h
@@ -328,9 +328,9 @@
 #define	RPMSG_S16_LE		0x0
 #define	RPMSG_S24_LE		0x1
 #define	RPMSG_S32_LE		0x2
-#define	RPMSG_DSD_U16_LE	0x3
+#define	RPMSG_DSD_U16_LE	49  /* SNDRV_PCM_FORMAT_DSD_U16_LE */
 #define	RPMSG_DSD_U24_LE	0x4
-#define	RPMSG_DSD_U32_LE	0x5
+#define	RPMSG_DSD_U32_LE	50  /* SNDRV_PCM_FORMAT_DSD_U32_LE */
 
 #define	RPMSG_CH_LEFT		0x0
 #define	RPMSG_CH_RIGHT		0x1
-- 
2.17.1

