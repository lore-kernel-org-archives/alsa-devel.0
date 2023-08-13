Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EEFC04A6A
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 15:52:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9893983E;
	Sun, 13 Aug 2023 17:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9893983E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691941920;
	bh=2V+JFntOnsVF3G99xDqY6Zmhg9MklZAntZuwOw2aLhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EASqfPyOzQFc9YGLeR7EM1tbEFwGFHrHM3DQb7qSsHVY+N6UAJPiKtgGEWibC4Kzo
	 HVoUiZ6oryQhual800JRstBOjz2CJ31vDc/l5doUkZJ3ql320AKnCLpf3sZqSXrvZh
	 Ei4NyjSZIdm7lPzG/yyiMjeLul4rcUgWwFUOU4Os=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1AB8F80563; Sun, 13 Aug 2023 17:50:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C7CE0F80552;
	Sun, 13 Aug 2023 17:50:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CDCBF80272; Sun, 13 Aug 2023 17:50:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0628DF8025F
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 17:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0628DF8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q/S43zEW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A2B2863189;
	Sun, 13 Aug 2023 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C473C433C7;
	Sun, 13 Aug 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691941807;
	bh=2V+JFntOnsVF3G99xDqY6Zmhg9MklZAntZuwOw2aLhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/S43zEWQlW6hAgKgo5rPL+8jPhQzMAxc/NT26V/YvE2knJ9msWJuQ0pEaTw1pfFn
	 BRWirqfNS0NqGmQZ3j0vvlNo8bzHRDjNjQhJWx0Lr1yWAoEWXMoPv2I2gLO6RAX7U7
	 2+m9YMxaF5imTB+TY9DCjrz8QWqVuJ/9/KjGVcDgJkSFXystgaKas8rBTU6s3RzqQz
	 Z4ZHhQzxH7hJthiBwGosX3o3HIobbw3AjkGTz2u1bdXKwo0omWh1P19SkXzewmp/Mb
	 i3TF+xhNhStdDqXKOo94WB/5Lsd1sg164IYyXW+G4mn5qj2HFRF+6mXWgOrS6q1LyN
	 ou/wEhgEKOyOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	wtli@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 17/54] ASoC: nau8821: Add DMI quirk mechanism for
 active-high jack-detect
Date: Sun, 13 Aug 2023 11:48:56 -0400
Message-Id: <20230813154934.1067569-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LXOI6F47ONH35NOOGGT63QSZ73LR5F5Z
X-Message-ID-Hash: LXOI6F47ONH35NOOGGT63QSZ73LR5F5Z
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LXOI6F47ONH35NOOGGT63QSZ73LR5F5Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

[ Upstream commit 1bc40efdaf4a0ccfdb10a1c8e4b458f4764e8e5f ]

Add a quirk mechanism to allow specifying that active-high jack-detection
should be used on platforms where this info is not available in devicetree.

And add an entry for the Positivo CW14Q01P-V2 to the DMI table, so that
jack-detection will work properly on this laptop.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Link: https://lore.kernel.org/r/20230719200241.4865-1-edson.drosdeck@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8821.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index fee970427a243..42de7588fdb68 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -25,6 +26,13 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
+#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+
+static int nau8821_quirk;
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, uint, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
+
 #define NAU_FREF_MAX 13500000
 #define NAU_FVCO_MAX 100000000
 #define NAU_FVCO_MIN 90000000
@@ -1792,6 +1800,33 @@ static int nau8821_setup_irq(struct nau8821 *nau8821)
 	return 0;
 }
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id nau8821_quirk_table[] = {
+	{
+		/* Positivo CW14Q01P-V2 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
+		},
+		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+	},
+	{}
+};
+
+static void nau8821_check_quirks(void)
+{
+	const struct dmi_system_id *dmi_id;
+
+	if (quirk_override != -1) {
+		nau8821_quirk = quirk_override;
+		return;
+	}
+
+	dmi_id = dmi_first_match(nau8821_quirk_table);
+	if (dmi_id)
+		nau8821_quirk = (unsigned long)dmi_id->driver_data;
+}
+
 static int nau8821_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -1812,6 +1847,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821->dev = dev;
 	nau8821->irq = i2c->irq;
+
+	nau8821_check_quirks();
+
+	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+		nau8821->jkdet_polarity = 0;
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);
-- 
2.40.1

