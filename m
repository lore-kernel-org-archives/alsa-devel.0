From: jeeja.kp@intel.com
Subject: [PATCH 10/16] ASoC: Intel: bxt: Create ASoC jack for
	hdmi in bxt_da7219_max98357 machine
Date: Tue,  7 Feb 2017 19:09:54 +0530
Message-ID: <1486474800-11426-11-git-send-email-jeeja.kp@intel.com>
References: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 546FA26707B
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:29:01 +0100 (CET)
In-Reply-To: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
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

Creates ASoC jack for HDMI PCM and calls hdmi codec API to initialize
jack in bxt_da7219_max98357 machine

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index a9647a2..18f3d0e 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -33,6 +33,7 @@
 #define QUAD_CHANNEL		4
 
 static struct snd_soc_jack broxton_headset;
+static struct snd_soc_jack broxton_hdmi[3];
 
 struct bxt_hdmi_pcm {
 	struct list_head head;
@@ -517,16 +518,30 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	},
 };
 
+#define NAME_SIZE	32
 static int bxt_card_late_probe(struct snd_soc_card *card)
 {
 	struct bxt_card_private *ctx = snd_soc_card_get_drvdata(card);
 	struct bxt_hdmi_pcm *pcm;
-	int err;
+	int err, i = 0;
+	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
+		err = snd_soc_card_jack_new(card, jack_name,
+					SND_JACK_AVOUT, &broxton_hdmi[i],
+					NULL, 0);
+
+		if (err)
+			return err;
+
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+						&broxton_hdmi[i]);
 		if (err < 0)
 			return err;
+
+		i++;
 	}
 
 	return 0;
-- 
2.5.0
