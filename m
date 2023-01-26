Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A2C54E94
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 15:25:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62A02A4C;
	Thu, 26 Jan 2023 16:24:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62A02A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674746715;
	bh=bF7nec78rpML/twTF5G820YDlfuFSX4IR2BuisZbFr4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=pQ2nzyn8X8U9eujHpnpyEZDMQGkpSyR6axIjSs6xnlTQCIuSrWuQb0z31iUsiY/6V
	 HDrATSEtMGH66PQXR31bCMkRSZu94ji4DWSB53XQEmemg1UcnckAO4M2H0SfSqQFZa
	 xvlD2sNbZ/EbMvTjvYyrxZhUTm/y5DonmjFmsDVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09940F8027D;
	Thu, 26 Jan 2023 16:24:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC36BF8027D; Thu, 26 Jan 2023 16:24:23 +0100 (CET)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::230])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC235F8016E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 16:24:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC235F8016E
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=T4/5HVZH
Received: from booty.fritz.box (unknown [77.244.183.192])
 (Authenticated sender: luca.ceresoli@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id F296E24000C;
 Thu, 26 Jan 2023 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1674746660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rxsciDeqntpVUYn5FLc+E1Uob0ovb8UfCOdsWZY5uwU=;
 b=T4/5HVZHxuMKo5KmRiXxx+syO4WcZeO6SScPR0KZgsHpfL+MczFljwh8BDAa0pmVyshuHe
 IJ1bxcFRQoNIYs+TwFHmKtVae8oqPmNS2noDNR95QdHobXLbdYqyJ6jZDzI8T/3a41JeNz
 k3gW/nYR1B5QmTiEx34iIP865Qb18W47bpNTKL7l2WHCbIWp0wByjjFtg0td73d9x1KGzF
 pTawqkzou34elhGXElMrgpLo76xcxjZ6sxvfb9lCvPRUa09EJG5eKh5ajq9oQrqj5IB/Ik
 ZpDuUhVqRc5VOxnWJhbtOIkrYFz6p4IkOGx922R+dpD2GRVLFxwu/b/4nNAsUg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: fsl-asoc-card: constify fsl_asoc_card_dai
Date: Thu, 26 Jan 2023 16:24:12 +0100
Message-Id: <20230126152412.959574-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This is never modified and can be made const.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2f25358196ee..00118a75d126 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -297,7 +297,7 @@ SND_SOC_DAILINK_DEFS(hifi_be,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
 
-static struct snd_soc_dai_link fsl_asoc_card_dai[] = {
+static const struct snd_soc_dai_link fsl_asoc_card_dai[] = {
 	/* Default ASoC DAI Link*/
 	{
 		.name = "HiFi",
-- 
2.34.1

