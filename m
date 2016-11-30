From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: rt5670: Add missing 10EC5072 ACPI ID
Date: Wed, 30 Nov 2016 14:55:29 +0100
Message-ID: <20161130135529.22163-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A4A4266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 14:55:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

rt5670 driver supports also RT5672 codec, but its ACPI ID is missing.
This was found on Dell Wyse 3040 box.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt5670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 12d3bc14a558..98c7efbc6ee0 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2813,6 +2813,7 @@ MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5670_acpi_match[] = {
 	{ "10EC5670", 0},
+	{ "10EC5672", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5670_acpi_match);
-- 
2.10.2
