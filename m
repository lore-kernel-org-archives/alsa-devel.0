Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7643C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:31:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCE260E54
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BCE260E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEB5116B4;
	Tue,  9 Nov 2021 23:30:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEB5116B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636497068;
	bh=dp4wwUseV5qUf5xSbC9F2O0f3tz/bFtGcn0p2CQcR9g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHeKageEqhz3n/R8BN/ud02EpzLNiOa5TucTxw8WqYqy+xova78nyzIhkqCOgRVD/
	 sM0f+5DPIHDLDQTyEsf8toS3VvgtmpNsdcsyZodBCqtB4fLJoMLdNMpi88MYfO5QUJ
	 OeRHwuLsOCpykyFCGBkCHoR2j6F07WUvCRN7vcWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16187F804EC;
	Tue,  9 Nov 2021 23:23:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A3D6F804FA; Tue,  9 Nov 2021 23:23:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4635F804D0
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:23:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4635F804D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vJeXNmmJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0585F61B24;
 Tue,  9 Nov 2021 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496606;
 bh=dp4wwUseV5qUf5xSbC9F2O0f3tz/bFtGcn0p2CQcR9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vJeXNmmJzHqqMULJen/ITNbyY3+J8fdWp57c9cJqL456GZw7IxlZtvUNx17PPnfFN
 9Tcy8GiiL9atwjdG/FpPaI15b2Pl/ccdfACtkfNUnwQuFBuBVORlz3LL/rAzOtMQMp
 eEnb5nO+Q/CliLjB9ZLlG2OihTpZzMgw3R/hXWZwIw+8PhqiXMnp59wunYXvlQuLvS
 6GknzCYbI/NIBGoo/S1HsqRzILdT2JVhT/my+SB/3l/rdQ/wBq2/1OgcA2MWcZ7aaP
 kcq07QQn7KKRbszUOZyjAoTRiE5TGzUuu7xFm2IP8qV+gkba2YriKZH60GrPWkJv/R
 75HTNWyXJP7tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/21] ASoC: nau8824: Add DMI quirk mechanism for
 active-high jack-detect
Date: Tue,  9 Nov 2021 17:22:58 -0500
Message-Id: <20211109222311.1235686-9-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109222311.1235686-1-sashal@kernel.org>
References: <20211109222311.1235686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 92d3360108f1839ca40451bad20ff67dd24a1964 ]

Add a quirk mechanism to allow specifying that active-high jack-detection
should be used on platforms where this info is not available in devicetree.

And add an entry for the Cyberbook T116 tablet to the DMI table, so that
jack-detection will work properly on this tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20211002211459.110124-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8824.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 663a208c2f784..4af87340b1655 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -30,6 +31,12 @@
 
 #include "nau8824.h"
 
+#define NAU8824_JD_ACTIVE_HIGH			BIT(0)
+
+static int nau8824_quirk;
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, uint, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static int nau8824_config_sysclk(struct nau8824 *nau8824,
 	int clk_id, unsigned int freq);
@@ -1878,6 +1885,34 @@ static int nau8824_read_device_properties(struct device *dev,
 	return 0;
 }
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id nau8824_quirk_table[] = {
+	{
+		/* Cyberbook T116 rugged tablet */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "20170531"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{}
+};
+
+static void nau8824_check_quirks(void)
+{
+	const struct dmi_system_id *dmi_id;
+
+	if (quirk_override != -1) {
+		nau8824_quirk = quirk_override;
+		return;
+	}
+
+	dmi_id = dmi_first_match(nau8824_quirk_table);
+	if (dmi_id)
+		nau8824_quirk = (unsigned long)dmi_id->driver_data;
+}
+
 static int nau8824_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -1902,6 +1937,11 @@ static int nau8824_i2c_probe(struct i2c_client *i2c,
 	nau8824->irq = i2c->irq;
 	sema_init(&nau8824->jd_sem, 1);
 
+	nau8824_check_quirks();
+
+	if (nau8824_quirk & NAU8824_JD_ACTIVE_HIGH)
+		nau8824->jkdet_polarity = 0;
+
 	nau8824_print_device_properties(nau8824);
 
 	ret = regmap_read(nau8824->regmap, NAU8824_REG_I2C_DEVICE_ID, &value);
-- 
2.33.0

