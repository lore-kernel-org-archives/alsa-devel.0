From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: Intel: Headset button support in
	kabylake machine driver
Date: Mon, 21 Aug 2017 12:26:52 -0700
Message-ID: <1503343612-15606-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 31651266C78
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 21:27:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Hsin-yu Chao <hychao@google.com>
List-Id: alsa-devel@alsa-project.org

This patch adds headset button support for kabylake machine driver
(kbl_rt5663_rt5514_max98927).

Signed-off-by: Hsin-yu Chao <hychao@google.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 441a397..b350aa7 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -18,6 +18,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -174,6 +175,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * Headset buttons map to the google Reference headset.
@@ -188,6 +190,12 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &ctx->kabylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
 	rt5663_set_jack_detect(codec, &ctx->kabylake_headset);
 
 	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "DMIC");
-- 
1.9.1
