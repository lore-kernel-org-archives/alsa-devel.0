From: mengdong.lin@intel.com
Subject: [PATCH 1/1] ALSA: hda - bug fix for invalid connection
	list of more Haswell HDMI codec pins
Date: Tue, 18 Dec 2012 13:21:54 -0500
Message-ID: <1355854914-13010-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 091B82615BB
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 07:19:47 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Haswell HDMI codec may report invalid connection list entries on all three
pins. But our previous patch only fixes the HDMI pin, not the DP pin, so
audio playbak via DP can still fail.

This patch adds fixup for Haswell to set proper connection list entries for
the other 2 pins including the DP pin.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 42fdf14..73d298a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1710,8 +1710,14 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 	if (vendor_param == -1 || !(vendor_param & 0x02))
 		return;
 
+	snd_hda_override_conn_list(codec, 0x05, 3, list);
+	hdmi_read_pin_conn(codec, 1);
+
 	snd_hda_override_conn_list(codec, 0x06, 3, list);
 	hdmi_read_pin_conn(codec, 1);
+
+	snd_hda_override_conn_list(codec, 0x07, 3, list);
+	hdmi_read_pin_conn(codec, 1);
 }
 
 
-- 
1.7.9.5
