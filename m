From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ASoC: codecs: remove hidden prompt
Date: Tue, 12 Mar 2013 21:08:38 +0100
Message-ID: <1363118918.3137.143.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Kconfig symbol SND_SOC_OF_SIMPLE got removed in commit
f0fba2ad1b6b53d5360125c41953b7afcd6deff0 ("ASoC: multi-component - ASoC
Multi-Component Support"). But that commit missed one instance. Remove
it now, together with the prompt it has effectively hidden ever since.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Lightly tested (ie, "make menuconfig" still worked).

 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 45b7256..350b864 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -324,7 +324,7 @@ config SND_SOC_TLV320AIC23
 	tristate
 
 config SND_SOC_TLV320AIC26
-	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
+	tristate
 	depends on SPI
 
 config SND_SOC_TLV320AIC32X4
-- 
1.7.11.7
