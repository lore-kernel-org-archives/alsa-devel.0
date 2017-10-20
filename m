From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 5/5] ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt
Date: Fri, 20 Oct 2017 12:18:59 +0100
Message-ID: <20171020111859.2448-6-carlo@caione.org>
References: <20171020111859.2448-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020111859.2448-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

The KIANO SlimNote 14.2 laptop uses the JD1_1 input pin for jack
detection. Set the correct quirk in the codec driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/codecs/rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f01d41101631..831b297978a4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1753,6 +1753,14 @@ static int rt5651_quirk_cb(const struct dmi_system_id *id)
 }
 
 static const struct dmi_system_id rt5651_quirk_table[] = {
+	{
+		.callback = rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
+		},
+		.driver_data = (unsigned long *) RT5651_JD1_1,
+	},
 	{}
 };
 
-- 
2.14.2
