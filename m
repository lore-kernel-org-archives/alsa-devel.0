Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB62C47096
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:12:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAF2613D7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAF2613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE9E5172D;
	Thu,  3 Jun 2021 19:11:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE9E5172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622740321;
	bh=Yj6PSnT7sMaVAfUtyqwp/ioxZKN6h05NLJ/hGU0xVfA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7pkXH7PNdzC8f+HCRndM6rguQx0KSr/8lFdu7WZ8kA+UUAfaMVUIue2YqlqBKnMf
	 cj/Ejnv2dCTfryNLhJUwnHpC83YyPGxV2Bb8bOcVwRxGdKmvbG38yC2wcXJnsfLMaQ
	 F3v3VFL5gX/KdgF0N0Nw3JAi2Pbor4WDnfTtfpF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01AD6F804F2;
	Thu,  3 Jun 2021 19:08:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE03EF804E7; Thu,  3 Jun 2021 19:08:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B035EF804E5
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 19:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B035EF804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ugM2Wv9E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47F91613FF;
 Thu,  3 Jun 2021 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740113;
 bh=Yj6PSnT7sMaVAfUtyqwp/ioxZKN6h05NLJ/hGU0xVfA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ugM2Wv9E8rzV26TxdnfmLoyuC/VZul9g+aSFiUdNCGmaMrxr+UGPzTHdJ+m6hWJSP
 6aS3B+ByrZxgh/SzhFuFueXLPVE20aG0J0lGdM4iOudhREjN/Y/vfRUmpgGjvFX1O7
 scvyDuQmoH5rFs0NY3iaNuEroW1kOXKROxpQaYqUf/2rY1HX1a0LX0Fn/vJ6vZ0y8v
 Z+mgig4OjYJJPrfb98p6QpPWtY7ubZ8n82IIzsP/pElXJP1G70petnUtlhDdGDHcO+
 xUYJ0dxxy4D8Corhyz3Wv3zXe146lEbaN/jUJauBcHAQocnw1vO3iS+0YwQ8udCEAo
 ufdsG/OA3zc3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/39] ASoC: amd: fix for pcm_read() error
Date: Thu,  3 Jun 2021 13:07:52 -0400
Message-Id: <20210603170829.3168708-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170829.3168708-1-sashal@kernel.org>
References: <20210603170829.3168708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 6879e8e759bf9e05eaee85e32ca1a936e6b46da1 ]

Below phython script throwing pcm_read() error.

import subprocess

p = subprocess.Popen(["aplay -t raw -D plughw:1,0 /dev/zero"], shell=True)
subprocess.call(["arecord -Dhw:1,0 --dump-hw-params"], shell=True)
subprocess.call(["arecord -Dhw:1,0 -fdat -d1 /dev/null"], shell=True)
p.kill()

Handling ACP global external interrupt enable register
causing this issue.
This register got updated wrongly when there is active
stream causing interrupts disabled for active stream.
Refactored code to handle enabling and disabling external interrupts.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/1619555017-29858-1-git-send-email-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 10 ----------
 sound/soc/amd/raven/acp3x.h         |  1 +
 sound/soc/amd/raven/pci-acp3x.c     | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 417cda24030c..2447a1e6e913 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -237,10 +237,6 @@ static int acp3x_dma_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	if (!adata->play_stream && !adata->capture_stream &&
-	    !adata->i2ssp_play_stream && !adata->i2ssp_capture_stream)
-		rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
-
 	i2s_data->acp3x_base = adata->acp3x_base;
 	runtime->private_data = i2s_data;
 	return ret;
@@ -367,12 +363,6 @@ static int acp3x_dma_close(struct snd_soc_component *component,
 		}
 	}
 
-	/* Disable ACP irq, when the current stream is being closed and
-	 * another stream is also not active.
-	 */
-	if (!adata->play_stream && !adata->capture_stream &&
-		!adata->i2ssp_play_stream && !adata->i2ssp_capture_stream)
-		rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
 
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 03fe93913e12..c3f0c8b7545d 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -77,6 +77,7 @@
 #define ACP_POWER_OFF_IN_PROGRESS	0x03
 
 #define ACP3x_ITER_IRER_SAMP_LEN_MASK	0x38
+#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
 struct acp3x_platform_info {
 	u16 play_i2s_instance;
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 77f2d9389606..df83d2ce75ea 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -76,6 +76,19 @@ static int acp3x_reset(void __iomem *acp3x_base)
 	return -ETIMEDOUT;
 }
 
+static void acp3x_enable_interrupts(void __iomem *acp_base)
+{
+	rv_writel(0x01, acp_base + mmACP_EXTERNAL_INTR_ENB);
+}
+
+static void acp3x_disable_interrupts(void __iomem *acp_base)
+{
+	rv_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
+		  mmACP_EXTERNAL_INTR_STAT);
+	rv_writel(0x00, acp_base + mmACP_EXTERNAL_INTR_CNTL);
+	rv_writel(0x00, acp_base + mmACP_EXTERNAL_INTR_ENB);
+}
+
 static int acp3x_init(struct acp3x_dev_data *adata)
 {
 	void __iomem *acp3x_base = adata->acp3x_base;
@@ -93,6 +106,7 @@ static int acp3x_init(struct acp3x_dev_data *adata)
 		pr_err("ACP3x reset failed\n");
 		return ret;
 	}
+	acp3x_enable_interrupts(acp3x_base);
 	return 0;
 }
 
@@ -100,6 +114,7 @@ static int acp3x_deinit(void __iomem *acp3x_base)
 {
 	int ret;
 
+	acp3x_disable_interrupts(acp3x_base);
 	/* Reset */
 	ret = acp3x_reset(acp3x_base);
 	if (ret) {
-- 
2.30.2

