Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9F8CA5FFF
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:01:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E435F60289;
	Wed,  7 Oct 2026 09:01:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E435F60289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356511;
	bh=lLLDfF/AamNmWwJC2yvJCvQe71O8cjuMC3ddkYxWWGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vh62uHlMDcnWNkBwbpitPNrKUCuQ24YPhkHBpY0fXXTgQNpdGK86YksSebdxdhPU9
	 1/dB8nSaHaDPDiz6jaXPVqRuFr2Yqiidst4fKRAnYERWvGwNU1uf/Md7HHUEpLW9lW
	 9eWbDkGjoYxhI1LVRGS5WUA6iIS46k5ksMl2c26Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DDB7F808AF; Wed,  7 Oct 2026 08:59:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 587EAF80878;
	Wed,  7 Oct 2026 08:59:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D13ADF8026D; Sun,  4 Oct 2026 09:11:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.225.97
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791097883;
	b=ZhJ2KTHplt95YUimPOazXycHfJw1aEv/4Up68JcGaN4rrii0r+by/iwU0QRW0ox801ih
	 /C+2hJ5gVTcZO9kH+hiMsZ0P64z5lfovEtD4iFrXWRs0jkcgPxzVjG6d5dMOFGQDVs28e
	 HTLlA6I9RPtrQKHAYnPty9BfXs61E/uuKT4yRcmigXD/j15f/Z6PNPCb6eJjmHzvpiCbl
	 W24s8v2MRVNxEbJzz6JmsFVMq+VAIxdhVh8fmB2xgMNqAxHm4LzLnHt93Zv5dvFWbmHUt
	 l+5biTZAfBL+zP6NJd/gG5oxACPET0jTMdIOIuIwaMljAIAL3Q36Tf4A5gbjTKW40/w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791097883;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lLLDfF/AamNmWwJC2yvJCvQe71O8cjuMC3ddkYxWWGM=;
	b=Bb0sCotktn/LlhNee6EUK7nPZilPU2pvT8mdmYtCXBdjXaoLQ83OZk+n0EsasDlBu9nm
	 R4mf2eWzI5q9oH1YZN+eDibSz30oyfx46zhqzLhz8WknKYYkC3holEZI8hEpXFVHOBJbH
	 bg7AtyY4TM5Vpafk0Jwv4TzqpbvIlEC5FU6apYg5RIQXPbLEoJnLDBk1+WSN0/I1NHlYM
	 8dJFmcu4VPZ/NmkqfM0fprZKVuql3hmOw7YCFLhIwB5sIDQgWZPu24W8QlFUhoqnw0zrA
	 fuJQDjWqM5fRAA5hVWs22YtYv6bYSGFQZCsbvMrngJmufqkFHRyoAHUTVSVOg0xiv9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aWsLMiUp;
	arc=none smtp.remote-ip=74.125.225.97
Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com
 [74.125.225.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 90A58F800E4
	for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2026 09:11:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90A58F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aWsLMiUp
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-48b104f6aa3so350537f8f.0
        for <alsa-devel@alsa-project.org>;
 Sun, 04 Oct 2026 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791097881; x=1791702681;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2D6QjoTaBCt2jh1EB0BpFFMcn92myTfBG8HvdrcaiOM=;
        b=aWsLMiUpAaK3lco96tRwLeK3SAb8lXt/WI9Lw/pX/XlOgc9yJNti6pRy7wsML8DNXU
         Ofp1z23h8uN+2vfJgq1UPX0+dZhfbgtSVIBwhpgrvLcFXm1DngeSq2Qvjwq5cuvGhpzU
         wjV8JEBUvMF3EEGTmokbxOCNaTvX9Q5xnYdUcK8kgb135WrLEMlgYTP9VBfRNZzl8Heb
         m9CanAf6TPw1GKFf/1eQ2ToxDZ2rc4is+/FQlf7hrK9TfJyRNbvLKgBbzFjh23Bhs1QM
         FzMcpKmDkDdkwqh50cmmmhIcChTQQN+UcPVAn/KVwWgIrwjnijelSA1Az1Fhy3n/jx3T
         8gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791097881; x=1791702681;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2D6QjoTaBCt2jh1EB0BpFFMcn92myTfBG8HvdrcaiOM=;
        b=zoGqBJCIvqNidjGiqaKnCqqpAdSvk1Pog5mqgOf4IbpcY2Mfik4HfIf4AYyLs67CPf
         tTqLlfZ/4imZ4p+Wudja5v57jZBWURuZcRVRLrr+oh0RjGdTb1br7blg2WHYi3txXsoX
         CvYkYSGBsi0ib0fP11Lw0CGVIO76VllzoeC+SEzUrpRAdYaQB+bxhZVoVjQxVcYyDZv/
         NQrS9xEBrfv1EGy0nsKZKUjrMeaTXO5dN6qspFOs/VdoENu+4K95v0JznYVP6l6u4+Sw
         GY2MAd9aLw8dnzlW9+TsPGIuXajj2lSx9/u4XGUEZdaHIQKOQZSjVOOgZbEEw1yKdkBQ
         Ytjw==
X-Gm-Message-State: AFq9FYIqMtkcK/zpvHYJtMbvyll0J/UCZ1umFAfNurhJg+UZXYBCiWJY
	FPdLCwaSdrdn3EV3JR+y3U8etRIR8mnA0IHarlq6nSZHU9QjtmLGoNo=
X-Gm-Gg: AYBFou2LSmdxVfQpUJjMZknHRuvUIDoLpv7AXtecXvB6qe+5IyV7Lx9a6LulINmdW+H
	pbVlfWhjffjMlU3BF6YWwwOdw2JRRRigWMLqjF3MzSrLWvC2+mQxLyEVqK6H4lLCZFgMqB1VCFl
	j1PUIsoH0ABa7tD1fhxaVj0QwQTdSKoHjAxoSmO2G6XEcAf8TyAXsMlCVMpgIurTX8/j1SIzDSW
	u562rIbA+OnOX6PqQNlbgNoFKYMOhoWZG+aNLdhn03744KxneT1ybzwWJvcw251gwgtDgfAuDTa
	dS0z0u/q+UiTToqv3JLSZi2AUX0blorNUhNn41i1dBSra5IZnZxgGWEMA751mCfnCPw2RWLzv/+
	1+euJHcBTNv5cAfE4M9mO75hM5awF0bVpLru5/AKS1eNqvyAaLoES5CqKP+SKpaC31PLhTyiTc+
	unsMirviX8zp/yijf8rmb62cFp6LAIMr+sXQfxO2dDJxQnTB+HP+1ed0U2fLBEnKTJ6Cky25ids
	F0eufpQ3HqUICLVtUa14zyjEc9TygKGvkwGmBRUrwH9z8V1z1rMVkXGigbQCIra
X-Received: by 2002:a05:6000:1846:b0:48b:1bf:ffb1 with SMTP id
 ffacd0b85a97d-48b12775c61mr14876646f8f.54.1791097880928;
        Sun, 04 Oct 2026 00:11:20 -0700 (PDT)
Received: from yoga.fritz.box
 (p200300f3cf01bb00103cf82222a83fe3.dip0.t-ipconnect.de.
 [2003:f3:cf01:bb00:103c:f822:22a8:3fe3])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm18004720f8f.37.2026.10.04.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:11:20 -0700 (PDT)
From: Georg Wenzel <g.wenzel@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georg Wenzel <g.wenzel@gmail.com>
Subject: [PATCH v2] ALSA: hda/tas2781: Enable bass speakers support
Date: Sun,  4 Oct 2026 09:12:00 +0200
Message-ID: <20261004071202.89116-1-g.wenzel@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87cxtw2y8b.wl-tiwai@suse.de>
References: <87cxtw2y8b.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: g.wenzel@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: S2BJFAAHN3JWT3YNHWGI6APCU6WXT5BJ
X-Message-ID-Hash: S2BJFAAHN3JWT3YNHWGI6APCU6WXT5BJ
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:58:30 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2BJFAAHN3JWT3YNHWGI6APCU6WXT5BJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Configure the driver to correctly initialize and enable the bass speakers
on devices utilizing the TAS2781 amplifier. Without this change, only the
tweeters or main speakers are active, leading to thin audio output.

Set up the required register sequences and routing to ensure the bass
channels are properly powered and mixed into the audio stream.

Signed-off-by: Georg Wenzel <g.wenzel@gmail.com>
---
v2:
  - Rebased onto sound/for-next (Takashi Iwai).
  - Removed non-ASCII characters in comments (Takashi Iwai).
  
 include/sound/tas2781.h                       | 12 +++
 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 98 +++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index b763da613769..ccc0142fbad5 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -91,6 +91,18 @@
 /* prm_TE_1_Beta1 */
 #define TAS2563_TE_DT_REG		TASDEVICE_REG(0x00, 0x0f, 0x70)
 
+/* TAS2563 ASI (Audio Serial Interface) Register Definitions */
+#define TAS2563_ASI_CFG_REG			TASDEVICE_REG(0x00, 0x00, 0x06)
+#define TAS2563_ASI_SR_REG			TASDEVICE_REG(0x00, 0x00, 0x07)
+#define TAS2563_ASI_FS_REG			TASDEVICE_REG(0x00, 0x00, 0x08)
+#define TAS2563_ASI_DA_REG			TASDEVICE_REG(0x00, 0x00, 0x0a)
+#define TAS2563_ASI_TDM_REG			TASDEVICE_REG(0x00, 0x00, 0x0b)
+#define TAS2563_ASI_DL_REG			TASDEVICE_REG(0x00, 0x00, 0x0c)
+#define TAS2563_ASI_SLOT_REG		TASDEVICE_REG(0x00, 0x00, 0x30)
+
+/* TAS2563 ASI Apply Register (triggers configuration update) */
+#define TAS2563_ASI_APPLY_REG			TASDEVICE_REG(0x00, 0x00, 0x02)
+
 #define TAS2781_PRM_INT_MASK_REG	TASDEVICE_REG(0x00, 0x00, 0x3b)
 #define TAS2781_PRM_CLK_CFG_REG		TASDEVICE_REG(0x00, 0x00, 0x5c)
 #define TAS2781_PRM_RSVD_REG		TASDEVICE_REG(0x00, 0x01, 0x19)
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 5e5f46c9fb6b..cef33159eba4 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -46,6 +46,83 @@
 #define TAS2563_CAL_TLIM		TASDEVICE_REG(0, 0x10, 0x14)
 #define TAS2563_CAL_R0			TASDEVICE_REG(0, 0x0f, 0x34)
 
+/*
+ * TAS2563 Post-Firmware ASI Configuration.
+ *
+ * The DSP firmware loading can overwrite the ASI (Audio Serial Interface)
+ * registers that configure the I2S/TDM audio path to the amplifier.
+ * This function re-applies the correct ASI configuration after firmware load,
+ * matching the reference initialization sequence used by the vendor script:
+ *   - Software reset
+ *   - ASI_CFG  = 0x09 (I2S mode, master/slave config)
+ *   - ASI_SR   = 0x02 (sample rate divider for 48 kHz)
+ *   - ASI_DA   = 0xf1 (data alignment / slot assignment)
+ *   - ASI_TDM  = 0x02 (TDM mode select)
+ *   - ASI_DL   = 0x00 (delay line off)
+ *   - ASI_SLOT = 0x99 (slot enable mask for 2-channel stereo)
+ *   - CHNL_0   = 0x02 (channel mapping)
+ *   - ASI_FS   = 0x1e or 0x2e (frame sync, device-specific: bit4 selects
+ *                which of the two devices is the "primary" for FS generation)
+ *   - ASI_APPLY= 0x00 (trigger configuration update)
+ */
+static void tas2563_post_fw_init(struct tasdevice_priv *tas_priv)
+{
+	int i, ret;
+
+	dev_info(tas_priv->dev, "%s: ndev=%d, chip_id=%d\n",
+		 __func__, tas_priv->ndev, tas_priv->chip_id);
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		struct tasdevice *tasdev = &tas_priv->tasdevice[i];
+		u8 fs_val;
+
+		dev_info(tas_priv->dev,
+			 "%s: device[%d] dev_addr=0x%02x\n",
+			 __func__, i, tasdev->dev_addr);
+
+		/* Step 1: Software reset (matches script: 0x01 = 0x01) */
+		ret = tasdevice_dev_write(tas_priv, i, TASDEVICE_REG_SWRESET,
+					  TASDEVICE_REG_SWRESET_RESET);
+		dev_info(tas_priv->dev,
+			 "%s: chn=%d SWRESET ret=%d\n", __func__, i, ret);
+		usleep_range(1000, 2000);
+
+		/* Step 2: ASI configuration registers */
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_CFG_REG, 0x09);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_CFG=0x09 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_SR_REG, 0x02);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_SR=0x02 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_DA_REG, 0xf1);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_DA=0xf1 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_TDM_REG, 0x02);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_TDM=0x02 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_DL_REG, 0x00);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_DL=0x00 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_SLOT_REG, 0x99);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_SLOT=0x99 ret=%d\n", __func__, i, ret);
+
+		ret = tasdevice_dev_write(tas_priv, i, TAS2781_PRM_CHNL_0_REG, 0x02);
+		dev_info(tas_priv->dev, "%s: chn=%d CHNL_0=0x02 ret=%d\n", __func__, i, ret);
+
+		/* Step 3: Device-specific frame sync (0x1e for dev0, 0x2e for dev1) */
+		fs_val = 0x1e | ((i & 0x01) << 4);
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_FS_REG, fs_val);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_FS=0x%02x ret=%d\n",
+				__func__, i, fs_val, ret);
+
+		/* Step 4: Apply ASI configuration */
+		ret = tasdevice_dev_write(tas_priv, i, TAS2563_ASI_APPLY_REG, 0x00);
+		dev_info(tas_priv->dev, "%s: chn=%d ASI_APPLY ret=%d\n", __func__, i, ret);
+
+		usleep_range(1000, 2000);
+	}
+}
+
 enum device_chip_id {
 	HDA_TAS2563,
 	HDA_TAS2770,
@@ -172,6 +249,13 @@ static void tas2781_hda_playback_hook(struct device *dev, int action)
 		pm_runtime_get_sync(dev);
 		scoped_guard(mutex, &tas_hda->priv->codec_lock) {
 			tasdevice_tuning_switch(tas_hda->priv, 0, false);
+			/* Re-apply ASI configuration for TAS2563 after
+			 * tuning switch - DSP firmware loading can
+			 * overwrite ASI registers.
+			 */
+			if (tas_hda->priv->chip_id == TAS2563)
+				tas2563_post_fw_init(tas_hda->priv);
+
 			tas_hda->priv->playback_started = true;
 		}
 		break;
@@ -475,6 +559,12 @@ static void tasdevice_dspfw_init(void *context)
 			tas_priv->rcabin.init_profile_id,
 			TASDEVICE_BIN_BLK_PRE_POWER_UP);
 
+	/* Apply ASI configuration for TAS2563 after firmware load.
+	 * DSP firmware loading can overwrite ASI registers.
+	 */
+	if (tas_hda->priv->chip_id == TAS2563)
+		tas2563_post_fw_init(tas_hda->priv);
+
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
@@ -659,6 +749,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		 */
 		device_name = "INT8866";
 		hda_priv->hda_chip_id = HDA_TAS2563;
+		tas_hda->priv->chip_id = TAS2563;
 		hda_priv->save_calibration = tas2563_save_calibration;
 		tas_hda->priv->global_addr = TAS2563_GLOBAL_ADDR;
 	} else if (strstarts(dev_name(&clt->dev), "i2c-TXNW5825")) {
@@ -782,6 +873,13 @@ static int tas2781_system_resume(struct device *dev)
 			tas_hda->priv->rcabin.init_profile_id,
 			TASDEVICE_BIN_BLK_PRE_POWER_UP);
 
+	/* Re-apply ASI configuration for TAS2563 after system sleep
+	 * resume — amplifiers may lose their register state during
+	 * suspend-to-ram or suspend-to-disk regardless of playback state.
+	 */
+	if (tas_hda->priv->chip_id == TAS2563)
+		tas2563_post_fw_init(tas_hda->priv);
+
 	if (tas_hda->priv->playback_started)
 		tasdevice_tuning_switch(tas_hda->priv, 0, false);
 
-- 
2.55.0

