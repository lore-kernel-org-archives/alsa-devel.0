From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ASoC: Intel: bytcr_rt5640: Fix Acer Iconia
	8 over-current detect threshold
Date: Sun,  3 Jun 2018 15:42:32 +0200
Message-ID: <20180603134232.677-2-hdegoede@redhat.com>
References: <20180603134232.677-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 317BE267A69
 for <alsa-devel@alsa-project.org>; Sun,  3 Jun 2018 15:42:40 +0200 (CEST)
In-Reply-To: <20180603134232.677-1-hdegoede@redhat.com>
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

Change the over-current detect threshold on the Acer Iconia 8 from
2000ua to 1500uA, this fixes headset button presses not being detected.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 27a05778584f..e577ace1c1d8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -404,7 +404,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_JD_SRC_JD1_IN4P |
-					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_TH_1500UA |
 					BYT_RT5640_OVCD_SF_0P75 |
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
-- 
2.17.1
