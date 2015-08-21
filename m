From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Refresh widgets sysfs at probing
	Haswell+ HDMI codecs
Date: Fri, 21 Aug 2015 15:12:46 +0200
Message-ID: <1440162766-27727-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C32052604B3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 15:12:48 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Intel Haswell (and later) codec refreshes the widgets tree to expose
the whole widget nodes at probing.  However, this refresh was missing
for sysfs tree.

This patch adds the missing piece, as we have now a proper API.

Reported-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a97db5fc8a15..df982fc6a872 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2331,6 +2331,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	if (is_haswell_plus(codec)) {
 		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
+		snd_hdac_refresh_widget_sysfs(&codec->core);
 	}
 
 	/* For Valleyview/Cherryview, only the display codec is in the display
-- 
2.5.0
