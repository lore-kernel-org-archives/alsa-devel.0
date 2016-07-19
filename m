From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/2] ASoC: cs53l30: Fix a bug for TDM slot location validation
Date: Tue, 19 Jul 2016 15:36:13 -0700
Message-ID: <1468967774-18621-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The maximum slot number of CS53L30 is 4 while it should support
the situation that's less than 4 channels based on the rx_mask.

So when the driver validates the last slot location, it should
check the last active slot instead of always the 4th one.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 5988b5c..fd5502e 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -809,8 +809,8 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	/* Validate the last CS53L30 slot */
-	slot_next = loc[CS53L30_TDM_SLOT_MAX - 1] + slot_step - 1;
+	/* Validate the last active CS53L30 slot */
+	slot_next = loc[i - 1] + slot_step - 1;
 	if (slot_next > 47) {
 		dev_err(dai->dev, "slot selection out of bounds: %u\n",
 			slot_next);
-- 
2.1.4
