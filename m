From: mengdong.lin@intel.com
Subject: [PATCH v2 1/1] ALSA: hda - use usleep_range in link
	reset and change timeout check
Date: Wed, 12 Dec 2012 09:16:15 -0500
Message-ID: <1355321775-2042-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC64261687
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:14:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>, Xingchao Wang <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Reducing the time on HDA link reset can help to reduce the driver loading
time. So we replace msleep with usleep_range to get more accurate time
control and change the value to a smaller one. And a 100ms timeout is set
for both entering and exiting the link reset.

Signed-off-by: Xingchao Wang <xingchao.wang@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 72b085a..ed3a290 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1041,7 +1041,7 @@ static void azx_power_notify(struct hda_bus *bus, bool power_up);
 /* reset codec link */
 static int azx_reset(struct azx *chip, int full_reset)
 {
-	int count;
+	unsigned long timeout;
 
 	if (!full_reset)
 		goto __skip;
@@ -1052,24 +1052,26 @@ static int azx_reset(struct azx *chip, int full_reset)
 	/* reset controller */
 	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
 
-	count = 50;
-	while (azx_readb(chip, GCTL) && --count)
-		msleep(1);
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (azx_readb(chip, GCTL) &&
+			time_before(jiffies, timeout))
+		usleep_range(500, 1000);
 
 	/* delay for >= 100us for codec PLL to settle per spec
 	 * Rev 0.9 section 5.5.1
 	 */
-	msleep(1);
+	usleep_range(500, 1000);
 
 	/* Bring controller out of reset */
 	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
 
-	count = 50;
-	while (!azx_readb(chip, GCTL) && --count)
-		msleep(1);
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!azx_readb(chip, GCTL) &&
+			time_before(jiffies, timeout))
+		usleep_range(500, 1000);
 
 	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
-	msleep(1);
+	usleep_range(1000, 1200);
 
       __skip:
 	/* check to see if controller is ready */
-- 
1.7.9.5
