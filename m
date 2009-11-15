From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 01/11] intelhdmi - fix audio infoframe fill size
Date: Sun, 15 Nov 2009 19:32:20 +0800
Message-ID: <20091115114439.442038402@intel.com>
References: <20091115113219.606666087@intel.com>
Content-Type: multipart/mixed; boundary="===============5383249349183590683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 03D1624153
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:12 +0100 (CET)
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

--===============5383249349183590683==
Content-Disposition: inline; filename=hdmi-fix-sizeof-ai.patch

Reported-by: David Härdeman <david@hardeman.nu>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:14:30.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:14:39.000000000 +0800
@@ -509,12 +509,12 @@ static void hdmi_fill_audio_infoframe(st
 	hdmi_debug_dip_size(codec, pin_nid);
 	hdmi_clear_dip_buffers(codec, pin_nid); /* be paranoid */
 
-	for (i = 0; i < sizeof(ai); i++)
+	for (i = 0; i < sizeof(*ai); i++)
 		sum += params[i];
 	ai->checksum = - sum;
 
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
-	for (i = 0; i < sizeof(ai); i++)
+	for (i = 0; i < sizeof(*ai); i++)
 		hdmi_write_dip_byte(codec, pin_nid, params[i]);
 }
 



--===============5383249349183590683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5383249349183590683==--
