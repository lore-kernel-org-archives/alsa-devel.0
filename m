From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: Samsung: Fix build on multiplatform
Date: Thu, 27 Mar 2014 13:29:57 +0530
Message-ID: <1395907197-12637-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 039372651D3
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 09:00:08 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id md12so3116096pbc.21
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 01:00:07 -0700 (PDT)
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
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

PCM and S/PDIF drivers referenced mach headers for a trivial
data structure. This caused build errors on multiplatform builds
as machine headers are not accessible from driver files. Move the data
structure definition to the driver header and remove the dependency.
While at it rename the structure to avoid multiple definition errors
as the same structure is also used by the platform code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/ac97.c        |    6 +++---
 sound/soc/samsung/dma.h         |    6 +++++-
 sound/soc/samsung/i2s.c         |    6 +++---
 sound/soc/samsung/pcm.c         |    5 ++---
 sound/soc/samsung/s3c2412-i2s.c |    4 ++--
 sound/soc/samsung/s3c24xx-i2s.c |    4 ++--
 sound/soc/samsung/spdif.c       |    3 +--
 7 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 4a88e36c82ec..76b072bd4ba2 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -39,15 +39,15 @@ struct s3c_ac97_info {
 };
 static struct s3c_ac97_info s3c_ac97;
 
-static struct s3c2410_dma_client s3c_dma_client_out = {
+static struct s3c_dma_client s3c_dma_client_out = {
 	.name = "AC97 PCMOut"
 };
 
-static struct s3c2410_dma_client s3c_dma_client_in = {
+static struct s3c_dma_client s3c_dma_client_in = {
 	.name = "AC97 PCMIn"
 };
 
-static struct s3c2410_dma_client s3c_dma_client_micin = {
+static struct s3c_dma_client s3c_dma_client_micin = {
 	.name = "AC97 MicIn"
 };
 
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 225e5378014e..ad7c0f04f00d 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -14,8 +14,12 @@
 
 #include <sound/dmaengine_pcm.h>
 
+struct s3c_dma_client {
+	char *name;
+};
+
 struct s3c_dma_params {
-	struct s3c2410_dma_client *client;	/* stream identifier */
+	struct s3c_dma_client *client;	/* stream identifier */
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
 	int dma_size;			/* Size of the DMA transfer */
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0a9b44c940ce..048ead967199 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1211,10 +1211,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
 	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
 	pri_dai->dma_playback.client =
-		(struct s3c2410_dma_client *)&pri_dai->dma_playback;
+		(struct s3c_dma_client *)&pri_dai->dma_playback;
 	pri_dai->dma_playback.ch_name = "tx";
 	pri_dai->dma_capture.client =
-		(struct s3c2410_dma_client *)&pri_dai->dma_capture;
+		(struct s3c_dma_client *)&pri_dai->dma_capture;
 	pri_dai->dma_capture.ch_name = "rx";
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
@@ -1233,7 +1233,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.client =
-			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
+			(struct s3c_dma_client *)&sec_dai->dma_playback;
 		sec_dai->dma_playback.ch_name = "tx-sec";
 
 		if (!np) {
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 6a5e4bf6ac96..ab54e297957c 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -20,7 +20,6 @@
 #include <sound/pcm_params.h>
 
 #include <linux/platform_data/asoc-s3c.h>
-#include <mach/dma.h>
 
 #include "dma.h"
 #include "pcm.h"
@@ -132,11 +131,11 @@ struct s3c_pcm_info {
 	struct s3c_dma_params	*dma_capture;
 };
 
-static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
+static struct s3c_dma_client s3c_pcm_dma_client_out = {
 	.name		= "PCM Stereo out"
 };
 
-static struct s3c2410_dma_client s3c_pcm_dma_client_in = {
+static struct s3c_dma_client s3c_pcm_dma_client_in = {
 	.name		= "PCM Stereo in"
 };
 
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index d0794458963a..e9bb5d7a71ee 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -33,11 +33,11 @@
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
-static struct s3c2410_dma_client s3c2412_dma_client_out = {
+static struct s3c_dma_client s3c2412_dma_client_out = {
 	.name		= "I2S PCM Stereo out"
 };
 
-static struct s3c2410_dma_client s3c2412_dma_client_in = {
+static struct s3c_dma_client s3c2412_dma_client_in = {
 	.name		= "I2S PCM Stereo in"
 };
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index f31e916dd8c4..d7b8457b5650 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -31,11 +31,11 @@
 #include "dma.h"
 #include "s3c24xx-i2s.h"
 
-static struct s3c2410_dma_client s3c24xx_dma_client_out = {
+static struct s3c_dma_client s3c24xx_dma_client_out = {
 	.name = "I2S PCM Stereo out"
 };
 
-static struct s3c2410_dma_client s3c24xx_dma_client_in = {
+static struct s3c_dma_client s3c24xx_dma_client_in = {
 	.name = "I2S PCM Stereo in"
 };
 
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 28487dcc4538..cfe63b7bcc9f 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -18,7 +18,6 @@
 #include <sound/pcm_params.h>
 
 #include <linux/platform_data/asoc-s3c.h>
-#include <mach/dma.h>
 
 #include "dma.h"
 #include "spdif.h"
@@ -94,7 +93,7 @@ struct samsung_spdif_info {
 	struct s3c_dma_params	*dma_playback;
 };
 
-static struct s3c2410_dma_client spdif_dma_client_out = {
+static struct s3c_dma_client spdif_dma_client_out = {
 	.name		= "S/PDIF Stereo out",
 };
 
-- 
1.7.9.5
