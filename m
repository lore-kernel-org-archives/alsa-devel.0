Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA6EC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:55:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A330208A1
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MGsFDrT0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="wBui1ewp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A330208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8929B1720;
	Wed, 20 Nov 2019 18:45:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8929B1720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574271953;
	bh=wPHEO2RXyPKwtUcT9unr4pV+TCzxipsBvc76zqHjcp8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MGsFDrT0BHd59DWu0KfU55aRpT8nvGgPGggpFdevo1hqZfWEOuIpFFdmrKc5Qk3Sa
	 4z3/wJnukMbBIN+z2lpAwcuWHjZjgp3CFV/fTEq+U2Hi0RSKCgYd/kG2lZnflkht2z
	 HGLI33xVhpXLtQkrGLee63lDUdLD3D2fQfsVRDcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C201BF8013C;
	Wed, 20 Nov 2019 18:45:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4657AF8013D; Wed, 20 Nov 2019 18:45:01 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 875C4F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:44:58 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 430E1A003F;
 Wed, 20 Nov 2019 18:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 430E1A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574271897; bh=cmB3ueqg5Fq5tf1AcRb4YtammwsjUP5VJrBCQ0zViqY=;
 h=From:To:Cc:Subject:Date:From;
 b=wBui1ewpz/TXUr4XzSXnS+R5zaJnMC6BA/GlEo4RzI+w+EtKOdajNYc45mzDCqS0j
 LVsHYqlFOwqr8HnryuCl8KlFHA0NspRyQGCArJgXOZvRm7CCxR/c6nUZp0vo6I4F9q
 Y6yw5h7r2wgrrQDJcAqzvcdbWxFGAmamMDGQkYWo=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 20 Nov 2019 18:44:52 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Date: Wed, 20 Nov 2019 18:44:34 +0100
Message-Id: <20191120174435.30920-1-perex@perex.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 1/2] ASoC: improve the DMI long card code in
	asoc-core
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add append_dmi_string() function and make the code more readable.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-core.c | 66 +++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b4683d4588ee..db56507174bd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1755,6 +1755,23 @@ static int is_dmi_valid(const char *field)
 	return 1;
 }
 
+/*
+ * Append a string to card->dmi_longname with character cleanups.
+ */
+static void append_dmi_string(struct snd_soc_card *card, const char *str)
+{
+	char *dst = card->dmi_longname;
+	size_t dst_len = sizeof(card->dmi_longname);
+	size_t len;
+
+	len = strlen(dst);
+	snprintf(dst + len, dst_len - len, "-%s", str);
+
+	len++;	/* skip the separator "-" */
+	if (len < dst_len)
+		cleanup_dmi_name(dst + len);
+}
+
 /**
  * snd_soc_set_dmi_name() - Register DMI names to card
  * @card: The card to register DMI names
@@ -1789,61 +1806,36 @@ static int is_dmi_valid(const char *field)
 int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 {
 	const char *vendor, *product, *product_version, *board;
-	size_t longname_buf_size = sizeof(card->snd_card->longname);
-	size_t len;
 
 	if (card->long_name)
 		return 0; /* long name already set by driver or from DMI */
 
-	/* make up dmi long name as: vendor.product.version.board */
+	/* make up dmi long name as: vendor-product-version-board */
 	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 	if (!vendor || !is_dmi_valid(vendor)) {
 		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
 		return 0;
 	}
 
-	snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
-			 "%s", vendor);
+	snprintf(card->dmi_longname, sizeof(card->dmi_longname), "%s", vendor);
 	cleanup_dmi_name(card->dmi_longname);
 
 	product = dmi_get_system_info(DMI_PRODUCT_NAME);
 	if (product && is_dmi_valid(product)) {
-		len = strlen(card->dmi_longname);
-		snprintf(card->dmi_longname + len,
-			 longname_buf_size - len,
-			 "-%s", product);
-
-		len++;	/* skip the separator "-" */
-		if (len < longname_buf_size)
-			cleanup_dmi_name(card->dmi_longname + len);
+		append_dmi_string(card, product);
 
 		/*
 		 * some vendors like Lenovo may only put a self-explanatory
 		 * name in the product version field
 		 */
 		product_version = dmi_get_system_info(DMI_PRODUCT_VERSION);
-		if (product_version && is_dmi_valid(product_version)) {
-			len = strlen(card->dmi_longname);
-			snprintf(card->dmi_longname + len,
-				 longname_buf_size - len,
-				 "-%s", product_version);
-
-			len++;
-			if (len < longname_buf_size)
-				cleanup_dmi_name(card->dmi_longname + len);
-		}
+		if (product_version && is_dmi_valid(product_version))
+			append_dmi_string(card, product_version);
 	}
 
 	board = dmi_get_system_info(DMI_BOARD_NAME);
 	if (board && is_dmi_valid(board)) {
-		len = strlen(card->dmi_longname);
-		snprintf(card->dmi_longname + len,
-			 longname_buf_size - len,
-			 "-%s", board);
-
-		len++;
-		if (len < longname_buf_size)
-			cleanup_dmi_name(card->dmi_longname + len);
+		append_dmi_string(card, board);
 	} else if (!product) {
 		/* fall back to using legacy name */
 		dev_warn(card->dev, "ASoC: no DMI board/product name!\n");
@@ -1851,16 +1843,8 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	}
 
 	/* Add flavour to dmi long name */
-	if (flavour) {
-		len = strlen(card->dmi_longname);
-		snprintf(card->dmi_longname + len,
-			 longname_buf_size - len,
-			 "-%s", flavour);
-
-		len++;
-		if (len < longname_buf_size)
-			cleanup_dmi_name(card->dmi_longname + len);
-	}
+	if (flavour)
+		append_dmi_string(card, flavour);
 
 	/* set the card long name */
 	card->long_name = card->dmi_longname;
-- 
2.20.1
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
