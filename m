From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: codecs: Allow user to select WM9713 codec
Date: Sat, 18 Jun 2016 20:04:08 +0300
Message-ID: <1466269448-8445-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [94.100.177.103])
 by alsa0.perex.cz (Postfix) with ESMTP id C713A261A06
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2016 19:04:21 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Add simple description and necessary options to allow to select
Wolfson WM9713 codec.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d82a58..6721427 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1010,8 +1010,9 @@ config SND_SOC_WM9712
 	tristate
 
 config SND_SOC_WM9713
-	tristate
+	tristate "Wolfson Microelectronics WM9713 codec"
 	select REGMAP_AC97
+	select SND_SOC_AC97_BUS
 
 # Amp
 config SND_SOC_LM4857
-- 
2.4.9
