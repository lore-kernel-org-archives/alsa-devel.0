From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 06/10] intelhdmi - separate out infoframe
	checksum routine
Date: Wed, 18 Nov 2009 12:38:04 +0800
Message-ID: <20091118043935.461216440@intel.com>
References: <20091118043758.141785140@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D775E1038F7
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 05:42:48 +0100 (CET)
Content-Disposition: inline; filename=hdmi-checksum.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

And make it right when called for more than one times.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-02 16:11:22.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-02 16:27:42.000000000 +0800
@@ -508,24 +508,35 @@ static void hdmi_clear_dip_buffers(struc
 #endif
 }
 
+static void hdmi_checksum_audio_infoframe(struct hdmi_audio_infoframe *ai)
+{
+	u8 *bytes = (u8 *)ai;
+	u8 sum = 0;
+	int i;
+
+	ai->checksum = 0;
+
+	for (i = 0; i < sizeof(*ai); i++)
+		sum += bytes[i];
+
+	ai->checksum = - sum;
+}
+
 static void hdmi_fill_audio_infoframe(struct hda_codec *codec,
 				      hda_nid_t pin_nid,
 				      struct hdmi_audio_infoframe *ai)
 {
-	u8 *params = (u8 *)ai;
-	u8 sum = 0;
+	u8 *bytes = (u8 *)ai;
 	int i;
 
 	hdmi_debug_dip_size(codec, pin_nid);
 	hdmi_clear_dip_buffers(codec, pin_nid); /* be paranoid */
 
-	for (i = 0; i < sizeof(*ai); i++)
-		sum += params[i];
-	ai->checksum = - sum;
+	hdmi_checksum_audio_infoframe(ai);
 
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	for (i = 0; i < sizeof(*ai); i++)
-		hdmi_write_dip_byte(codec, pin_nid, params[i]);
+		hdmi_write_dip_byte(codec, pin_nid, bytes[i]);
 }
 
 /*
