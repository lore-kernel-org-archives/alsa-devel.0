From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for the
	"Connect Tablet 9" tablet
Date: Sun,  1 Jul 2018 11:30:23 +0200
Message-ID: <20180701093023.6872-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CD5E2676A5
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 11:30:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add a quirk for the "Connect Tablet 9" tablet, this tablet has a
mono-speaker. Otherwise it works fine with the defaults.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7456566c5648..718f022b3aa0 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -486,6 +486,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
 	},
+	{	/* Connect Tablet 9 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Connect"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Tablet 9"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-- 
2.17.1
