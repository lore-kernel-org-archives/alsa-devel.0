From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: [PATCH] ALSA - Replace msleep() with usleep_range() to
	save module loading time
Date: Mon, 10 Dec 2012 14:20:32 +0800
Message-ID: <1355120432-9840-1-git-send-email-wangxingchao2011@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5488A265150
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 07:39:20 +0100 (CET)
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
Cc: mengdong.lin@intel.com, Wang Xingchao <wangxingchao2011@gmail.com>
List-Id: alsa-devel@alsa-project.org

msleep(1) is not so accurate and may cause almost 15ms delay in azx_reset().
usleep_range() can reduce ~30ms loading time for Intel Haswell which has two HDA
controllers.

Signed-off-by: Wang Xingchao <wangxingchao2011@gmail.com>
---
 sound/pci/hda/hda_intel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index eb48109..865df90 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1075,22 +1075,22 @@ static int azx_reset(struct azx *chip, int full_reset)
 
 	count = 50;
 	while (azx_readb(chip, GCTL) && --count)
-		msleep(1);
+		usleep_range(1000, 1500);
 
 	/* delay for >= 100us for codec PLL to settle per spec
 	 * Rev 0.9 section 5.5.1
 	 */
-	msleep(1);
+	usleep_range(1000, 1500);
 
 	/* Bring controller out of reset */
 	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
 
 	count = 50;
 	while (!azx_readb(chip, GCTL) && --count)
-		msleep(1);
+		usleep_range(1000, 1500);
 
 	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
-	msleep(1);
+	usleep_range(1000, 1500);
 
       __skip:
 	/* check to see if controller is ready */
-- 
1.7.9.5
