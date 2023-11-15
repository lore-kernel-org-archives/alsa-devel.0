Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00348C55825
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Nov 2023 14:44:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE9EBA4E;
	Wed, 15 Nov 2023 15:43:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE9EBA4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700059455;
	bh=X5NtCvZ/W7jqFY3uZjNb0MR6eiky7nzVZoIzDZtAgNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SDqBuJ55nIyw7YSn/3wJmXAmtn8qzDoO3KR85QvwiA0SwtOnG0WO/Tssjkm6MrcVM
	 0PC5TXIRBSTZWjyk5hBa9qJNqw7ui+VpOad3oyo2i/Kr652XHJaNO0K30CUfFrygVO
	 Qw5dORK6+nEn11NMn94W7uPo5erqa+aoPE71X47M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FA45F80605; Wed, 15 Nov 2023 15:41:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C22F9F805B0;
	Wed, 15 Nov 2023 15:41:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EC31F80568; Wed, 15 Nov 2023 15:40:57 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D554F80567
	for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2023 15:40:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D554F80567
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=FjVYWW77
Received: by mail.gandi.net (Postfix) with ESMTPA id D18DCFF803;
	Wed, 15 Nov 2023 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700059235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3qOJv0880JICdalI8Clio4OU3q9Vor1WvllgMz11pQ=;
	b=FjVYWW77zxWT3RPfWO0q5MqX/HipTbaOOMudJonQCk4ENdJkVVMHckED7vX5DxkjbcxB8B
	ROVu0AKMwCaKpOPDuOZsiWkrkBeVIao2T5EFAX6Vlt/01RIFFPKFadYn84KaUGPkrh8F4C
	QLagBeJw+RUjMhCgEnmWc1GtBsJ2raODXXqvPqAlPC5dGV0qDtHx374ZSHBhvvN2Ebr1GV
	L3cVR4ZVfEFjMvSS7P/88iFwh/f6IRY0OeOhZsJmVhG9V49919G98/M8c1kbiRbcsil43O
	WsaHZ/ZhQwv3iSwh8zPd3g38zurxtnqYrkS2PTUic3nWr9xqTirctyM0/7HW6w==
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
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Simon Horman <horms@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v9 12/27] soc: fsl: cpm1: qmc: Remove no more needed checks
 from qmc_check_chans()
Date: Wed, 15 Nov 2023 15:39:48 +0100
Message-ID: <20231115144007.478111-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115144007.478111-1-herve.codina@bootlin.com>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: ZCVGRNPEP37GBYLUATH5DI4B44HJYTAS
X-Message-ID-Hash: ZCVGRNPEP37GBYLUATH5DI4B44HJYTAS
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The newly introduced qmc_chan_setup_tsa* functions check that the
channel entries are not already used.
These checks are also performed by qmc_check_chans() and are no more
needed.

Remove them from qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 5d7e2ecdd933..f2a71a140db7 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -884,10 +884,7 @@ EXPORT_SYMBOL(qmc_chan_reset);
 static int qmc_check_chans(struct qmc *qmc)
 {
 	struct tsa_serial_info info;
-	bool is_one_table = false;
 	struct qmc_chan *chan;
-	u64 tx_ts_mask = 0;
-	u64 rx_ts_mask = 0;
 	u64 tx_ts_assigned_mask;
 	u64 rx_ts_assigned_mask;
 	int ret;
@@ -911,7 +908,6 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
 			return -EINVAL;
 		}
-		is_one_table = true;
 	}
 
 	tx_ts_assigned_mask = info.nb_tx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_tx_ts) - 1;
@@ -922,27 +918,11 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (tx_ts_mask & chan->tx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Tx TS\n", chan->id);
-			return -EINVAL;
-		}
 
 		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (rx_ts_mask & chan->rx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Rx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		if (is_one_table && (chan->tx_ts_mask != chan->rx_ts_mask)) {
-			dev_err(qmc->dev, "chan %u uses different Rx and Tx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		tx_ts_mask |= chan->tx_ts_mask;
-		rx_ts_mask |= chan->rx_ts_mask;
 	}
 
 	return 0;
-- 
2.41.0

