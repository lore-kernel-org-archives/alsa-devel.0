Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D74C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:28:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BD72BC0;
	Thu, 25 Apr 2024 09:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BD72BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714030115;
	bh=65cWIqqFlMmIyMOsBipC9dRn0tASPdwax90byUebSto=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=gUYF1VK2PxaiyaJw87E3lBf89gwKpVGOzkGWHZVco9/cxlTbBJnXmM+QlvmGx2XTC
	 D6TpwF1470ppDyYmrRJPo4YIu0hedxNi+QWJM2bEUC8ykk3p4Nj//U/2bBK4Of95QU
	 x1s5AAfRMK0dbA6CP3UVFrmxCKT/8LKFeiXyyruE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18D2FF805AC; Thu, 25 Apr 2024 09:28:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7409CF805A9;
	Thu, 25 Apr 2024 09:28:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A593F800B5; Thu, 25 Apr 2024 09:23:40 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8DB0F800B5
	for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2024 09:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8DB0F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=ZUIcpL1U
Received: from localhost.localdomain (unknown [222.129.33.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 55FAC3F6D2;
	Thu, 25 Apr 2024 07:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714029620;
	bh=S6WlPjrzv7yv//Pb94QcMjZ/iQsiWsVrpMWt6N4gcAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZUIcpL1UTSjuH+uCURCsADWzjhSXK+gJA1Gu8a173QIW45Yotp4d2KSBYnjp7wCPq
	 x42spTsd9BNvPyHiFCxn6e1jUcstBPa/dU1CnkF9EyuuUeTUJ815thpQ7ZCSRJGXC1
	 6qvecQsRVASM+13ZAYb3hB53uobtGzOoBh8VQjHZILfPZ4M8o7pvnMwEHOHVL/k/yG
	 RssVApKcNa1o3fNrvQoje7/v/0RuTXlwmQXFzxCSs/7MjQlz3IpeGochyvvqw13Li8
	 h22jlPCdpscvQnNvrr9fCLZyZlIi3i3LHExD/aonUgjicRhspkRHEralrokoa6rifA
	 0Yy7LrF3rfoZg==
From: Aaron Ma <aaron.ma@canonical.com>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: hda/ASOC tas2781: align the path of firmware
Date: Thu, 25 Apr 2024 15:20:00 +0800
Message-ID: <20240425072000.22284-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5I326Y3DQLFLSTT23KJACXHLWYP327YX
X-Message-ID-Hash: 5I326Y3DQLFLSTT23KJACXHLWYP327YX
X-MailFrom: aaron.ma@canonical.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5I326Y3DQLFLSTT23KJACXHLWYP327YX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

TI upstream the files in ti/tas2781 for linux-firmware.
Make the driver find the correct files.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 include/sound/tas2781.h           | 1 +
 sound/pci/hda/tas2781_hda_i2c.c   | 2 +-
 sound/soc/codecs/tas2781-comlib.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 99ca3e401fd1..72119cc32c0f 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -21,6 +21,7 @@
 /* version number */
 #define TAS2781_DRV_VER			1
 #define SMARTAMP_MODULE_NAME		"tas2781"
+#define TAS2781_FIRMWARE_ROOT		"ti/tas2781/"
 #define TAS2781_GLOBAL_ADDR	0x40
 #define TAS2563_GLOBAL_ADDR	0x48
 #define TASDEVICE_RATES			(SNDRV_PCM_RATE_44100 |\
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 75f7674c66ee..72dc1469655f 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -649,7 +649,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_dsp_remove(tas_priv);
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
-	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
+	scnprintf(tas_priv->coef_binaryname, 64, "%sTAS2XXX%04X.bin", TAS2781_FIRMWARE_ROOT,
 		codec->core.subsystem_id & 0xffff);
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 3aa81514dad7..96fe1b855ec9 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -277,7 +277,7 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 	 */
 	mutex_lock(&tas_priv->codec_lock);
 
-	scnprintf(tas_priv->rca_binaryname, 64, "%sRCA%d.bin",
+	scnprintf(tas_priv->rca_binaryname, 64, "%s%sRCA%d.bin", TAS2781_FIRMWARE_ROOT,
 		tas_priv->dev_name, tas_priv->ndev);
 	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
 	tas_priv->codec = codec;
-- 
2.34.1

