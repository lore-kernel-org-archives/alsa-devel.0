From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Make SND_SOC_STI_SAS depend on
	RESET_CONTROLLER
Date: Mon, 31 Aug 2015 08:52:33 +0800
Message-ID: <1440982353.8335.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FFA42604D8
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 02:52:39 +0200 (CEST)
Received: by pacrd3 with SMTP id rd3so3856609pac.3
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 17:52:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

(devm_)reset_control_get function is available only when RESET_CONTROLLER
is set. Make SND_SOC_STI_SAS depend on RESET_CONTROLLER to fix build error
if !RESET_CONTROLLER.

Reported-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..f8e0022 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,7 +106,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STA350 if I2C
 	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
-	select SND_SOC_STI_SAS
+	select SND_SOC_STI_SAS if RESET_CONTROLLER
 	select SND_SOC_TAS2552 if I2C
 	select SND_SOC_TAS5086 if I2C
 	select SND_SOC_TAS571X if I2C
@@ -634,6 +634,7 @@ config SND_SOC_STAC9766
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
+	depends on RESET_CONTROLLER
 
 config SND_SOC_TAS2552
 	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
-- 
1.9.1
