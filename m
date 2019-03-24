From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] sound: codecs: fix a missing check for regmap_update_bits
Date: Sun, 24 Mar 2019 18:25:53 -0500
Message-ID: <20190324232553.10020-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

regmap_update_bits could fail. The fix checks its status and if
it fails, returns its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/codecs/cs35l34.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 5063c05afa27..a456b1ac9019 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -262,6 +262,8 @@ static int cs35l34_sdin_event(struct snd_soc_dapm_widget *w,
 		}
 		ret = regmap_update_bits(priv->regmap, CS35L34_PWRCTL1,
 					CS35L34_PDN_ALL, CS35L34_PDN_ALL);
+		if (ret < 0)
+			return ret;
 	break;
 	default:
 		pr_err("Invalid event = 0x%x\n", event);
-- 
2.17.1
