From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: add "coreboot" to dmi_system_id
	list
Date: Mon, 1 Feb 2016 13:21:18 +0800
Message-ID: <1454304078-12322-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1643F26062C
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 06:21:32 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There are some Google projects with manufacturer name different
from "GOOGLE". So we need to add DMI list for those projects.
However some OEMs / vendors want to keep secret before product launch.
So, we can't use DMI_SYS_VENDOR for them. Fortunately, the BIOS vendor
field is the same for all chrome os projects. It allows us to match
chrome projects by DMI_BIOS_VENDOR = "coreboot".

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 93e8c90..8521b22 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3552,6 +3552,12 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 		},
 	},
+	{
+		.ident = "Google Chrome",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		},
+	},
 	{ }
 };
 
-- 
1.8.1.1.439.g50a6b54
