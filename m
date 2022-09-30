Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE78C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Sep 2022 07:45:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40C84163D;
	Fri, 30 Sep 2022 09:44:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40C84163D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664523918;
	bh=G+mBcARxluLUNOwRTZdGY68z0TrJha3SpW1z1RkLc6M=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sEyX27TG8PhmQ2gQ+iP2aE+embSdtcTvhzCAKNnR0bfrnuYJ5SLTTlOYrvLQV3lNO
	 I9IuQIUdm8aXZ7rLNifiQltOFlu/7z0sL7qxIbSEYeDLAEmF2JPIn0dzNn3gX+WMJm
	 D7204NQHP2vVjTX/tas629H9oUxd5D9bv/Dx7q9M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD952F80153;
	Fri, 30 Sep 2022 09:44:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71587F800E8; Fri, 30 Sep 2022 09:44:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D2C8F800E8
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2022 09:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D2C8F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ge/hbIDT"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="G/C3/A32"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 147271F8C5;
 Fri, 30 Sep 2022 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1664523859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qrg4tjvgx5O3Al0jsZy7zgEhI+KvLczCwJCFkd1QA/0=;
 b=ge/hbIDTqMXEGjKUA+t0F996l+bqsJSLfVhak4i5NvSXwqDmXOKgSn7sBi0iW1KgoOyZjF
 HZGL+wzT5gwSzJCE1tDEa+CoI9vVvUSUgwji4Qj/QU6Hhx1NrAyICNTPINU2PVN80HpSx3
 514sI4kP9JC0BKyiUV1thS3TcTPrxjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1664523859;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qrg4tjvgx5O3Al0jsZy7zgEhI+KvLczCwJCFkd1QA/0=;
 b=G/C3/A32iiFIxVp0h7afvj9mn4m5vkBD07HQyWZ1NyH+luLX3s8Kmr0rSsUeQnefJVNFNd
 Epsz3b2E0rkPx8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F22B613677;
 Fri, 30 Sep 2022 07:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id alxLOlKeNmPnLwAAMHmgww
 (envelope-from <tiwai@suse.de>); Fri, 30 Sep 2022 07:44:18 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: More robust component matching for CS35L41
Date: Fri, 30 Sep 2022 09:44:16 +0200
Message-Id: <20220930074416.26367-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

As the previous commit implies, a system may have a different SPI bus
number that is embedded in the device string.  And, assuming the fixed
bus number is rather fragile; it may be assigned differently depending
on the configuration or on the boot environment.  Once when a bus
number change happens, the binding fails, resulting in the silence.

This patch tries to make the matching a bit more relaxed, allowing to
bind with a different bus number (or without it).  So the previous
fix, the introduction of ALC245_FIXUP_CS35L41_SPI1_2 fixup became
superfluous, and this is unified to ALC245_FIXUP_CS35L41_SPI_2.

Fixes: 225f6e1bc151 ("ALSA: hda/realtek: Add quirk for HP Zbook Firefly 14 G9 model")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 61 +++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3dc19174670e..cd670884cfd0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6704,23 +6704,51 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 	}
 }
 
+struct cs35l41_dev_name {
+	const char *bus;
+	const char *hid;
+	int index;
+};
+
+/* match the device name in a slightly relaxed manner */
+static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
+{
+	struct cs35l41_dev_name *p = data;
+	const char *d = dev_name(dev);
+	int n = strlen(p->bus);
+	char tmp[32];
+
+	/* check the bus name */
+	if (strncmp(d, p->bus, n))
+		return 0;
+	/* skip the bus number */
+	if (isdigit(d[n]))
+		n++;
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), "-%s:00-cs35l41-hda.%d", p->hid, p->index);
+	return !strcmp(d + n, tmp);
+}
+
 static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
 				  const char *hid, int count)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	char *name;
+	struct cs35l41_dev_name *rec;
 	int ret, i;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		for (i = 0; i < count; i++) {
-			name = devm_kasprintf(dev, GFP_KERNEL,
-					      "%s-%s:00-cs35l41-hda.%d", bus, hid, i);
-			if (!name)
+			rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
+			if (!rec)
 				return;
+			rec->bus = bus;
+			rec->hid = hid;
+			rec->index = i;
 			spec->comps[i].codec = cdc;
-			component_match_add(dev, &spec->match, component_compare_dev_name, name);
+			component_match_add(dev, &spec->match,
+					    comp_match_cs35l41_dev_name, rec);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
@@ -6738,17 +6766,12 @@ static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup
 
 static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 2);
-}
-
-static void cs35l41_fixup_spi1_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
-{
-	cs35l41_generic_fixup(codec, action, "spi1", "CSC3551", 2);
+	cs35l41_generic_fixup(codec, action, "spi", "CSC3551", 2);
 }
 
 static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 4);
+	cs35l41_generic_fixup(codec, action, "spi", "CSC3551", 4);
 }
 
 static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
@@ -7137,8 +7160,6 @@ enum {
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
 	ALC245_FIXUP_CS35L41_SPI_2,
 	ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED,
-	ALC245_FIXUP_CS35L41_SPI1_2,
-	ALC245_FIXUP_CS35L41_SPI1_2_HP_GPIO_LED,
 	ALC245_FIXUP_CS35L41_SPI_4,
 	ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED,
 	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
@@ -8986,16 +9007,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
 	},
-	[ALC245_FIXUP_CS35L41_SPI1_2] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l41_fixup_spi1_two,
-	},
-	[ALC245_FIXUP_CS35L41_SPI1_2_HP_GPIO_LED] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l41_fixup_spi1_two,
-		.chained = true,
-		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
-	},
 	[ALC245_FIXUP_CS35L41_SPI_4] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_four,
@@ -9358,7 +9369,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FIXUP_HP_GPIO_LED),
-	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI1_2_HP_GPIO_LED),
+	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.35.3

