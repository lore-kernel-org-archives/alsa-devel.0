From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]
Date: Thu, 17 Jan 2008 10:58:04 +0800
Message-ID: <1200538684.30641.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E91C1245DD
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 03:57:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

For codec conexant 5045, I found that the name of "Capture Source Items"
is different from the name of mixer.

The mixer is:
HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x2, HDA_INPUT),

But the capture source item is :
static struct hda_input_mux cxt5045_capture_source = {
	.num_items = 2,
	.items = {
		{ "IntMic", 0x1 },
		{ "LineIn", 0x2 },
	}
};

I think that it's better to change the name of capture_source to avoid
misunderstanding.

Best regards!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080115/alsa-kernel/pci/hda/patch_conexant.c
2008-01-09 09:00:15.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_conexant.c	2008-01-17 10:50:06.000000000
+0800
@@ -453,7 +453,7 @@ static struct hda_input_mux cxt5045_capt
 	.num_items = 2,
 	.items = {
 		{ "IntMic", 0x1 },
-		{ "LineIn", 0x2 },
+		{ "ExtMic", 0x2 },
 	}
 };
