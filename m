From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/6] ASoC: Intel: bytcr_rt5651: Set OVCD limit
	for VIOS LTH17 to 2000uA
Date: Wed, 18 Jul 2018 22:55:39 +0200
Message-ID: <20180718205542.12364-4-hdegoede@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 992CB267822
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:50 +0200 (CEST)
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

With the default over current detect limit of 1500uA headsets on often
get detected as headphones on the VIOS LTH17 and even when detected as
headset the OVCD current triggers often while plugged in, resulting in
false-positive button press detection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 601e47c33ba8..53ac97c15fc6 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -414,8 +414,11 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_IN2_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_1P0 |
+					BYT_RT5651_MCLK_EN),
 	},
 	{}
 };
-- 
2.17.1
