From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 2/7 linux-next] ASoC: fsl: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:57 +0100
Message-ID: <1426697344-4884-3-git-send-email-fabf@skynet.be>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/soc/fsl/mpc5200_psc_ac97.c    | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c     | 2 +-
 sound/soc/fsl/pcm030-audio-fabric.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 08d2a80..0bab760 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -326,7 +326,7 @@ static int psc_ac97_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id psc_ac97_match[] = {
+static const struct of_device_id psc_ac97_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-ac97", },
 	{ .compatible = "fsl,mpc5200b-psc-ac97", },
 	{}
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 51fb0c0..d823294 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -217,7 +217,7 @@ static int psc_i2s_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id psc_i2s_match[] = {
+static const struct of_device_id psc_i2s_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-i2s", },
 	{ .compatible = "fsl,mpc5200b-psc-i2s", },
 	{}
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index c44459d..ec73122 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -113,7 +113,7 @@ static int pcm030_fabric_remove(struct platform_device *op)
 	return ret;
 }
 
-static struct of_device_id pcm030_audio_match[] = {
+static const struct of_device_id pcm030_audio_match[] = {
 	{ .compatible = "phytec,pcm030-audio-fabric", },
 	{}
 };
-- 
1.9.1
