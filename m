From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Remove needless inclusion of
	tlv320aic3x.h from machine drivers
Date: Wed,  5 Jan 2011 12:05:44 +0200
Message-ID: <1294221944-6400-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C212F1038B3
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 11:05:24 +0100 (CET)
Received: by ewy19 with SMTP id 19so6261249ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 02:05:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

After multi-component conversion these machine drivers don't actually need
anything from sound/soc/codecs/tlv320aic3x.h so don't include it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
rx51.c and n810.c compile tested but these other machine drivers seems to not
use anything from tlv320aic3x.h either so should be safe to remove.
---
 sound/soc/davinci/davinci-evm.c           |    1 -
 sound/soc/omap/n810.c                     |    1 -
 sound/soc/omap/rx51.c                     |    1 -
 sound/soc/s6000/s6105-ipcam.c             |    1 -
 sound/soc/samsung/s3c24xx_simtec_hermes.c |    2 --
 5 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 24b031e..0c2d6ba 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -26,7 +26,6 @@
 #include <mach/edma.h>
 #include <mach/mux.h>
 
-#include "../codecs/tlv320aic3x.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 #include "davinci-mcasp.h"
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index fe215f3..83d213b 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -35,7 +35,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/tlv320aic3x.h"
 
 #define N810_HEADSET_AMP_GPIO	10
 #define N810_SPEAKER_AMP_GPIO	101
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 150042a..09fb0df 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -36,7 +36,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/tlv320aic3x.h"
 
 #define RX51_TVOUT_SEL_GPIO		40
 #define RX51_JACK_DETECT_GPIO		177
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index bf3f3f9..5890e43 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -21,7 +21,6 @@
 
 #include <variant/dmac.h>
 
-#include "../codecs/tlv320aic3x.h"
 #include "s6000-pcm.h"
 #include "s6000-i2s.h"
 
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index 0083aff..bb4292e 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -21,8 +21,6 @@
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
-#include "../codecs/tlv320aic3x.h"
-
 static const struct snd_soc_dapm_widget dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("GSM Out", NULL),
 	SND_SOC_DAPM_LINE("GSM In", NULL),
-- 
1.7.2.3
