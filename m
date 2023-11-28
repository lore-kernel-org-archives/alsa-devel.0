Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FC6C4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Nov 2023 14:11:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E42A5DF9;
	Tue, 28 Nov 2023 15:11:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E42A5DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701180687;
	bh=qo4L66V2VgcyTCCqCT4mI73Kse8jgVY3CCCceoeZARA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P7CFsFYQWlEei8jLGB8o0FS3YWb6OOZ5PqI8/7OCJvXHGtNsg/o/SqRXDAbI06m5g
	 nHfqv6EYKosD6EWCbsJart/b29yJqETRBJLD4hJ4IAfCHi6MJlCUQWOJCpN624fTXM
	 BSe8WQuguOxpkSPpf2Nitl7Vc+0m5UrGT/cxA4qY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 440DFF80710; Tue, 28 Nov 2023 15:08:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EC3DF80714;
	Tue, 28 Nov 2023 15:08:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E421CF80610; Tue, 28 Nov 2023 15:08:48 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1E087F805AB
	for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2023 15:08:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E087F805AB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=F3uMowcK
Received: by mail.gandi.net (Postfix) with ESMTPA id F01FC60008;
	Tue, 28 Nov 2023 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701180514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWHgBlygVL1LuwsPq3d724YHN4EBk4wsLUMnSb1bhgA=;
	b=F3uMowcK+/y8P7goYwCcRSJE2Sc3uNGVzLqcbAcWjXgDLr86uJ7HFkGvKkZItiIp+jqwwY
	GM6NOmmokiNm5Y+6LVfKwz8uBhFAqw4IpZaHWS5t7iAdlVJZRtKkffmm6AuSGfbaxgMR63
	XaurN86rbLaP+DCfrXHrsalgYyWukCmmxDM8wVvpySWNtuTp6XsXgfLyYdy3Ntu7vej2wz
	SEX67rSuwYaul/MJK92eadRsEj5jimSKkytOXkpZva9bwMkn3oEpCmN6YH/nG7DdxPz8Ho
	L7q18qwcqY2cFjPSbGe4/YO9lpKMKt7vw1got0aBi1fg0JubocyuMR3rGJPolw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 12/17] soc: fsl: cpm1: qmc: Add support for disabling channel
 TSA entries
Date: Tue, 28 Nov 2023 15:08:11 +0100
Message-ID: <20231128140818.261541-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128140818.261541-1-herve.codina@bootlin.com>
References: <20231128140818.261541-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: O3HDKLSJQNR7X2PIPI2MC46GPFQ7PG2U
X-Message-ID-Hash: O3HDKLSJQNR7X2PIPI2MC46GPFQ7PG2U
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O3HDKLSJQNR7X2PIPI2MC46GPFQ7PG2U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In order to allow runtime timeslot route changes, disabling channel TSA
entries needs to be supported.

Add support for this new feature.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 8d71e63d0f21..c1318fad296b 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -567,7 +567,8 @@ static void qmc_chan_read_done(struct qmc_chan *chan)
 	spin_unlock_irqrestore(&chan->rx_lock, flags);
 }
 
-static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_serial_info *info)
+static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+				     bool enable)
 {
 	unsigned int i;
 	u16 curr;
@@ -603,13 +604,14 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
 			continue;
 
 		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
-				 ~QMC_TSA_WRAP, val);
+				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
 	}
 
 	return 0;
 }
 
-static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info)
+static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+					bool enable)
 {
 	unsigned int i;
 	u16 curr;
@@ -650,7 +652,7 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 			continue;
 
 		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
-				 ~QMC_TSA_WRAP, val);
+				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
 	}
 	/* Set entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
@@ -658,13 +660,13 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 			continue;
 
 		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATTX + (i * 2),
-				 ~QMC_TSA_WRAP, val);
+				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
 	}
 
 	return 0;
 }
 
-static int qmc_chan_setup_tsa(struct qmc_chan *chan)
+static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
 {
 	struct tsa_serial_info info;
 	int ret;
@@ -679,8 +681,8 @@ static int qmc_chan_setup_tsa(struct qmc_chan *chan)
 	 * and one for Tx) according to assigned TS numbers.
 	 */
 	return ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) ?
-		qmc_chan_setup_tsa_64rxtx(chan, &info) :
-		qmc_chan_setup_tsa_32rx_32tx(chan, &info);
+		qmc_chan_setup_tsa_64rxtx(chan, &info, enable) :
+		qmc_chan_setup_tsa_32rx_32tx(chan, &info, enable);
 }
 
 static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
@@ -1146,7 +1148,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 
 	chan->qmc = qmc;
 
-	ret = qmc_chan_setup_tsa(chan);
+	ret = qmc_chan_setup_tsa(chan, true);
 	if (ret)
 		return ret;
 
-- 
2.42.0

