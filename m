Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A876FCE7B07
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Sep 2023 07:16:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07610E86;
	Thu, 28 Sep 2023 09:15:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07610E86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695885386;
	bh=LUC2UnGDv02vA/IbnlPZYR0/g5OdexsIqUewlUNdnsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=itZuMyShfzy27njfflC8Lq1DeGv3lXFOk/c76Dmg9prxzXXDcs9XJUqV4nyWOfS0D
	 t0odMu4fPQTO/dvz0s5v7aDjvivlWy2PoCPdLPmSQWT13Kq2EiY10k4hMZdcqvSYSZ
	 cWFwx0c2TLJiNr7ITw6H8caH5OIMib6VrArRBFtg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECB2DF805B4; Thu, 28 Sep 2023 09:10:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B055F8068F;
	Thu, 28 Sep 2023 09:10:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D1E5F80671; Thu, 28 Sep 2023 09:10:08 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75F17F8057B
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 09:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75F17F8057B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=Vm6ezLFk
Received: by mail.gandi.net (Postfix) with ESMTPA id A5D2B2000C;
	Thu, 28 Sep 2023 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695884908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac4atphcQFxCnsMf7+TyvECndYt2jyLCvyys/qHOQBU=;
	b=Vm6ezLFkvHBfj3go8ETE1Z90kGelXt7HZcnLEXBY0HPOP/do2cnxWjG6fVeOEezfMnMzBE
	QDX+sHIVTHIFF+I+Vb9RCOhvoW8AedCb9JfCbVAwlo/X2dPScmMfJbJ7aiAXFng6kFGayF
	E64AthPGz1qR+6LSPzzAt01N944xWzMj3+kehTnmjKjz+DFMFNk8SNZFG9bUNCUlxK5Na0
	SQDehgwi2sEfVMnCi/9oNLaKfbJuyzwI9KkWnF8RaFwmy9dPKeS5gF4zjT/0Q6vWttLllr
	dClMeU1FSYoqD79SkOVHYbz64xoxnQcUzrcOsOiwIeYzHWIsiaKFAJDTXtEMug==
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
Subject: [PATCH v7 23/30] wan: qmc_hdlc: Add runtime timeslots changes support
Date: Thu, 28 Sep 2023 09:06:41 +0200
Message-ID: <20230928070652.330429-24-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928070652.330429-1-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: SWFW34GZRNJJSEDPGBAU5I7WU46CITII
X-Message-ID-Hash: SWFW34GZRNJJSEDPGBAU5I7WU46CITII
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWFW34GZRNJJSEDPGBAU5I7WU46CITII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

QMC channels support runtime timeslots changes but nothing is done at
the QMC HDLC driver to handle these changes.

Use existing IFACE ioctl in order to configure the timeslots to use.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 169 ++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 15e102547ff2..24f466fa48b1 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -32,6 +32,7 @@ struct qmc_hdlc {
 	struct qmc_hdlc_desc tx_descs[8];
 	unsigned int tx_out;
 	struct qmc_hdlc_desc rx_descs[4];
+	u32 slot_map;
 };
 
 static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
@@ -202,6 +203,162 @@ static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
 	return NETDEV_TX_OK;
 }
 
+static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
+				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
+{
+	u64 ts_mask_avail;
+	unsigned int bit;
+	unsigned int i;
+	u64 ts_mask;
+	u64 map;
+
+	/* Tx and Rx masks must be identical */
+	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
+		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
+		return -EINVAL;
+	}
+
+	ts_mask_avail = ts_info->rx_ts_mask_avail;
+	ts_mask = 0;
+	map = slot_map;
+	bit = 0;
+	for (i = 0; i < 64; i++) {
+		if (ts_mask_avail & BIT_ULL(i)) {
+			if (map & BIT_ULL(bit))
+				ts_mask |= BIT_ULL(i);
+			bit++;
+		}
+	}
+
+	if (hweight64(ts_mask) != hweight64(map)) {
+		dev_err(qmc_hdlc->dev, "Cannot translate timeslots 0x%llx -> (0x%llx,0x%llx)\n",
+			map, ts_mask_avail, ts_mask);
+		return -EINVAL;
+	}
+
+	ts_info->tx_ts_mask = ts_mask;
+	ts_info->rx_ts_mask = ts_mask;
+	return 0;
+}
+
+static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
+				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
+{
+	u64 ts_mask_avail;
+	unsigned int bit;
+	unsigned int i;
+	u64 ts_mask;
+	u64 map;
+
+	/* Tx and Rx masks must be identical */
+	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
+		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
+		return -EINVAL;
+	}
+	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
+		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
+		return -EINVAL;
+	}
+
+	ts_mask_avail = ts_info->rx_ts_mask_avail;
+	ts_mask = ts_info->rx_ts_mask;
+	map = 0;
+	bit = 0;
+	for (i = 0; i < 64; i++) {
+		if (ts_mask_avail & BIT_ULL(i)) {
+			if (ts_mask & BIT_ULL(i))
+				map |= BIT_ULL(bit);
+			bit++;
+		}
+	}
+
+	if (hweight64(ts_mask) != hweight64(map)) {
+		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (0x%llx,0x%llx) -> 0x%llx\n",
+			ts_mask_avail, ts_mask, map);
+		return -EINVAL;
+	}
+
+	if (map >= BIT_ULL(32)) {
+		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (0x%llx,0x%llx) -> 0x%llx\n",
+			ts_mask_avail, ts_mask, map);
+		return -EINVAL;
+	}
+
+	*slot_map = map;
+	return 0;
+}
+
+static int qmc_hdlc_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface, const te1_settings *te1)
+{
+	struct qmc_chan_ts_info ts_info;
+	int ret;
+
+	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+	ret = qmc_hdlc_xlate_slot_map(qmc_hdlc, te1->slot_map, &ts_info);
+	if (ret)
+		return ret;
+
+	ret = qmc_chan_set_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "set QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+
+	qmc_hdlc->slot_map = te1->slot_map;
+
+	return 0;
+}
+
+static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
+{
+	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
+	te1_settings te1;
+
+	switch (ifs->type) {
+	case IF_GET_IFACE:
+		ifs->type = IF_IFACE_E1;
+		if (ifs->size < sizeof(te1)) {
+			if (!ifs->size)
+				return 0; /* only type requested */
+
+			ifs->size = sizeof(te1); /* data size wanted */
+			return -ENOBUFS;
+		}
+
+		memset(&te1, 0, sizeof(te1));
+
+		/* Update slot_map */
+		te1.slot_map = qmc_hdlc->slot_map;
+
+		if (copy_to_user(ifs->ifs_ifsu.te1, &te1, sizeof(te1)))
+			return -EFAULT;
+		return 0;
+
+	case IF_IFACE_E1:
+	case IF_IFACE_T1:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (netdev->flags & IFF_UP)
+			return -EBUSY;
+
+		if (copy_from_user(&te1, ifs->ifs_ifsu.te1, sizeof(te1)))
+			return -EFAULT;
+
+		return qmc_hdlc_set_iface(qmc_hdlc, ifs->type, &te1);
+
+	default:
+		return hdlc_ioctl(netdev, ifs);
+	}
+}
+
 static int qmc_hdlc_open(struct net_device *netdev)
 {
 	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
@@ -328,13 +485,14 @@ static const struct net_device_ops qmc_hdlc_netdev_ops = {
 	.ndo_open       = qmc_hdlc_open,
 	.ndo_stop       = qmc_hdlc_close,
 	.ndo_start_xmit = hdlc_start_xmit,
-	.ndo_siocwandev	= hdlc_ioctl,
+	.ndo_siocwandev = qmc_hdlc_ioctl,
 };
 
 static int qmc_hdlc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct qmc_hdlc *qmc_hdlc;
+	struct qmc_chan_ts_info ts_info;
 	struct qmc_chan_info info;
 	hdlc_device *hdlc;
 	int ret;
@@ -364,6 +522,15 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+	ret = qmc_hdlc_xlate_ts_info(qmc_hdlc, &ts_info, &qmc_hdlc->slot_map);
+	if (ret)
+		return ret;
+
 	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
 	if (!qmc_hdlc->netdev) {
 		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");
-- 
2.41.0

