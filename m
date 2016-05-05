From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/2] ALSA: hda: fix to wait for RIRB & CORB
	DMA to set
Date: Thu,  5 May 2016 11:24:43 +0530
Message-ID: <1462427683-3646-2-git-send-email-vinod.koul@intel.com>
References: <1462427683-3646-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 06AFB2652EE
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 07:48:47 +0200 (CEST)
In-Reply-To: <1462427683-3646-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If the DMAs are not being quiesced properly, it may lead to
stability issues, so the recommendation is to wait till DMAs are
stopped.

After setting the stop bit of RIRB/CORB DMA, we should wait for
stop bit to be set.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
changes in v2:
 - use common wait routine as suggested by Takashi

 sound/hda/hdac_controller.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 8c486235c905..9fee464e5d49 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -80,6 +80,22 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init_cmd_io);
 
+/* wait for cmd dmas till they are stopped */
+static void hdac_wait_for_cmd_dmas(struct hdac_bus *bus)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((snd_hdac_chip_readb(bus, RIRBCTL) & AZX_RBCTL_DMA_EN)
+		&& time_before(jiffies, timeout))
+		udelay(10);
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((snd_hdac_chip_readb(bus, CORBCTL) & AZX_CORBCTL_RUN)
+		&& time_before(jiffies, timeout))
+		udelay(10);
+}
+
 /**
  * snd_hdac_bus_stop_cmd_io - clean up CORB/RIRB buffers
  * @bus: HD-audio core bus
@@ -90,6 +106,7 @@ void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus)
 	/* disable ringbuffer DMAs */
 	snd_hdac_chip_writeb(bus, RIRBCTL, 0);
 	snd_hdac_chip_writeb(bus, CORBCTL, 0);
+	hdac_wait_for_cmd_dmas(bus);
 	/* disable unsolicited responses */
 	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, 0);
 	spin_unlock_irq(&bus->reg_lock);
-- 
1.9.1
