Return-Path: <SRS0=BSyU=63=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B014CA90AF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 11:19:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E293206E5
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XeQiPaSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E293206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 564461614;
	Wed, 13 May 2020 13:18:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 564461614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589368735;
	bh=oq0yqvHNT3/6ZgIfAIuvYvhB7CYQtCI1+wx+EecQMuM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XeQiPaSmhEzqHzfIURCeniDZxUtieAMr0Kfu1CdcnltaMszKY4KQhMUqYkTunRFBI
	 jJVH42ZI9Sm0r3CeXBvwz6bkrOAK6dsGtPdpi073GKY/MtkWateKt7EZeWu7KyQWpG
	 81VXFINsAj5U6cLi0+VUd9L5eeH8ic0swlW5NXaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1115F8022D;
	Wed, 13 May 2020 13:18:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19593F80247; Wed, 13 May 2020 13:17:59 +0200 (CEST)
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by alsa1.perex.cz (Postfix) with ESMTP id 0FB95F800E3
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2020 13:17:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FB95F800E3
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35ebbd658feb-cf5ea;
 Wed, 13 May 2020 19:13:28 +0800 (CST)
X-RM-TRANSID: 2ee35ebbd658feb-cf5ea
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65ebbd655ed9-e0e21;
 Wed, 13 May 2020 19:13:28 +0800 (CST)
X-RM-TRANSID: 2ee65ebbd655ed9-e0e21
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
 perex@perex.cz
Subject: [PATCH] ASoC: fsl: imx-audmix: Fix unused assignment to variable 'ret'
Date: Wed, 13 May 2020 19:14:08 +0800
Message-Id: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
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

Omit unused initialized value, because 'ret' will be assigined
by the function snd_soc_component_read().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_audmix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 5faecbeb5..8b9027f76 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -116,7 +116,7 @@ static int fsl_audmix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int reg_val, val, mix_clk;
-	int ret = 0;
+	int ret;
 
 	/* Get current state */
 	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
@@ -159,7 +159,7 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	u32 out_src, mix_clk;
 	unsigned int reg_val, val, mask = 0, ctr = 0;
-	int ret = 0;
+	int ret;
 
 	/* Get current state */
 	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
-- 
2.20.1.windows.1



