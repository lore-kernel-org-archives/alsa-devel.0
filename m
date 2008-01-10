From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH] Device ID for Macbook sound card
Date: Thu, 10 Jan 2008 16:18:02 +0800
Message-ID: <1199953082.13685.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 61D21244CD
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 09:18:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please refer to the [0003680] on bugtracking system.
The user found that "model=mbp3" works and provided the ID.

--- alsa-driver-hg20080110/alsa-kernel/pci/hda/patch_realtek.c
2008-01-09 09:00:15.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-01-10 16:07:20.000000000
+0800
@@ -6122,6 +6122,7 @@ static int patch_alc882(struct hda_codec
 		case 0x106b1000: /* iMac 24 */
 			board_config = ALC885_IMAC24;
 			break;
+		case 0x106b00a1: /* Macbook */
 		case 0x106b2c00: /* Macbook Pro rev3 */
 			board_config = ALC885_MBP3;
 			break;
