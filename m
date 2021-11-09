Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F210C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:24:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF2C61B3E
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFF2C61B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 588121654;
	Tue,  9 Nov 2021 23:23:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 588121654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496676;
	bh=fiSCtKs2E9uPDYpjkML7x9c0vekPxaZTUiEET0nQK7g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lC16+tOXVaNDzssRDBd56tZdcM2x2+00VK2l6b1Sfmya9pcS/lEvncO0IG5eaoxjR
	 5+61zuwY9cdzjdVyu8jRtmhnbS548nJ42G91W/nl8GpxG+bhH+BTXV1S5r1fDICWmH
	 BNGC+HP6jyF4F8au4sU7C9nxm6y721CWVrJzJehc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6A5AF80543;
	Tue,  9 Nov 2021 23:20:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A1AFF804FD; Tue,  9 Nov 2021 23:20:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A6D9F80516
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:20:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A6D9F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Co5YuRWZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AB9F61A64;
 Tue,  9 Nov 2021 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496411;
 bh=fiSCtKs2E9uPDYpjkML7x9c0vekPxaZTUiEET0nQK7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Co5YuRWZ0XAPa4S2aW2u/s93QmjzY7sB0edE/TYO2uMnhakSeqWh+hRPqcWUZLB1r
 vkTGtfN4Vs6d/ifelVIXfdClrYhC2OuLG0zUGTbzJzHsSAoKZTBPl7cR9iEoI7xue+
 nX0d3NWphfF7dNL0HiQwI5vMJNsG7/PJq05GC7RocteR3IPNeiEraMJPQ0gWoZUR6U
 HHbJxBLEpaJBI4wJlXVeu6SaofsBU0vDjaqj3goDREHAhzN6ZgGAStfADwJad3GAjF
 /hDId8/vs+haKfNn4I3UM/NkM6htxtBRpEtvnaqss/ivpwAVsBlJrrlj27qcITbF+u
 QCvX2HDe0QvOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 39/75] ASoC: nau8824: Add DMI quirk mechanism for
 active-high jack-detect
Date: Tue,  9 Nov 2021 17:18:29 -0500
Message-Id: <20211109221905.1234094-39-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221905.1234094-1-sashal@kernel.org>
References: <20211109221905.1234094-1-sashal@kernel.org>
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
index f946ef65a4c19..f7018f2dd21fd 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -27,6 +28,12 @@
 
 #include "nau8824.h"
 
+#define NAU8824_JD_ACTIVE_HIGH			BIT(0)
+
+static int nau8824_quirk;
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, uint, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static int nau8824_config_sysclk(struct nau8824 *nau8824,
 	int clk_id, unsigned int freq);
@@ -1845,6 +1852,34 @@ static int nau8824_read_device_properties(struct device *dev,
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
@@ -1869,6 +1904,11 @@ static int nau8824_i2c_probe(struct i2c_client *i2c,
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

