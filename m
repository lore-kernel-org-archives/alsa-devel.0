From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/6] ASoC: Intel: bytcr_rt5651: Add quirk table
	entries for various devices
Date: Wed, 18 Jul 2018 22:55:42 +0200
Message-ID: <20180718205542.12364-7-hdegoede@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id B30A1267846
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:54 +0200 (CEST)
In-Reply-To: <20180718205542.12364-1-hdegoede@redhat.com>
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
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add quirk table entries for the following tablets:

ITWorks TW701
Ployer Momo7w
Trekstor win7
Yours 8"

These all use the default settings, except that they only have a single
speaker and thus need the mono-speaker quirk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8374e633796d..f8a68bdb3885 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -392,6 +392,21 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_HP_LR_SWAPPED |
 					BYT_RT5651_MONO_SPEAKER),
 	},
+	{
+		/* I.T.Works TW701, Ployer Momo7w and Trekstor ST70416-6
+		 * (these all use the same mainboard) */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "INSYDE Corp."),
+			/* Partial match for all of itWORKS.G.WI71C.JGBMRBA,
+			 * TREK.G.WI71C.JGBMRBA0x and MOMO.G.WI71C.MABMRBA02 */
+			DMI_MATCH(DMI_BIOS_VERSION, ".G.WI71C."),
+		},
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN2_MAP |
+					BYT_RT5651_SSP0_AIF1 |
+					BYT_RT5651_MONO_SPEAKER),
+	},
 	{
 		/* KIANO SlimNote 14.2 */
 		.callback = byt_rt5651_quirk_cb,
@@ -434,6 +449,19 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_OVCD_SF_1P0 |
 					BYT_RT5651_MCLK_EN),
 	},
+	{
+		/* Yours Y8W81 (and others using the same mainboard) */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "INSYDE Corp."),
+			/* Partial match for all devs with a W86C mainboard */
+			DMI_MATCH(DMI_BIOS_VERSION, ".F.W86C."),
+		},
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN2_MAP |
+					BYT_RT5651_SSP0_AIF1 |
+					BYT_RT5651_MONO_SPEAKER),
+	},
 	{}
 };
 
-- 
2.17.1
