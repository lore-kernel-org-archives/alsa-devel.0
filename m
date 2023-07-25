Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC447C001E0
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 09:29:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23F0D1517;
	Tue, 25 Jul 2023 11:28:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23F0D1517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690277342;
	bh=L7/+evG96V9D8qDlSFW578qu8u1Y4Cy7cuAfAUSiONk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qJnSTuFR/ZJgYNRgPEYmiz/xCDMeAUT/PJebgtpUxtkB1Kx/DugDImA9L/RxxDk0d
	 VdVm7zzqovsQ7y2MReVaPgpv0tnNFitBFZoUS2x93lKdgCHXhKtVbQJ5bI0DozgQnV
	 F7iBaaGyyhl8PtvgOj5cfW5Aq4vKLtil1X3p9a/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E369FF805F9; Tue, 25 Jul 2023 11:25:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71C20F805F5;
	Tue, 25 Jul 2023 11:25:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53E18F805E1; Tue, 25 Jul 2023 11:25:31 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 263A1F805DA
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 11:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 263A1F805DA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=jy9V3+gs
Received: by mail.gandi.net (Postfix) with ESMTPA id BFADA40002;
	Tue, 25 Jul 2023 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690277128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPsXXtMWY75ybXe0b5dmZT1/eNTZycbZPNt7Yn/q9Y=;
	b=jy9V3+gsIpT0GyIyt7ymEGOXt7n4DcDhe2I8crJBBlha1Crl4H7SBwRF2XD4gZr+fvC5Mu
	MZxM2f7CfNEPecPwZIbTMaAZb/sK3sdncyyCLjN04/kkMBzmqYRWLpcqwL+EHl0NRWD7Td
	JhJVXbceA5VKrQqDpCNq3WsD/VEFnXbnSokZO3FCbAAdYiMrxIwbzGCz7inivCbq5TAzbe
	nPOLHA6wjfwseA58YN79FvU7E07TTKU2aNoztjMfPhE8ywPbLg6s+5O9B2Nfp61p5e+W0Y
	ZL485rWtk05GEiTZuMsl2gxd47vD+aQ/MwAq994c0V8OZly7WVtOOeDafm7YOQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 12/26] soc: fsl: cpm1: qmc: Split Tx and Rx TSA entries setup
Date: Tue, 25 Jul 2023 11:23:48 +0200
Message-ID: <20230725092417.43706-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725092417.43706-1-herve.codina@bootlin.com>
References: <20230725092417.43706-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: ZRIOM6SNN4GUPFCDUH6I7ZG7GZW5WCN4
X-Message-ID-Hash: ZRIOM6SNN4GUPFCDUH6I7ZG7GZW5WCN4
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZRIOM6SNN4GUPFCDUH6I7ZG7GZW5WCN4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Tx and Rx entries for a given channel are set in one function.

In order to modify Rx entries and Tx entries independently of one other,
split this function in one for the Rx part and one for the Tx part.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 49 ++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index e19782808f5b..d02acbc1d7e1 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -610,14 +610,14 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
 	return 0;
 }
 
-static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info,
-					bool enable)
+static int qmc_chan_setup_tsa_32rx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+				   bool enable)
 {
 	unsigned int i;
 	u16 curr;
 	u16 val;
 
-	/* Use a Tx 32 entries table and a Rx 32 entries table */
+	/* Use a Rx 32 entries table */
 
 	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
 
@@ -633,6 +633,30 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 			return -EBUSY;
 		}
 	}
+
+	/* Set entries based on Rx stuff */
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
+				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
+	}
+
+	return 0;
+}
+
+static int qmc_chan_setup_tsa_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+				   bool enable)
+{
+	unsigned int i;
+	u16 curr;
+	u16 val;
+
+	/* Use a Tx 32 entries table */
+
+	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+
 	/* Check entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
 		if (!(chan->tx_ts_mask & (((u64)1) << i)))
@@ -646,14 +670,6 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 		}
 	}
 
-	/* Set entries based on Rx stuff */
-	for (i = 0; i < info->nb_rx_ts; i++) {
-		if (!(chan->rx_ts_mask & (((u64)1) << i)))
-			continue;
-
-		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
-				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
-	}
 	/* Set entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
 		if (!(chan->tx_ts_mask & (((u64)1) << i)))
@@ -680,9 +696,14 @@ static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
 	 * Setup one common 64 entries table or two 32 entries (one for Tx
 	 * and one for Tx) according to assigned TS numbers.
 	 */
-	return ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) ?
-		qmc_chan_setup_tsa_64rxtx(chan, &info, enable) :
-		qmc_chan_setup_tsa_32rx_32tx(chan, &info, enable);
+	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32)
+		return qmc_chan_setup_tsa_64rxtx(chan, &info, enable);
+
+	ret = qmc_chan_setup_tsa_32rx(chan, &info, enable);
+	if (ret)
+		return ret;
+
+	return qmc_chan_setup_tsa_32tx(chan, &info, enable);
 }
 
 static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
-- 
2.41.0

