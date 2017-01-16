From: jeeja.kp@intel.com
Subject: [PATCH 19/30] ASoC: Intel: Skylake: Create ASoC jack
	for hdmi in rt286 machine
Date: Mon, 16 Jan 2017 23:27:46 +0530
Message-ID: <1484589477-7630-20-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 221342668B3
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:48:11 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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

Creates ASoC jack for HDMI pcm and calls hdmi codec API to initialize
jack in skl_rt268 machine

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 5e56af3..11647b0 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -29,6 +29,7 @@
 #include "../../codecs/hdac_hdmi.h"
 
 static struct snd_soc_jack skylake_headset;
+static struct snd_soc_jack skylake_hdmi[3];
 
 struct skl_hdmi_pcm {
 	struct list_head head;
@@ -458,16 +459,30 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 };
 
+#define NAME_SIZE	32
 static int skylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct skl_rt286_private *ctx = snd_soc_card_get_drvdata(card);
 	struct skl_hdmi_pcm *pcm;
-	int err;
+	int err, i = 0;
+	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
+		err = snd_soc_card_jack_new(card, jack_name,
+					SND_JACK_AVOUT, &skylake_hdmi[i],
+					NULL, 0);
+
+		if (err)
+			return err;
+
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+						&skylake_hdmi[i]);
 		if (err < 0)
 			return err;
+
+		i++;
 	}
 
 	return 0;
-- 
2.5.0
