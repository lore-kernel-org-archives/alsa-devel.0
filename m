From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add dmi_system_id "Google Setzer"
Date: Mon, 15 Feb 2016 10:40:17 +0800
Message-ID: <1455504017-4194-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 49ECE2605B4
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 03:40:30 +0100 (CET)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add platform specific data for Setzer project.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 93e8c90..75e5a4a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3552,6 +3552,12 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 		},
 	},
+	{
+		.ident = "Google Setzer",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
+		},
+	},
 	{ }
 };
 
-- 
1.8.1.1.439.g50a6b54
