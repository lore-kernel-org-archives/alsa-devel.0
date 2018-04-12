From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [v3] ASoC: AMD: Support headset button on Stoney DA7219
Date: Thu, 12 Apr 2018 17:57:11 +0800
Message-ID: <1523527031-6132-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0069.outbound.protection.outlook.com [104.47.33.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 705C3266FD1
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 11:58:03 +0200 (CEST)
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

TEST=Tested Volume UP/Down, Play/Pause functionality

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Changed KEY_MEDIA to KEY_PLAYPAUSE
v3: Using cz_jack.jack instead of jack->jack

 sound/soc/amd/acp-da7219-max98357a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..d281c22 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/acpi.h>
 
 #include "../codecs/da7219.h"
@@ -80,6 +81,11 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(component, &cz_jack);
 
 	return 0;
-- 
1.9.1
