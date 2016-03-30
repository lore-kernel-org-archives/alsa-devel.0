From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA - hda: hdmi check NULL pointer in
	hdmi_set_chmap
Date: Wed, 30 Mar 2016 11:08:42 +0800
Message-ID: <1459307322-24655-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EEFF02664F5
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 05:10:03 +0200 (CEST)
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

Make sure per_pin is not NULL before using it.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4833c7b..c99289d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1858,6 +1858,8 @@ static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 
+	if (!per_pin)
+		return;
 	mutex_lock(&per_pin->lock);
 	per_pin->chmap_set = true;
 	memcpy(per_pin->chmap, chmap, ARRAY_SIZE(per_pin->chmap));
-- 
1.9.1
