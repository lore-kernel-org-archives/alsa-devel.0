From: mengdong.lin@intel.com
Subject: [PATCH v2 1/2] ALSA: hda - bug fix on return value
	when getting HDMI ELD info
Date: Thu, 28 Mar 2013 05:20:22 -0400
Message-ID: <1364462422-30404-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D3D265B6E
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 03:13:38 +0100 (CET)
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

In function snd_hdmi_get_eld(), the variable 'ret' should be initialized to 0.
Otherwise it will be returned uninitialized as non-zero after ELD info is got
successfully. Thus hdmi_present_sense() will always assume ELD info is invalid
by mistake, and /proc file system cannot show the proper ELD info.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 7dd8463..d0d7ac1 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -320,7 +320,7 @@ int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
 		     unsigned char *buf, int *eld_size)
 {
 	int i;
-	int ret;
+	int ret = 0;
 	int size;
 
 	/*
-- 
1.7.10.4
