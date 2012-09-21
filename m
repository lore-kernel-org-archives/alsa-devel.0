From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ALSA: hda - force use of SSYNC bits
Date: Fri, 21 Sep 2012 18:39:05 -0500
Message-ID: <1348270747-4083-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AF2E5265DF8
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 01:39:15 +0200 (CEST)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SSYNC bits are typically used to start multiple
streams synchronously. It makes sense to use them
for a single stream for a more predictable startup
sequence. The transfers only start once the DMA and
FIFOs are ready. This results in a better correlation
between timestamps and number of samples played.

Credits to Kar Leong Wang for suggesting this
improvement.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 60882c6..7ba187e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1959,14 +1959,14 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 
 	spin_lock(&chip->reg_lock);
-	if (nsync > 1) {
-		/* first, set SYNC bits of corresponding streams */
-		if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
-			azx_writel(chip, OLD_SSYNC,
-				   azx_readl(chip, OLD_SSYNC) | sbits);
-		else
-			azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) | sbits);
-	}
+
+	/* first, set SYNC bits of corresponding streams */
+	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
+		azx_writel(chip, OLD_SSYNC,
+			azx_readl(chip, OLD_SSYNC) | sbits);
+	else
+		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) | sbits);
+
 	snd_pcm_group_for_each_entry(s, substream) {
 		if (s->pcm->card != substream->pcm->card)
 			continue;
@@ -1984,8 +1984,6 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 	spin_unlock(&chip->reg_lock);
 	if (start) {
-		if (nsync == 1)
-			return 0;
 		/* wait until all FIFOs get ready */
 		for (timeout = 5000; timeout; timeout--) {
 			nwait = 0;
@@ -2018,16 +2016,14 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			cpu_relax();
 		}
 	}
-	if (nsync > 1) {
-		spin_lock(&chip->reg_lock);
-		/* reset SYNC bits */
-		if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
-			azx_writel(chip, OLD_SSYNC,
-				   azx_readl(chip, OLD_SSYNC) & ~sbits);
-		else
-			azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
-		spin_unlock(&chip->reg_lock);
-	}
+	spin_lock(&chip->reg_lock);
+	/* reset SYNC bits */
+	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
+		azx_writel(chip, OLD_SSYNC,
+			azx_readl(chip, OLD_SSYNC) & ~sbits);
+	else
+		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
+	spin_unlock(&chip->reg_lock);
 	return 0;
 }
 
-- 
1.7.9.5
