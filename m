Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:01:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE13206E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LMd1BzV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE13206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4B1216AB;
	Tue,  7 Jul 2020 11:00:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4B1216AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594112487;
	bh=OD9zr9VDO/He5A5dl1J6+8mB9bUB8hteyh1BDPQChVw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LMd1BzV6I4jgL47aPQXqCFFWmEhdlr3O5ZmAf5G0wfgkeHJF+IR9IllQPr+XWLe44
	 h/1AFA51bPKV4r2xUGtX1R+x8ckjgPvPwu7uSMbCgTzszQOnZdGU0Fro88hlKbZrSS
	 O8Yp5rQa6XZqdu28BATXRGL2vGuMoQDro3DzFftQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46EDFF8027C;
	Tue,  7 Jul 2020 10:58:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED6E4F80274; Tue,  7 Jul 2020 10:58:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F378FF801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 10:58:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F378FF801F9
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B08D22015DF;
 Tue,  7 Jul 2020 10:58:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6068E2015EC;
 Tue,  7 Jul 2020 10:58:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C7669402F7;
 Tue,  7 Jul 2020 16:58:36 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: fsl_spdif: Add kctl for configuring TX validity bit
Date: Tue,  7 Jul 2020 16:54:26 +0800
Message-Id: <1594112066-31297-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add one kctl for configuring TX validity bit from user
space.

The type of this kctl is boolean:
on - Outgoing validity always set
off - Outgoing validity always clear

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 47 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 576370dc6e70..37053e8f29d0 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -776,8 +776,8 @@ static int fsl_spdif_vbit_info(struct snd_kcontrol *kcontrol,
 }
 
 /* Get valid good bit from interrupt status register */
-static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+static int fsl_spdif_rx_vbit_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
@@ -791,6 +791,35 @@ static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int fsl_spdif_tx_vbit_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regmap = spdif_priv->regmap;
+	u32 val;
+
+	regmap_read(regmap, REG_SPDIF_SCR, &val);
+	val = (val & SCR_VAL_MASK) >> SCR_VAL_OFFSET;
+	val = 1 - val;
+	ucontrol->value.integer.value[0] = val;
+
+	return 0;
+}
+
+static int fsl_spdif_tx_vbit_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regmap = spdif_priv->regmap;
+	u32 val = (1 - ucontrol->value.integer.value[0]) << SCR_VAL_OFFSET;
+
+	regmap_update_bits(regmap, REG_SPDIF_SCR, SCR_VAL_MASK, val);
+
+	return 0;
+}
+
 /* DPLL lock information */
 static int fsl_spdif_rxrate_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
@@ -948,11 +977,21 @@ static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	/* Valid bit error controller */
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = "IEC958 V-Bit Errors",
+		.name = "IEC958 RX V-Bit Errors",
 		.access = SNDRV_CTL_ELEM_ACCESS_READ |
 			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 		.info = fsl_spdif_vbit_info,
-		.get = fsl_spdif_vbit_get,
+		.get = fsl_spdif_rx_vbit_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "IEC958 TX V-Bit",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_WRITE |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = fsl_spdif_vbit_info,
+		.get = fsl_spdif_tx_vbit_get,
+		.put = fsl_spdif_tx_vbit_put,
 	},
 	/* DPLL lock info get controller */
 	{
-- 
2.21.0

