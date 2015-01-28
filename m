From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH v2 2/7] ASoC: pcm512x: Fix spelling of register
	field names.
Date: Wed, 28 Jan 2015 15:16:07 +0100
Message-ID: <1422454572-7847-3-git-send-email-peda@lysator.liu.se>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 465A9261B02
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:16:51 +0100 (CET)
In-Reply-To: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/pcm512x.c |    2 +-
 sound/soc/codecs/pcm512x.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index e5f2fb884bf3..874723c36d65 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -277,7 +277,7 @@ SOC_ENUM("Auto Mute Time Right", pcm512x_autom_r),
 SOC_SINGLE("Auto Mute Mono Switch", PCM512x_DIGITAL_MUTE_3,
 	   PCM512x_ACTL_SHIFT, 1, 0),
 SOC_DOUBLE("Auto Mute Switch", PCM512x_DIGITAL_MUTE_3, PCM512x_AMLE_SHIFT,
-	   PCM512x_AMLR_SHIFT, 1, 0),
+	   PCM512x_AMRE_SHIFT, 1, 0),
 
 SOC_ENUM("Volume Ramp Down Rate", pcm512x_vndf),
 SOC_ENUM("Volume Ramp Down Step", pcm512x_vnds),
diff --git a/sound/soc/codecs/pcm512x.h b/sound/soc/codecs/pcm512x.h
index 6ee76aaca09a..28b3dfd302bc 100644
--- a/sound/soc/codecs/pcm512x.h
+++ b/sound/soc/codecs/pcm512x.h
@@ -108,8 +108,8 @@
 #define PCM512x_RQML_SHIFT 4
 
 /* Page 0, Register 4 - PLL */
-#define PCM512x_PLCE       (1 << 0)
-#define PCM512x_RLCE_SHIFT 0
+#define PCM512x_PLLE       (1 << 0)
+#define PCM512x_PLLE_SHIFT 0
 #define PCM512x_PLCK       (1 << 4)
 #define PCM512x_PLCK_SHIFT 4
 
@@ -152,7 +152,7 @@
 /* Page 0, Register 65 - Digital mute enables */
 #define PCM512x_ACTL_SHIFT 2
 #define PCM512x_AMLE_SHIFT 1
-#define PCM512x_AMLR_SHIFT 0
+#define PCM512x_AMRE_SHIFT 0
 
 /* Page 1, Register 2 - analog volume control */
 #define PCM512x_RAGN_SHIFT 0
-- 
1.7.10.4
