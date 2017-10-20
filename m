From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 3/5] ASoC: intel: byt: Enable IN2 map quirk for a KIANO laptop
Date: Fri, 20 Oct 2017 12:18:57 +0100
Message-ID: <20171020111859.2448-4-carlo@caione.org>
References: <20171020111859.2448-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020111859.2448-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

This cherry-trails laptop has the internal mic connected to the IN2
input pins. Enable the quirk to correctly map the routes.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 5aca55baccda..c7494f88ab81 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -250,6 +250,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5651_DMIC_MAP |
 					BYT_RT5651_DMIC_EN),
 	},
+	{
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
+		},
+		.driver_data = (void *)(BYT_RT5651_IN2_MAP),
+	},
 	{}
 };
 
-- 
2.14.2
