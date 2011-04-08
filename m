From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Fri, 08 Apr 2011 15:38:48 +0800
Message-ID: <20110408073848.30438.39586.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A1B5A243ED
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 09:38:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Harsha Priya <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Fix the possible dead lock shown below:

spin_lock
sst_get_stream_status
sst_period_elapsed
intel_sst_interrupt
handle_IRQ_event
handle_fasteoi_irq
do_IRQ
common_interrupt
spin_lock
sst_set_stream_status
sst_platform_pcm_trigger

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 9ba9414..d827edb 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -116,18 +116,20 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 static inline void sst_set_stream_status(struct sst_runtime_stream *stream,
 					int state)
 {
-	spin_lock(&stream->status_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&stream->status_lock, flags);
 	stream->stream_status = state;
-	spin_unlock(&stream->status_lock);
+	spin_unlock_irqrestore(&stream->status_lock, flags);
 }
 
 static inline int sst_get_stream_status(struct sst_runtime_stream *stream)
 {
 	int state;
+	unsigned long flags;
 
-	spin_lock(&stream->status_lock);
+	spin_lock_irqsave(&stream->status_lock, flags);
 	state = stream->stream_status;
-	spin_unlock(&stream->status_lock);
+	spin_unlock_irqrestore(&stream->status_lock, flags);
 	return state;
 }
