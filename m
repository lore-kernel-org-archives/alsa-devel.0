From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: fix SND_SOC_LOCHNAGAR_SC kconfig warning
Date: Wed, 27 Mar 2019 08:43:19 -0700
Message-ID: <fb9f38e4-c4c9-400e-fb16-fa2714eb8d00@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Piotr Stankiewicz <piotrs@opensource.cirrus.co>, Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for SND_SOC_LOCHNAGAR_SC:

WARNING: unmet direct dependencies detected for SND_SOC_LOCHNAGAR_SC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && MFD_LOCHNAGAR [=n]
  Selected by [m]:
  - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && COMPILE_TEST [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190327.orig/sound/soc/codecs/Kconfig
+++ linux-next-20190327/sound/soc/codecs/Kconfig
@@ -94,7 +94,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_JZ4725B_CODEC
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_LM49453 if I2C
-	select SND_SOC_LOCHNAGAR_SC
+	select SND_SOC_LOCHNAGAR_SC if MFD_LOCHNAGAR
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
