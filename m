From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 03/10] ALSA: hda: read trigger_timestamp
	immediately after starting DMA
Date: Fri, 30 Jan 2015 17:55:56 -0600
Message-ID: <1422662163-7391-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3975B2619FA
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:33 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Make sure wallclock counter and trigger timestamp are read very
close to each other for better alignment.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 0cfc9c8..271f86e 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -657,6 +657,9 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
 	if (start) {
 		azx_timecounter_init(substream, 0, 0);
+		snd_pcm_gettime(substream->runtime, &substream->runtime->trigger_tstamp);
+		substream->runtime->trigger_tstamp_latched = 1;
+
 		if (nsync > 1) {
 			cycle_t cycle_last;
 
-- 
1.9.1
