From: kernel@martin.sperl.org
Subject: [PATCH V2] ASoC: bcm2835: Register as custom PCM
	device to enable 16bit pcm
Date: Tue, 26 Apr 2016 08:35:23 +0000
Message-ID: <1461659723-5382-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cgate.sperl.org (212-186-180-163.dynamic.surfer.at
 [212.186.180.163])
 by alsa0.perex.cz (Postfix) with ESMTP id D1DEA2604BE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 10:35:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org

From: Matthias Reichl <hias@horus.com>

Register as a custom pcm device with the correct settings supporting
also 16 bit.

The automatic pcm discovery does not enable 16 bit modes because
of a percived mismatch between the dma controller only
supporting 32 bit transfers and the requirement by the HW to only
support exactly 2 channels, which effectively results in a minimum
size of 32 bits, which matches the dma controller transfer width.

Code ported from bcm2708-i2s driver in Raspberry Pi tree.

Signed-off-by: Florian Meier <florian.meier@koalo.de>
Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: use of SZ_* defines instead of multiple of page size
            better description of commit message
---
 sound/soc/bcm/bcm2835-i2s.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index a0026e2..66680f1 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -632,6 +632,27 @@ static const struct snd_soc_component_driver bcm2835_i2s_component = {
 	.name		= "bcm2835-i2s-comp",
 };
 
+static const struct snd_pcm_hardware bcm2835_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_JOINT_DUPLEX |
+				  SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
+				  SNDRV_PCM_FMTBIT_S24_LE |
+				  SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= SZ_256K,
+	.periods_min		= 2,
+	.periods_max		= 255,
+	.buffer_bytes_max	= SZ_512K,
+};
+
+static const struct snd_dmaengine_pcm_config bcm2835_dmaengine_pcm_config = {
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.pcm_hardware = &bcm2835_pcm_hardware,
+	.prealloc_buffer_size = SZ_1M,
+};
+
 static int bcm2835_i2s_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2s_dev *dev;
@@ -704,7 +725,9 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(
+		&pdev->dev, &bcm2835_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
 		return ret;
-- 
2.1.4
