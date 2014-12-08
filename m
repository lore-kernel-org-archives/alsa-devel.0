From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 3/9] ALSA: hda: read trigger_timestamp
	immediately after starting DMA
Date: Mon,  8 Dec 2014 16:23:40 -0600
Message-ID: <1418077426-8309-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EF18726058B
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:36 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
 sound/pci/hda/hda_controller.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 8337645..6a9f8c8 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -562,6 +562,8 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	azx_dev = get_azx_dev(substream);
 	trace_azx_pcm_trigger(chip, azx_dev, cmd);
 
+	substream->runtime->trigger_tstamp_latched = 0;
+
 	if (dsp_is_locked(azx_dev) || !azx_dev->prepared)
 		return -EPIPE;
 
@@ -657,6 +659,9 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
 	if (start) {
 		azx_timecounter_init(substream, 0, 0);
+		snd_pcm_gettime(substream->runtime, &substream->runtime->trigger_tstamp);
+		substream->runtime->trigger_tstamp_latched = 1;
+
 		if (nsync > 1) {
 			cycle_t cycle_last;
 
-- 
2.1.0
