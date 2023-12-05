Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C17C4167B
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Dec 2023 15:24:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55FF8E0E;
	Tue,  5 Dec 2023 16:24:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55FF8E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701789872;
	bh=qUR7whVMT8BtNApCvTXhRKIvkctm3oDxriQKiL8LCN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mKGnkZ9UuTSJsWXqf3kbwIZ0ZS5onC5n3UaC3WDK7fg+bgwJzXTcGlYhH0mFWU3oB
	 GMeSs55NNbmy0LEXBGeXtMsdI0s/j3P7Zs2mvWOSAtxvr4/vJJVvozqYuet5mHrgZp
	 ib5qQeF3V+IhSwMAFy4I0laVEDeZTOO47KX9S49E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A935F806CC; Tue,  5 Dec 2023 16:22:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AC0CF806D9;
	Tue,  5 Dec 2023 16:22:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A4DCF8069D; Tue,  5 Dec 2023 16:22:01 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 838E2F80557
	for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2023 16:21:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 838E2F80557
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=JgFJBwV1
Received: by mail.gandi.net (Postfix) with ESMTPA id 6A20840020;
	Tue,  5 Dec 2023 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701789697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYQ8uF4t7Lmz/lWaeGWOBtrIHcDDpL8Z+vCvsLZYQTE=;
	b=JgFJBwV1WhUv76prBiXRU4fccsoSAkMF4WXyNLDfbiouD8Byoc+EcTo9f/csAoennhT+eJ
	pTusPoi4c1fIVbpPn9VymU7upOrw4qtRxfpRE2y6P8slOMOWNEG7/k2lo4ldiNPia5zaYg
	SDlg2DNjfPp3wKx/FXFyMYiw27mUXKAjPt3TVde4JzMAaKXYQZX1oBh83GGK78MLbqgE5C
	DDG2zRvt9s3MWloaWsR1O3SmSRARb1fCGkgvDtEEagliZsreJbuWuDYgpLFAxb9hDN68Si
	GVXS+CFcjzPrNfPi4U20DkV2+xfwySqPmU01kSQ6ffP4u36FCTRfLPICVaIsyQ==
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
Subject: [PATCH v2 11/17] soc: fsl: cpm1: qmc: Check available timeslots in
 qmc_check_chans()
Date: Tue,  5 Dec 2023 16:21:08 +0100
Message-ID: <20231205152116.122512-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205152116.122512-1-herve.codina@bootlin.com>
References: <20231205152116.122512-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: X7KLN6G3SA5DPRYL65VBWQWX72PACU5I
X-Message-ID-Hash: X7KLN6G3SA5DPRYL65VBWQWX72PACU5I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X7KLN6G3SA5DPRYL65VBWQWX72PACU5I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The timeslots checked in qmc_check_chans() are the timeslots used.
With the introduction of the available timeslots, the used timeslots
are a subset of the available timeslots. The timeslots checked during
the qmc_check_chans() call should be the available ones.

Simply update and check the available timeslots instead of the used
timeslots in qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index f2a71a140db7..8d71e63d0f21 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -914,13 +914,13 @@ static int qmc_check_chans(struct qmc *qmc)
 	rx_ts_assigned_mask = info.nb_rx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_rx_ts) - 1;
 
 	list_for_each_entry(chan, &qmc->chan_head, list) {
-		if (chan->tx_ts_mask > tx_ts_assigned_mask) {
-			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
+		if (chan->tx_ts_mask_avail > tx_ts_assigned_mask) {
+			dev_err(qmc->dev, "chan %u can use TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
 
-		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
-			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
+		if (chan->rx_ts_mask_avail > rx_ts_assigned_mask) {
+			dev_err(qmc->dev, "chan %u can use TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
 	}
-- 
2.43.0

