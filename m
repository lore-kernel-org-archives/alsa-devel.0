From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/16] ALSA: hda - Minor refactoring
Date: Thu, 16 Apr 2015 18:14:25 +0200
Message-ID: <1429200870-5288-12-git-send-email-tiwai@suse.de>
References: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90339261A5A
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
In-Reply-To: <1429200870-5288-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Move the small portion of the common sequence in hda_intel.c and
hda_tegra.c into hda_controller.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 10 +++++++---
 sound/pci/hda/hda_intel.c      |  3 ---
 sound/pci/hda/hda_tegra.c      |  3 ---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 21058b41b2c6..aaf01e841426 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -107,18 +107,22 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
 	int ret;
 
-	dsp_lock(get_azx_dev(substream));
-	if (dsp_is_locked(get_azx_dev(substream))) {
+	dsp_lock(azx_dev);
+	if (dsp_is_locked(azx_dev)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
 
+	azx_dev->core.bufsize = 0;
+	azx_dev->core.period_bytes = 0;
+	azx_dev->core.format_val = 0;
 	ret = chip->ops->substream_alloc_pages(chip, substream,
 					  params_buffer_bytes(hw_params));
 unlock:
-	dsp_unlock(get_azx_dev(substream));
+	dsp_unlock(azx_dev);
 	return ret;
 }
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9dff693005ea..8a1471851ca7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1743,9 +1743,6 @@ static int substream_alloc_pages(struct azx *chip,
 	int ret;
 
 	mark_runtime_wc(chip, azx_dev, substream, false);
-	azx_dev->core.bufsize = 0;
-	azx_dev->core.period_bytes = 0;
-	azx_dev->core.format_val = 0;
 	ret = snd_pcm_lib_malloc_pages(substream, size);
 	if (ret < 0)
 		return ret;
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 397e1821020f..d5349809f43d 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -104,9 +104,6 @@ static int substream_alloc_pages(struct azx *chip,
 {
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 
-	azx_dev->core.bufsize = 0;
-	azx_dev->core.period_bytes = 0;
-	azx_dev->core.format_val = 0;
 	return snd_pcm_lib_malloc_pages(substream, size);
 }
 
-- 
2.3.5
