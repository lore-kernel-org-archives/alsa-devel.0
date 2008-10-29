From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Fix some minor errors in mpc5200 psc i2s driver
Date: Wed, 29 Oct 2008 17:22:03 -0400
Message-ID: <20081029212203.6940.61993.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 09CA824416
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 22:22:06 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id d31so26870and.80
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 14:22:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, grant.likely@secretlab.ca
List-Id: alsa-devel@alsa-project.org

Fix missing unsigned for irqsave flags in psc i2s driver
Make attribute visiblity static
Collect all sysfs errors before checking status

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 8692329..809c5c4 100644
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
@@ -699,9 +699,9 @@ static ssize_t psc_i2s_stat_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
-DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
-DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
+static DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
+static DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
+static DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
 
 /* ---------------------------------------------------------------------
  * OF platform bus binding code:
@@ -819,8 +819,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 
 	/* Register the SYSFS files */
 	rc = device_create_file(psc_i2s->dev, &dev_attr_status);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
 	if (rc)
 		dev_info(psc_i2s->dev, "error creating sysfs files\n");
