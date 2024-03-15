Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CC4C54E60
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Mar 2024 09:02:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8671F23CF;
	Sun, 17 Mar 2024 10:02:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8671F23CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710666170;
	bh=tiG1anIwJmGks5IJ0snXqu0mldVVMpJ+/7sMXbGSGZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OqOD3SRFSdAUxuznJbe82oiLSnRg7PEmSSKWmJS5zpLfUERFFEHVM2MVdvixAMBsP
	 QwCpwVO5NIsHH44g7yQlzQ2MGCTTgzDV60O50WKvZ9UqfAwIgbK+ByptnzO1yJkDfo
	 n4XG/K+mhWQt2AKQ1WppjKY1fJWPlW3B73GTJFu4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E14C9F805C8; Sun, 17 Mar 2024 10:02:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D2B5F805D3;
	Sun, 17 Mar 2024 10:02:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83825F8025F; Fri, 15 Mar 2024 12:28:31 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C99DEF80578
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2024 12:28:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C99DEF80578
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=ors2H1q9
Received: by mail.gandi.net (Postfix) with ESMTPA id BB0DAE0006;
	Fri, 15 Mar 2024 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UC3LFE9iQk44oAEepOsnaMuAe4UaFfXnY3Wv95ahIcU=;
	b=ors2H1q93yIavTqvTxO2+ezzZGIR3PHeFDto3uGs3gMYAxkCg3D73uUBl+Pha3DYfmnNZi
	9mDGgDc8F4hNbaRQDa9ZUKJHduQMCJOuvGjKYn+yhFJXpHQBTybeRFA05ZsZhCSefT4GEr
	/8ho2AMjLy1mreLRDzNIaCa26GTR1wey3/P1HorIfj0ens1kcDdZxCu8JcEBtuAubd6K/e
	0md0/5Oku8eOPmLbn63Zjde9cmK9jiITb3FcTAkNjB1jPQPiLMAz3C7xn5Cy0LymMZNXGI
	QBnUl7njGZDW9zmTIdBJEF9Jd1aCS7fQuxYmNFA6sHwSmvYaNudaB/We+JytbQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 10/13] ASoC: ti: davinci-i2s: Make free-running mode optional
Date: Fri, 15 Mar 2024 12:27:42 +0100
Message-ID: <20240315112745.63230-11-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-MailFrom: bastien.curutchet@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JKW6G4C46SQCDZB5C4IJ52O3VR3PWYXJ
X-Message-ID-Hash: JKW6G4C46SQCDZB5C4IJ52O3VR3PWYXJ
X-Mailman-Approved-At: Sun, 17 Mar 2024 08:56:02 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JKW6G4C46SQCDZB5C4IJ52O3VR3PWYXJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

McBSP has free-running mode where serial clocks continue to run during
emulation halts. This mode is always enabled by the driver.

Disable this free-running mode according to the 'ti,disable-free-run'
device-tree property.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 2c19e45b6b54..67307e75f2a8 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -165,6 +165,7 @@ struct davinci_mcbsp_dev {
 	int slot_width;
 
 	bool sync_err;
+	bool free_run;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -444,11 +445,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (dev->free_run)
+		spcr |= DAVINCI_MCBSP_SPCR_FREE;
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	} else {
-		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
@@ -766,6 +769,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->base = io_base;
 
+	dev->free_run = !of_property_read_bool(pdev->dev.of_node, "ti,disable-free-run");
 	dev->sync_err = of_property_read_bool(pdev->dev.of_node, "ti,enable-sync-err");
 
 	/* setup DMA, first TX, then RX */
-- 
2.43.2

