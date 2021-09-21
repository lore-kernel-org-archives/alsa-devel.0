Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A164C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:42:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744AF60527
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 744AF60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B81416CB;
	Tue, 21 Sep 2021 23:41:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B81416CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632260543;
	bh=qn1jE6K/Qy0HIHv+QnV26gpbLQc45bxFYT32k8EnFdM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oss9dlCXR2DUNHZObuF2jymyQEBx01neXnsce94eDXuKcMuw0om5L0GF2uUNdnGvJ
	 JoLpgJM+4+he/t6ZZCmdDKmtKWlpW3Brn9zSyO1IfoU6hAlCBBoHdFIYxjong2d60w
	 OouDPmaTbYiryHI95WLoA4dWHTHuRf+5pCTRtiWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FEB7F80542;
	Tue, 21 Sep 2021 23:37:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C10FEF8053B; Tue, 21 Sep 2021 23:37:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 349D0F80539
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:37:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 349D0F80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GFoBcMaJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4597861159;
 Tue, 21 Sep 2021 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260241;
 bh=qn1jE6K/Qy0HIHv+QnV26gpbLQc45bxFYT32k8EnFdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GFoBcMaJeMnR4RNbV+v+iiWWf4h0TDLt0ooUh1FhIJmEbaQOsdP5EsxEV4eM/aZxw
 yqUDfkSadvlG4KsjalSjWTIT4YqBk6cnN2Nv+itWZ+VSM85DT04yBr+T+nY4Lbp5S3
 hYx47oVJaVVi2iVV6Tq3o8EmQAT5q8oOlIUDn0v0/mktSlvuNGEwidTCHxHzpSNLH3
 9Juy3R3gOz8j0/QNIPuRKmbap0cBw4qCleL4/I04lDXfHbrSFpfzYh3g93fCGugWtI
 jbNBHtVOyR0UjzUqRIRXE80xdUJsJ6mGiDAoXk5OuFCQBamgYaMqLnqrR2Yey8xMVQ
 KDttmi+WoR9GA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 14/16] ASoC: mpc8610_hpcd: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:35:40 +0100
Message-Id: <20210921213542.31688-14-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; h=from:subject;
 bh=qn1jE6K/Qy0HIHv+QnV26gpbLQc45bxFYT32k8EnFdM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8dlzD7rbJdjdY0C549PJSd4DI+vTeHN26l52LM
 pdWlWzaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPHQAKCRAk1otyXVSH0LzzB/
 48ci58sZaiW8Nw2BvExQ9M3kHonJUWdulKqX0baG2BNTf8+mYqdS/hI51ayGrKgygun1Rf5ngb8IZ2
 vIP3hlhJzyION0UaI/roOS5Dkg2eLjrxmggXeM77MsPZk+n6FIflPUXNdAL5OGm6tgFH49IyUEFlww
 ok7VoZw4E8RLmxaOdXHxjDSPyAPhFhb1pywp0Hdp5pcibO0DBLBwU4pnu7iCKJKMqTmn7s9l7GbaBk
 qdD+OCJ8gwixuxeRyZFDzEcgRe6KDy0b+bLlADoNDVw/3okfJKIIKdmNnmh3WI/WCIR82LsTXno5+3
 RyLz5kRbluuBdFkN5Hb1n/5kRVGTLZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

As part of moving to remove the old style defines for the bus clocks update
the mpc8610_hpcd driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc8610_hpcd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 58b9ca3c4da0..e71a992fbf93 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -264,7 +264,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 	if (strcasecmp(sprop, "i2s-slave") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
@@ -282,37 +282,37 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		machine_data->clk_frequency = be32_to_cpup(iprop);
 	} else if (strcasecmp(sprop, "i2s-master") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "lj-slave") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBP_CFP;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "lj-master") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBC_CFC;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "rj-slave") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBP_CFP;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "rj-master") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBC_CFC;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBP_CFP;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "ac97-master") == 0) {
 		machine_data->dai_format =
-			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBC_CFC;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else {
-- 
2.20.1

