From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: rme32: Improve unlocking of an IRQ
	in two functions
Date: Fri, 17 Nov 2017 22:20:02 +0100
Message-ID: <5aae0bad-92ba-8d01-2379-e2d80ab180b3@users.sourceforge.net>
References: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 36975266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 22:20:10 +0100 (CET)
In-Reply-To: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 21:51:54 +0100

* Add jump targets so that a call of the function "spin_unlock_irq"
  is stored only twice in these function implementations.

* Replace nine calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme32.c | 65 +++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 9e6e0fe3a285..81de4f8f2ca3 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -688,28 +688,24 @@ snd_rme32_playback_hw_params(struct snd_pcm_substream *substream,
 	    (rate = snd_rme32_capture_getrate(rme32, &dummy)) > 0) {
 		/* AutoSync */
 		if ((int)params_rate(params) != rate) {
-			spin_unlock_irq(&rme32->lock);
-			return -EIO;
+			err = -EIO;
+			goto unlock;
 		}
 	} else {
 		err = snd_rme32_playback_setrate(rme32, params_rate(params));
-		if (err < 0) {
-			spin_unlock_irq(&rme32->lock);
-			return err;
-		}
+		if (err < 0)
+			goto unlock;
 	}
 
 	err = snd_rme32_setformat(rme32, params_format(params));
-	if (err < 0) {
-		spin_unlock_irq(&rme32->lock);
-		return err;
-	}
+	if (err < 0)
+		goto unlock;
 
 	snd_rme32_setframelog(rme32, params_channels(params), 1);
 	if (rme32->capture_periodsize != 0) {
 		if (params_period_size(params) << rme32->playback_frlog != rme32->capture_periodsize) {
-			spin_unlock_irq(&rme32->lock);
-			return -EBUSY;
+			err = -EBUSY;
+			goto unlock;
 		}
 	}
 	rme32->playback_periodsize = params_period_size(params) << rme32->playback_frlog;
@@ -722,6 +718,10 @@ snd_rme32_playback_hw_params(struct snd_pcm_substream *substream,
 	spin_unlock_irq(&rme32->lock);
 
 	return 0;
+
+unlock:
+	spin_unlock_irq(&rme32->lock);
+	return err;
 }
 
 static int
@@ -749,27 +749,20 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
 
 	err = snd_rme32_setformat(rme32, params_format(params));
-	if (err < 0) {
-		spin_unlock_irq(&rme32->lock);
-		return err;
-	}
+	if (err < 0)
+		goto unlock;
+
 	err = snd_rme32_playback_setrate(rme32, params_rate(params));
-	if (err < 0) {
-		spin_unlock_irq(&rme32->lock);
-		return err;
-	}
+	if (err < 0)
+		goto unlock;
+
 	rate = snd_rme32_capture_getrate(rme32, &isadat);
-	if (rate > 0) {
-                if ((int)params_rate(params) != rate) {
-			spin_unlock_irq(&rme32->lock);
-                        return -EIO;                    
-                }
-                if ((isadat && runtime->hw.channels_min == 2) ||
-                    (!isadat && runtime->hw.channels_min == 8)) {
-			spin_unlock_irq(&rme32->lock);
-                        return -EIO;
-                }
-	}
+	if (rate > 0 &&
+	    ((int)params_rate(params) != rate ||
+	     (isadat && runtime->hw.channels_min == 2) ||
+	     (!isadat && runtime->hw.channels_min == 8)))
+		goto e_io;
+
 	/* AutoSync off for recording */
 	rme32->wcreg &= ~RME32_WCR_AUTOSYNC;
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
@@ -778,8 +771,8 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 	if (rme32->playback_periodsize != 0) {
 		if (params_period_size(params) << rme32->capture_frlog !=
 		    rme32->playback_periodsize) {
-			spin_unlock_irq(&rme32->lock);
-			return -EBUSY;
+			err = -EBUSY;
+			goto unlock;
 		}
 	}
 	rme32->capture_periodsize =
@@ -787,6 +780,12 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 	spin_unlock_irq(&rme32->lock);
 
 	return 0;
+
+e_io:
+	err = -EIO;
+unlock:
+	spin_unlock_irq(&rme32->lock);
+	return err;
 }
 
 static int snd_rme32_pcm_hw_free(struct snd_pcm_substream *substream)
-- 
2.15.0
