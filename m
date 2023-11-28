Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75988C4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Nov 2023 14:12:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDB1E950;
	Tue, 28 Nov 2023 15:12:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDB1E950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701180753;
	bh=pSPhDnc6cCj4wjKwWuFGWPGM5zz3f0E/yd3vkFI+vxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i8tzJ2ep/Dwxb4+CNq3n0xs2iTDb2Q0FprIU8Go4RPdDBvthWSUjYNxl879OlhSGF
	 Mw1Q19w5HMIWiXzEgPmi7uGrciDEDC+rnCySnhMu3QU3yqrjYGwdPn89R70Gc8/j3M
	 DhtOGFDtXwsc/OwpTIaGWGAaGZ0RXC/3nwjGnww8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A0E9F80803; Tue, 28 Nov 2023 15:09:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19380F80814;
	Tue, 28 Nov 2023 15:09:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C531F806AC; Tue, 28 Nov 2023 15:08:54 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26CB9F805E4
	for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2023 15:08:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26CB9F805E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=Desx5TSs
Received: by mail.gandi.net (Postfix) with ESMTPA id E531060005;
	Tue, 28 Nov 2023 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701180516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHk9CdyIDprG+6Gwz4WRxtkc6hwo9HZn9NzP3/YrC7w=;
	b=Desx5TSsmTS0/uzGXiO4Lq4aFbdVWG8lmbAaJFFFRhvlRy1o2l+lhBElBTKkjBGOfMnqIE
	uSpc3zCiWMxyWDER3hRO2XYyHLp5pnytJH1HIJz04GYla3n0CmIZ501+Y/ASQ2UJleAkkJ
	r58O62KxHlo4gFC3JOSNEuaZzMj/udWounvjEO0T9UV8LTgaMBYLX6NBsT9JMlKCRHLUIy
	c3wygvYCjTeLlHou2sJ+0gyDWPksKZy4XMAC4q+OmDfLsLCPG941Wrc4Xxj1XTQZ6IH7zB
	CzJLNqj+or7iNXvEY8anY6SbtslaasEn6tlUPbvCbNqJRNi5xtsp/BK8aDHLoQ==
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
Subject: [PATCH 14/17] soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
Date: Tue, 28 Nov 2023 15:08:13 +0100
Message-ID: <20231128140818.261541-15-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128140818.261541-1-herve.codina@bootlin.com>
References: <20231128140818.261541-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: QTABSZTCKG7QEJ4KHCAKM2NJUJTGCKWE
X-Message-ID-Hash: QTABSZTCKG7QEJ4KHCAKM2NJUJTGCKWE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QTABSZTCKG7QEJ4KHCAKM2NJUJTGCKWE/>
List-Archive: <>
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
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 5ca4120779f8..e651b3bba1ca 100644
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
2.42.0

