From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: topology: kfree kcontrol->private_value before freeing kcontrol
Date: Fri,  9 Dec 2016 14:17:47 +0000
Message-ID: <20161209141747.4776-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

kcontrol->private_value is being kfree'd after kcontrol has been freed
(in previous call to snd_ctl_remove).  Instead, fix this by kfreeing
the private_value before kcontrol.

CoverityScan CID#1388311 "Read from pointer after free"

Fixes: eea3dd4f1247a ("ASoC: topology: Only free TLV for volume mixers of a widget")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 11feb19..b5472e0 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -514,13 +514,12 @@ static void remove_widget(struct snd_soc_component *comp,
 			    == SND_SOC_TPLG_TYPE_MIXER)
 				kfree(kcontrol->tlv.p);
 
-			snd_ctl_remove(card, kcontrol);
-
 			/* Private value is used as struct soc_mixer_control
 			 * for volume mixers or soc_bytes_ext for bytes
 			 * controls.
 			 */
 			kfree((void *)kcontrol->private_value);
+			snd_ctl_remove(card, kcontrol);
 		}
 		kfree(w->kcontrol_news);
 	}
-- 
2.10.2
