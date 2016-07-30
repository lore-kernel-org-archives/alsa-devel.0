From: Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH] sound: Fix empty menuconfig SND_ARM
Date: Sat, 30 Jul 2016 16:00:19 +0200
Message-ID: <20160730140019.20305-1-rosca.eugeniu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DB02652C3
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 16:00:58 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i5so19491877wmg.2
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 07:00:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, robert.jarzmik@free.fr, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: alsa-devel@alsa-project.org

commit 3c8f7710c1c4 ("ASoC: fix broken pxa SoC support") has removed
the SND_ARM dependency from SND_PXA2XX_LIB and SND_PXA2XX_LIB_AC97,
by moving these config entries outside of the "if SND_ARM ... endif"
construct.

However, by placing these 2 symbols right between the SND_ARM
menuconfig definition and the first SND_ARM menu entry, the side
effect is that the SND_ARM menu becomes empty and all the config
entries caught between "if SND_ARM ... endif" no more belong to
menuconfig SND_ARM, but to its parent (menuconfig SND).

Fix this.

Signed-off-by: Eugeniu Rosca <rosca.eugeniu@gmail.com>
---
 sound/arm/Kconfig | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index e040621..65171f6 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -9,14 +9,6 @@ menuconfig SND_ARM
 	  Drivers that are implemented on ASoC can be found in
 	  "ALSA for SoC audio support" section.
 
-config SND_PXA2XX_LIB
-	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
-	select SND_DMAENGINE_PCM
-
-config SND_PXA2XX_LIB_AC97
-	bool
-
 if SND_ARM
 
 config SND_ARMAACI
@@ -42,3 +34,10 @@ config SND_PXA2XX_AC97
 
 endif	# SND_ARM
 
+config SND_PXA2XX_LIB
+	tristate
+	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
+	select SND_DMAENGINE_PCM
+
+config SND_PXA2XX_LIB_AC97
+	bool
-- 
2.9.2
