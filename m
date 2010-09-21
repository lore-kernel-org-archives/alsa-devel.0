From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hdmi - fix surround41 channel mapping
Date: Tue, 21 Sep 2010 14:44:51 +0800
Message-ID: <20100921064451.GA24445@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DDE7103877
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 08:44:59 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Shi, Lirong" <lirong.shi@intel.com>, alsa-devel@alsa-project.org, "Zhu,
	Shirley" <shirley.zhu@intel.com>, "Zhou, Jerry" <jerry.zhou@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jerry Zhou <jerry.zhou@intel.com>

Channel 2 and channel 3 were all wrongly mapped to HDMI slot 4.
This shows up as a bug that one channel is "lost" when playing in
surround41 mode.

Signed-off-by: Jerry Zhou <jerry.zhou@intel.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_hdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_hdmi.c	2010-09-21 11:20:59.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_hdmi.c	2010-09-21 14:26:55.000000000 +0800
@@ -191,11 +191,11 @@ static int hdmi_channel_mapping[0x32][8]
 	/* surround40 */
 	[0x08] = { 0x00, 0x11, 0x24, 0x35, 0xf3, 0xf2, 0xf6, 0xf7 },
 	/* 4ch */
 	[0x03] = { 0x00, 0x11, 0x23, 0x32, 0x44, 0xf5, 0xf6, 0xf7 },
 	/* surround41 */
-	[0x09] = { 0x00, 0x11, 0x24, 0x34, 0x43, 0xf2, 0xf6, 0xf7 },
+	[0x09] = { 0x00, 0x11, 0x24, 0x35, 0x42, 0xf3, 0xf6, 0xf7 },
 	/* surround50 */
 	[0x0a] = { 0x00, 0x11, 0x24, 0x35, 0x43, 0xf2, 0xf6, 0xf7 },
 	/* surround51 */
 	[0x0b] = { 0x00, 0x11, 0x24, 0x35, 0x43, 0x52, 0xf6, 0xf7 },
 	/* 7.1 */
