From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - initialize audio InfoFrame to be
	all zero
Date: Tue, 11 Mar 2014 17:12:52 -0400
Message-ID: <f37b3349bd0a4f5989cf503f578e25ad0f7d160e.1394572173.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 676B4261092
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 09:11:10 +0100 (CET)
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

This patch initialized the local audio InfoFrame variable 'ai' to be all zero,
thus the data bytes will indicate "Refer to Stream Header" by default.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5ef9503..3ab7063 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1062,6 +1062,7 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
 {
 	union audio_infoframe ai;
 
+	memset(&ai, 0, sizeof(ai));
 	if (conn_type == 0) { /* HDMI */
 		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
 
-- 
1.8.1.2
