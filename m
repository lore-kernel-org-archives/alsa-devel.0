From: jeeja.kp@intel.com
Subject: [PATCH v2] ASoC: Intel: bxt: Add jack port initialize
	in bxt_rt298 machine
Date: Fri, 17 Feb 2017 15:04:46 +0530
Message-ID: <1487324086-17469-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 57E302668B2
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 10:23:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

After the pcm jack is created, create and initialize the pin switch
widget for each port. Pin switch is to enable/disable the pin when
monitor is connected/disconnected.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
Change in v2:
	Add the SOB.

 sound/soc/intel/boards/bxt_rt298.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index d5f53a6..176c080 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -459,10 +459,12 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 {
 	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(card);
 	struct bxt_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -480,7 +482,10 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 
-- 
2.5.0
