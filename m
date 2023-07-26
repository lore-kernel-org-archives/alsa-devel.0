Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B578C001DC
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Jul 2023 15:07:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0129200;
	Wed, 26 Jul 2023 17:06:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0129200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690384063;
	bh=6N3jwG415ggfQElXyBvS6iBJ0/G+J6Q3zeOM+liYxyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=l126bz/Q7GhSd2lzBOokNmd/wc7gTlQjd64ogYp98yceIRvx3XyWMCd6xRfRTQkbL
	 KE2Y4OeIorTGpVNM6qzjDijEweAP04suiH7cn4F4mmi+cWtxqOyEQdr/95ozgy8wiD
	 YYukf0S7Bz/cTKZOHIN/biQZg+Maz+71yhlMHe3s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F35CEF8060B; Wed, 26 Jul 2023 17:03:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7635F80604;
	Wed, 26 Jul 2023 17:03:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 155D1F805EB; Wed, 26 Jul 2023 17:03:36 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 931EDF805E0
	for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2023 17:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 931EDF805E0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=HOTKwtep
Received: by mail.gandi.net (Postfix) with ESMTPA id 900581C000D;
	Wed, 26 Jul 2023 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690383813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBt50e+s29lg78AAaNK/5LXVHKyVi9N5D9KoMPA4Iqc=;
	b=HOTKwtepgjDI5abcuVg8KB0ultpgrNFyvNU1rzpy3RseAZ4blkgsclcjHDE76K7hBIBsiw
	91pbBo6Kmz4T0KJa7p202DD2zQixJ/Ub5Ej4ICPBfxzWu5dez1003gzIbaGZ7AZpNMCQ1u
	d7izLYuIGGipF8gmjCx7p55iHn8iOKeR8dOSxkFAXyqEr4TQgrOXEkSlsJUlAgAfcSV8D+
	0J8pRflISZqzr+bZ1TD8IqAGQ987w4yzmd89mOkq2g0ApibmhA+EQqtMQF5YBnxhBdT/U/
	4xRwSiV+RFSK4AfCNGEARAkf56mmSjdSgE91nNXu1j1hvdZox1l/RDP3DvqmnQ==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 15/28] soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
Date: Wed, 26 Jul 2023 17:02:11 +0200
Message-ID: <20230726150225.483464-16-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726150225.483464-1-herve.codina@bootlin.com>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: MNVT6Z4TWUJPTXWM5F5HL6NEHGF7TC5T
X-Message-ID-Hash: MNVT6Z4TWUJPTXWM5F5HL6NEHGF7TC5T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MNVT6Z4TWUJPTXWM5F5HL6NEHGF7TC5T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In order to support runtime timeslot route changes, some operations will
be different according the routing table used (common Rx and Tx table or
one table for Rx and one for Tx).

The is_tsa_64rxtx flag is introduced to avoid extra computation to
determine the table format each time we need it.
It is set once at initialization.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index c8ddd2a54bee..dc113463fbc7 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -216,6 +216,7 @@ struct qmc {
 	u16 __iomem *int_curr;
 	dma_addr_t int_dma_addr;
 	size_t int_size;
+	bool is_tsa_64rxtx;
 	struct list_head chan_head;
 	struct qmc_chan *chans[64];
 };
@@ -696,7 +697,7 @@ static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
 	 * Setup one common 64 entries table or two 32 entries (one for Tx
 	 * and one for Tx) according to assigned TS numbers.
 	 */
-	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32)
+	if (chan->qmc->is_tsa_64rxtx)
 		return qmc_chan_setup_tsa_64rxtx(chan, &info, enable);
 
 	ret = qmc_chan_setup_tsa_32rx(chan, &info, enable);
@@ -1053,6 +1054,7 @@ static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *in
 	 * Everything was previously checked, Tx and Rx related stuffs are
 	 * identical -> Used Rx related stuff to build the table
 	 */
+	qmc->is_tsa_64rxtx = true;
 
 	/* Invalidate all entries */
 	for (i = 0; i < 64; i++)
@@ -1081,6 +1083,7 @@ static int qmc_init_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info
 	 * Use a Tx 32 entries table and a Rx 32 entries table.
 	 * Everything was previously checked.
 	 */
+	qmc->is_tsa_64rxtx = false;
 
 	/* Invalidate all entries */
 	for (i = 0; i < 32; i++) {
-- 
2.41.0

