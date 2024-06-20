Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681DEC2BA18
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jun 2024 08:51:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8617AE72;
	Thu, 20 Jun 2024 10:50:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8617AE72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718873459;
	bh=/gkMygh09ZpiD7BTBSHMvPXyxlus217LmQzwwIIdnOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bG9XAoUoRPXsFHd+T+/wKE1T6DoDcccI6KUCy01oLf+Ek3QjSiA+K5PeCxJw0qIfI
	 P0gyyc7nUOqAAzfCUYC6g8+lMFRCepWfwkyynk2l/k8MkNr/w//6cGV/ELoFoSrgRu
	 DSJyFuCmkp2JErSkU0yamohEXofpvQKE2nywna04=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 902D4F80601; Thu, 20 Jun 2024 10:50:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D750DF805F7;
	Thu, 20 Jun 2024 10:50:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFCADF80266; Thu, 20 Jun 2024 10:43:40 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A79ACF804F2
	for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2024 10:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A79ACF804F2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=BYraRfk7
Received: by mail.gandi.net (Postfix) with ESMTPA id 5E33D20012;
	Thu, 20 Jun 2024 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDLRcTY0BkTaFAdlLFjztJqIMTmDai9TLYinXM16row=;
	b=BYraRfk7fEz5L1838NbMQUtgasaGC3yafWba1AA59mzifxKYEytwkNwf8SyIWpTY3kgf6B
	XVylMtJ5iP8zPd51l9KZueVKs9oinG3sl6rbBmqPv7N/6EmTdGrluo/VNLTg6qjw1NVJ5K
	FxI9ONYG7CI54wUSXtP8pOp/P6Q7OuDTS/4XCYA8fJ3iZ5xX/HN37b9QFIO0OqRZskePlB
	L91Bt6v+i5rN5HUE8T5+kkQFZ0M0AKz8O/Spdg6uN9XAhBPsCZbP6cwciBfrvrhyDFvpEf
	ggReD1B+0vtfuCPOfKDWeEOU4Tr4aTq27ArjK8IYP4XQs5WublUbr+biTu74ig==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 08/10] soc: fsl: cpm1: qmc: Introduce
 qmc_chan_count_phandles()
Date: Thu, 20 Jun 2024 10:42:55 +0200
Message-ID: <20240620084300.397853-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: I26R3EO5LCWO4O3PBJYB5HZDZWEAOZEF
X-Message-ID-Hash: I26R3EO5LCWO4O3PBJYB5HZDZWEAOZEF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I26R3EO5LCWO4O3PBJYB5HZDZWEAOZEF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

No function in the QMC API is available to get the number of phandles
present in a phandle list.

Fill this lack introducing qmc_chan_count_phandles().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 13 +++++++++++++
 include/soc/fsl/qe/qmc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index e23d60018400..76bb496305a0 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1777,6 +1777,19 @@ static struct qmc_chan *qmc_chan_get_from_qmc(struct device_node *qmc_np, unsign
 	return qmc_chan;
 }
 
+int qmc_chan_count_phandles(struct device_node *np, const char *phandles_name)
+{
+	int count;
+
+	/* phandles are fixed args phandles with one arg */
+	count = of_count_phandle_with_args(np, phandles_name, NULL);
+	if (count < 0)
+		return count;
+
+	return count / 2;
+}
+EXPORT_SYMBOL(qmc_chan_count_phandles);
+
 struct qmc_chan *qmc_chan_get_byphandles_index(struct device_node *np,
 					       const char *phandles_name,
 					       int index)
diff --git a/include/soc/fsl/qe/qmc.h b/include/soc/fsl/qe/qmc.h
index 0fa7205145ce..294e42ea8d4c 100644
--- a/include/soc/fsl/qe/qmc.h
+++ b/include/soc/fsl/qe/qmc.h
@@ -16,6 +16,8 @@ struct device_node;
 struct device;
 struct qmc_chan;
 
+int qmc_chan_count_phandles(struct device_node *np, const char *phandles_name);
+
 struct qmc_chan *qmc_chan_get_byphandles_index(struct device_node *np,
 					       const char *phandles_name,
 					       int index);
-- 
2.45.0

