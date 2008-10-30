From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Fix some minor errors in mpc5200 psc
	i2s driver
Date: Thu, 30 Oct 2008 12:37:09 +0000
Message-ID: <1225370230-7829-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030123649.GA7682@rakim.wolfsonmicro.main>
	<1225370230-7829-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6257E243C8
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 13:37:11 +0100 (CET)
In-Reply-To: <1225370230-7829-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Jon Smirl <jonsmirl@gmail.com>

Fix missing unsigned for irqsave flags in psc i2s driver
Make attribute visiblity static
Collect all sysfs errors before checking status

[Word wrapped DEVICE_ATTR() lines for 80 columns -- broonie]

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 8692329..94a02ea 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -277,7 +277,7 @@ static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct mpc52xx_psc __iomem *regs = psc_i2s->psc_regs;
 	u16 imr;
 	u8 psc_cmd;
-	long flags;
+	unsigned long flags;
 
 	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
 		s = &psc_i2s->capture;
@@ -699,9 +699,11 @@ static ssize_t psc_i2s_stat_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
-DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
-DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
+static DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
+static DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show,
+			psc_i2s_stat_store);
+static DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show,
+			psc_i2s_stat_store);
 
 /* ---------------------------------------------------------------------
  * OF platform bus binding code:
@@ -819,8 +821,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 
 	/* Register the SYSFS files */
 	rc = device_create_file(psc_i2s->dev, &dev_attr_status);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
 	if (rc)
 		dev_info(psc_i2s->dev, "error creating sysfs files\n");
 
-- 
1.5.6.5
