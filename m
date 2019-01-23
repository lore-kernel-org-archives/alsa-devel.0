From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v3 1/3] ASoC: Intel: Headset button support in
	broxton machine driver
Date: Wed, 23 Jan 2019 10:38:35 -0800
Message-ID: <1548268717-32596-2-git-send-email-yong.zhi@intel.com>
References: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 15F322674A8
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 19:44:37 +0100 (CET)
In-Reply-To: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, vkoul@kernel.org, pierre-louis.bossart@linux.intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Map the 4 headset buttons to KEY_PAUSE, KEY_VOLUMEUP,
KEY_VOLUMEDOWN and KEY_VOICECOMMAND.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 6f052fc..0aaaefa 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -192,6 +193,12 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_3,
+			 KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(component, &broxton_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-- 
2.7.4
