From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH 1/2] ALSA: hda: Fix mismatches for register
	mask and value in hdac controller
Date: Wed,  9 Jan 2019 16:20:50 +0800
Message-ID: <20190109082051.32643-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C50266829
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 09:19:12 +0100 (CET)
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
Cc: Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

E.g. for azx_int_enable(), we should set both mask and value to be
"AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN"(the mask was 0) to enable
controller CIE and GIE.

We have similar issues on setting AZX_GCTL_RESET and AZX_GCTL_UNSOL,
here try to correct all of them.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/hda/hdac_controller.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 74244d8e2909..b2e9454f5816 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -376,7 +376,7 @@ void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus)
 {
 	unsigned long timeout;
 
-	snd_hdac_chip_updateb(bus, GCTL, 0, AZX_GCTL_RESET);
+	snd_hdac_chip_updateb(bus, GCTL, AZX_GCTL_RESET, AZX_GCTL_RESET);
 
 	timeout = jiffies + msecs_to_jiffies(100);
 	while (!snd_hdac_chip_readb(bus, GCTL) && time_before(jiffies, timeout))
@@ -415,7 +415,7 @@ int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 	}
 
 	/* Accept unsolicited responses */
-	snd_hdac_chip_updatel(bus, GCTL, 0, AZX_GCTL_UNSOL);
+	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
 
 	/* detect codecs */
 	if (!bus->codec_mask) {
@@ -431,7 +431,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_reset_link);
 static void azx_int_enable(struct hdac_bus *bus)
 {
 	/* enable controller CIE and GIE */
-	snd_hdac_chip_updatel(bus, INTCTL, 0, AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN);
+	snd_hdac_chip_updatel(bus, INTCTL,
+			      AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN,
+			      AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN);
 }
 
 /* disable interrupts */
-- 
2.17.1
