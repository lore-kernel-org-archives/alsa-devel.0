From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ALSA: hda - Fixes double fault in
	nvhdmi_chmap_cea_alloc_validate_get_type
Date: Mon, 14 Mar 2016 10:35:06 +0530
Message-ID: <1457931906-23780-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 171702612D7
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 06:05:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

nvhdmi_chmap_cea_alloc_validate_get_type calls itself recursively
using chmap ops causing the double fault.

Fixed by adding the default validate_get_type handling inside nvdia
validate_get_type handler.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=114311
Fixes: 67b90cb ("ALSA: hda - Create common chmap object")
Reported-by: Andreas Reis <andreas.reis@gmail.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Tested-by: Andreas Reis <andreas.reis@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f59e87b..a386a65 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2827,8 +2827,12 @@ static int nvhdmi_chmap_cea_alloc_validate_get_type(struct hdac_chmap *chmap,
 	if (cap->ca_index == 0x00 && channels == 2)
 		return SNDRV_CTL_TLVT_CHMAP_FIXED;
 
-	return chmap->ops.chmap_cea_alloc_validate_get_type(
-				chmap, cap, channels);
+	/* If the speaker allocation matches the channel count, it is OK. */
+	if (cap->channels != channels)
+		return -1;
+
+	/* all channels are remappable freely */
+	return SNDRV_CTL_TLVT_CHMAP_VAR;
 }
 
 static int nvhdmi_chmap_validate(struct hdac_chmap *chmap,
-- 
1.9.1
