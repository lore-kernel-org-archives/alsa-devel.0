From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: Headset button support in
	broxton machine driver
Date: Wed,  4 Apr 2018 10:16:56 +0530
Message-ID: <1522817219-3750-3-git-send-email-naveen.m@intel.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DB40267627
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 06:47:43 +0200 (CEST)
In-Reply-To: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Patch adds headset button support for broxton machine driver
(bxt_da7219_max98357a).

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index ce021a3..1c1e70c 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -168,6 +169,7 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
+	struct snd_soc_jack *jack;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_component *component = rtd->codec_dai->component;
 
@@ -192,7 +194,12 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_aad_jack_det(component, &broxton_headset);
+	jack = &broxton_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	da7219_aad_jack_det(component, jack);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
 
-- 
2.7.4
