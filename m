From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add dmi_system_id "Google Terra"
Date: Tue, 24 Nov 2015 10:55:29 +0800
Message-ID: <1448333729-11065-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 610AE265864
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 03:55:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Luke_Yin@asus.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add platform specific data for Terra project.

Signed-off-by: Luke_Yin@asus.com <Luke_Yin@asus.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2c4f06f..7b140cc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3572,6 +3572,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Wizpig"),
 		},
 	},
+	{
+		.ident = "Google Terra",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Terra"),
+		},
+	},
 	{ }
 };
 
-- 
1.8.1.1.439.g50a6b54
