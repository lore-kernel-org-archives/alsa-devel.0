From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: rt5670: Enable Braswell platform
	workaround for Dell Wyse 3040
Date: Wed, 30 Nov 2016 17:19:20 +0100
Message-ID: <20161130161920.10817-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC68D266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 17:19:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Dell Wyse 3040 requires the platform workaround for enabling dmic and
jack detection as defined for Braswell CRB.

Signed-off-by: Takashi Iwai <tiwai@suse.de>

---

I guess the platform data should be applied generically to all CHT
machines instead of DMI matching?  DMI matching doesn't scale,
obviously.

 sound/soc/codecs/rt5670.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 98c7efbc6ee0..97bafac3bc15 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2827,6 +2827,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Braswell CRB"),
 		},
 	},
+	{
+		.ident = "Dell Wyse 3040",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Wyse 3040"),
+		},
+	},
 	{}
 };
 
-- 
2.10.2
