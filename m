Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 10:15:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EBFA1713;
	Tue, 26 Apr 2022 12:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EBFA1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650968102;
	bh=gMkRL8LRL7OGO4V4cZetXaqKWO1DgVC12gZUHKRcTX4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CnpwpO11AgPJb/kc9cQek6/gavXo1pOSZIVSNoLAN8YHd7NRAgJvad8Brto+1FiPH
	 gzAcGXXgwPh/aL0JYsqwizrjkoGJZwBs3eQ2P9Hbfd7WvlgWanIrrfe6BW9bBwVDiY
	 tn2f7u9NV1v5UgFbGbAQUwNdqfTHayiRRDikRhAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C93AF8014B;
	Tue, 26 Apr 2022 12:14:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD04EF80152; Tue, 26 Apr 2022 12:14:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24188F800AE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 12:14:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24188F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NadJD+d3"
Received: by mail-ej1-x631.google.com with SMTP id j6so1181284ejc.13
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jDIDl2P8Igjno9kQvR2HtX/pm4TQNzMyAmiDnuWYgaE=;
 b=NadJD+d3ieg0k+fumP5RsWvO/a7CGATFTlBfYe7H9EgIipPDCqX2xBq/VSMFtn66F1
 RpPEk4Y252DtKFb7arKJq1q0OturX1RBIv+7mFRd9jKX3Vps56ThoRkTBRvhdWdcx4/T
 UBngREkpl14O/J2J5xKvfw9QxCaFKPngchjNQnGaVVQwJ08F4D3qFHYfSAc6Dg88DWKm
 PK6uc6s1pvuHWpZRWL2inbUxICZnpTPzyvwxqCeUr38uOVMtAP7RKhnfEot49dt0+veR
 QNEYahPhuNL++rNQ1WIXFyXcbdG0qzDncBI2cPs/uyGAGhU+OooWcLdDfduNYHoIRLdv
 QYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jDIDl2P8Igjno9kQvR2HtX/pm4TQNzMyAmiDnuWYgaE=;
 b=uJc7us43/H0+tXW/QTcO5M2aQBpA/5WuoCnxE31gph/a13uQ8derHv9fOeUzkUNI5N
 OadUvKsgXY699qUKON/Ip0umkWBKJ8DUk4V4CAGzHckyHFMGXgdyMNntEY67zBwtPPTX
 LmTf6YOsSu9ufQ4HVLmFCMirbZS06K6gdlxNqAxiZss+GMbis2M8B/tn8Ak/3WTKVgnw
 HKhjX1ibq7w5yosKIG3/zKxazBj387B/iTGrcgkigZ7NfLF09mbOtf5GMXAE1vZ5cZ7D
 kpZDfjiGOGbLvfnosBzxNscN1eB6uiHEfikAMsGG5Sy9U3V2c+Q26v5HvIdKzpQO+vYx
 QSUw==
X-Gm-Message-State: AOAM530CkVFs9nMrknH5+kJfrUrqKqO9D99MUm9ilS2RXirNurpq8mXd
 reEkR/Uf2E6zwoXi4gZON/k3VauDDHk=
X-Google-Smtp-Source: ABdhPJzdi1luH7HrzGVOXotvteEaJC7F/w3wKuuJR4YT98G0wGLKIStdckf6Phdbvo9Z3qgmVnVP4w==
X-Received: by 2002:a17:907:94cd:b0:6ef:8e52:602b with SMTP id
 dn13-20020a17090794cd00b006ef8e52602bmr20931353ejc.592.1650968044421; 
 Tue, 26 Apr 2022 03:14:04 -0700 (PDT)
Received: from localhost.localdomain (net-109-116-144-55.cust.vodafonedsl.it.
 [109.116.144.55]) by smtp.gmail.com with ESMTPSA id
 p12-20020a50c94c000000b00425c48132bfsm5309488edh.55.2022.04.26.03.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 03:14:04 -0700 (PDT)
From: gabriele.mzt@gmail.com
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Dell Latitude 7520
Date: Tue, 26 Apr 2022 12:13:59 +0200
Message-Id: <20220426101359.37794-1-gabriele.mzt@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
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

From: Gabriele Mazzotta <gabriele.mzt@gmail.com>

This fixes the pop noises that can be heard at boot time if the
headphone jack is plugged in or when inserting/removing the jack.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 62fbf3772b41..fa9878daa3bb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6780,6 +6780,23 @@ static void alc256_fixup_mic_no_presence_and_resume(struct hda_codec *codec,
 	}
 }
 
+static void alc_fixup_dell4_mic_vref(struct hda_codec *codec,
+				     const struct hda_fixup *fix,
+				     int action)
+{
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		/**
+		 * Set the vref of pin 0x19 (Headset Mic) and pin 0x1b (Headphone Mic)
+		 * to Hi-Z to avoid pop noises at startup and when plugging and
+		 * unplugging headphones/speakers.
+		 */
+		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
+		snd_hda_codec_set_pin_target(codec, 0x1b, PIN_VREFHIZ);
+		break;
+	}
+}
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -7011,6 +7028,7 @@ enum {
 	ALC245_FIXUP_CS35L41_SPI_4,
 	ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED,
 	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
+	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_VREF,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8799,6 +8817,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
 	},
+	[ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_VREF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_dell4_mic_vref,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8889,6 +8913,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x09bf, "Dell Precision", ALC233_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0a2e, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0a38, "Dell Latitude 7520", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_VREF),
 	SND_PCI_QUIRK(0x1028, 0x0a58, "Dell", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a61, "Dell XPS 15 9510", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0a62, "Dell Precision 5560", ALC289_FIXUP_DUAL_SPK),
-- 
2.36.0

