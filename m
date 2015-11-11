From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add struct dmi_system_id "Google
	Edgar" for Chrome OS
Date: Wed, 11 Nov 2015 15:25:28 +0800
Message-ID: <1447226728-14648-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B7AB12604A1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 08:25:42 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, Eric_Lai@pegatroncorp.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add platform specific data for Edgar project.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 672fafd..d567b71 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3378,6 +3378,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Reks"),
 		},
 	},
+	{
+		.ident = "Google Edgar",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Edgar"),
+		},
+	},
 	{ }
 };
 
-- 
1.8.1.1.439.g50a6b54
