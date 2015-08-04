From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ALSA: HDA: wait for RIRB,
	CORB DMA to finish
Date: Tue,  4 Aug 2015 09:28:40 +0530
Message-ID: <1438660720-30033-4-git-send-email-vinod.koul@intel.com>
References: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D48E3265528
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 05:57:03 +0200 (CEST)
In-Reply-To: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
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

HDA spec says that RORB and CORB DMA stop will take some
time to complete.  So we should wait till the DMAs are
stopped.

Although the current controllers don't have multilinks so
doesn't impact much, but SKL onwards we have multiple links
so waiting for DMAs to stop makes better sense.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/hdac_controller.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index b5a17cb510a0..3b5d07174d79 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -86,10 +86,24 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_init_cmd_io);
  */
 void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus)
 {
+	unsigned long timeout;
+
 	spin_lock_irq(&bus->reg_lock);
 	/* disable ringbuffer DMAs */
 	snd_hdac_chip_writeb(bus, RIRBCTL, 0);
 	snd_hdac_chip_writeb(bus, CORBCTL, 0);
+
+	/* poll DMAs to check if they stopped or not */
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((snd_hdac_chip_readb(bus, RIRBCTL) & AZX_RBCTL_DMA_EN) &&
+	       time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((snd_hdac_chip_readb(bus, CORBCTL) & AZX_CORBCTL_RUN) &&
+	       time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+
 	/* disable unsolicited responses */
 	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, 0);
 	spin_unlock_irq(&bus->reg_lock);
-- 
1.9.1
