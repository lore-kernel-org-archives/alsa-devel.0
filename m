From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 1/2] ASoC: AMD: Support headset button on
	Stoney DA7219
Date: Fri, 30 Mar 2018 15:34:56 +0530
Message-ID: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0044.outbound.protection.outlook.com [104.47.34.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B273B2671E9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 12:05:18 +0200 (CEST)
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

Adds headset button support.

TEST=Tested Volume UP/Down functionality

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..d9491e1 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/acpi.h>
 
 #include "../codecs/da7219.h"
@@ -51,6 +52,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_jack *jack;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
 
@@ -80,6 +82,12 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &cz_jack;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(component, &cz_jack);
 
 	return 0;
-- 
1.9.1
