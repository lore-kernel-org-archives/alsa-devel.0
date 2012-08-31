From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 1/3] ALSA: pcm - introduce device_buffer
Date: Fri, 31 Aug 2012 06:44:42 +0530
Message-ID: <1346375684-4145-2-git-send-email-vinod.koul@linux.intel.com>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F9BF265DDE
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 03:08:26 +0200 (CEST)
In-Reply-To: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

In many modern SoCs the audio DSP can buffer the PCM ring buffer data, typically
in SRAMs or any other memory available.
Today we have no means to represent this buffering and ALSA in some cases when
device still has to render this buffer but app_ptr is equal to hw_ptr alsa
wrongly detects an overrun

This patch tries to add a new field "device_buffer" to represent buffering done in
DSPs. This value is also used for the xrun calculations in ALSA

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c75c0d1..58e669a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -281,6 +281,7 @@ struct snd_pcm_runtime {
 	unsigned long hw_ptr_jiffies;	/* Time when hw_ptr is updated */
 	unsigned long hw_ptr_buffer_jiffies; /* buffer time in jiffies */
 	snd_pcm_sframes_t delay;	/* extra delay; typically FIFO size */
+	snd_pcm_sframes_t device_buffer; /* buffered data in device/driver */
 
 	/* -- HW params -- */
 	snd_pcm_access_t access;	/* access mode */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7ae6719..9b0127f 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -292,7 +292,15 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	} else {
-		if (avail >= runtime->stop_threshold) {
+		snd_pcm_uframes_t actual_avail;
+		if (avail < runtime->device_buffer)
+			actual_avail = avail;
+		else
+			actual_avail = avail - runtime->device_buffer;
+		if (actual_avail  >= runtime->stop_threshold) {
+			snd_printd(KERN_ERR  "avail > stop_threshold!!\n");
+			snd_printd(KERN_ERR  "actual_avail %ld, avail %ld, device_buffer %ld!!\n",
+					actual_avail, avail,  runtime->device_buffer);
 			xrun(substream);
 			return -EPIPE;
 		}
-- 
1.7.9.5
