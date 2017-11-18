From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: rme96: Improve unlocking of an IRQ
 in snd_rme96_capture_hw_params()
Date: Sat, 18 Nov 2017 13:53:45 +0100
Message-ID: <1e2f56b0-df93-d9d3-da79-758439de00a5@users.sourceforge.net>
References: <7b7da9a6-64e1-bde5-99aa-de21f0665323@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id BBCB426698E
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 13:53:52 +0100 (CET)
In-Reply-To: <7b7da9a6-64e1-bde5-99aa-de21f0665323@users.sourceforge.net>
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
Date: Sat, 18 Nov 2017 13:26:59 +0100

* Add jump targets so that a call of the function "spin_unlock_irq"
  is stored only twice in this function implementation.

* Replace five calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme96.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index fd8a62ceffde..1c1106f770e7 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1066,30 +1066,21 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 
 	spin_lock_irq(&rme96->lock);
 	err = snd_rme96_capture_setformat(rme96, params_format(params));
-	if (err < 0) {
-		spin_unlock_irq(&rme96->lock);
-		return err;
-	}
+	if (err < 0)
+		goto unlock;
+
 	if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
 		err = snd_rme96_capture_analog_setrate(rme96,
 						       params_rate(params));
-		if (err < 0) {
-			spin_unlock_irq(&rme96->lock);
-			return err;
-		}
+		if (err < 0)
+			goto unlock;
 	} else {
 		rate = snd_rme96_capture_getrate(rme96, &isadat);
-		if (rate > 0) {
-			if ((int)params_rate(params) != rate) {
-				spin_unlock_irq(&rme96->lock);
-				return -EIO;
-			}
-			if ((isadat && runtime->hw.channels_min == 2) ||
-			    (!isadat && runtime->hw.channels_min == 8)) {
-				spin_unlock_irq(&rme96->lock);
-				return -EIO;
-			}
-		}
+		if (rate > 0 &&
+		    ((int)params_rate(params) != rate ||
+		     (isadat && runtime->hw.channels_min == 2) ||
+		     (!isadat && runtime->hw.channels_min == 8)))
+			goto e_io;
 	}
 
 	snd_rme96_setframelog(rme96, params_channels(params), 0);
@@ -1097,8 +1088,8 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 		if (params_period_size(params) << rme96->capture_frlog !=
 		    rme96->playback_periodsize)
 		{
-			spin_unlock_irq(&rme96->lock);
-			return -EBUSY;
+			err = -EBUSY;
+			goto unlock;
 		}
 	}
 	rme96->capture_periodsize =
@@ -1107,6 +1098,12 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 	spin_unlock_irq(&rme96->lock);
 
 	return 0;
+
+e_io:
+	err = -EIO;
+unlock:
+	spin_unlock_irq(&rme96->lock);
+	return err;
 }
 
 static void
-- 
2.15.0
