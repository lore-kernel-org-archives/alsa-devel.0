From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 3/4] hda - compute checksum in HDMI audio
	infoframe
Date: Wed, 11 Feb 2009 15:22:30 +0800
Message-ID: <20090211073402.792210199@intel.com>
References: <20090211072227.760779741@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BA81103888
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 08:56:18 +0100 (CET)
Content-Disposition: inline; filename=alsa-intel-hdmi-checksum.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- mm.orig/sound/pci/hda/patch_intelhdmi.c
+++ mm/sound/pci/hda/patch_intelhdmi.c
@@ -366,11 +366,16 @@ static void hdmi_fill_audio_infoframe(st
 					struct hdmi_audio_infoframe *ai)
 {
 	u8 *params = (u8 *)ai;
+	u8 sum = 0;
 	int i;
 
 	hdmi_debug_dip_size(codec);
 	hdmi_clear_dip_buffers(codec); /* be paranoid */
 
+	for (i = 0; i < sizeof(ai); i++)
+		sum += params[i];
+	ai->checksum = - sum;
+
 	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
 	for (i = 0; i < sizeof(ai); i++)
 		hdmi_write_dip_byte(codec, PIN_NID, params[i]);

-- 
