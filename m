From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - hdmi_find_pcm_slot return value
	bug fix
Date: Tue,  1 Mar 2016 15:18:26 +0800
Message-ID: <1456816706-21009-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A123261501
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 08:22:50 +0100 (CET)
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

hdmi_find_pcm_slot return -EBUSY when not no pcm slot found,
not -ENODEV. So the caller should compare with -EBUSY.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d77509a..aa2d6a2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1758,7 +1758,7 @@ static void hdmi_attach_hda_pcm(struct hdmi_spec *spec,
 	if (per_pin->pcm)
 		return;
 	idx = hdmi_find_pcm_slot(spec, per_pin);
-	if (idx == -ENODEV)
+	if (idx == -EBUSY)
 		return;
 	per_pin->pcm_idx = idx;
 	per_pin->pcm = get_hdmi_pcm(spec, idx);
-- 
1.9.1
