From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 02/10] ASoC: Intel: bytcr_rt5640: Fix Dell
	Venue 8 5830 Pro quirk
Date: Fri, 11 May 2018 15:29:20 +0200
Message-ID: <20180511132928.7669-3-hdegoede@redhat.com>
References: <20180511132928.7669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AAA42677CF
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 15:29:35 +0200 (CEST)
In-Reply-To: <20180511132928.7669-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This fixes the following 3 issues:

1) The sys_vendor match should be for "Dell Inc." not "DellInc.",
   without this fixed the quirk never gets applied
2) DMIC1 is used not DMIC2, this was not a problem sofar because for
   regular BYT boards (rather then BYTCR) we default to DMIC1 and because
   of 1. the quirk was not being applied
3) The Dell Venue 8 5830 Pro only has a single speaker

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c21cbb06d32e..b5972b7512d5 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -370,10 +370,11 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
-		.driver_data = (void *)(BYT_RT5640_DMIC2_MAP |
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_MONO_SPEAKER |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-- 
2.17.0
