From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Optimize audio component check
	in patch_hdmi.c
Date: Thu, 10 Dec 2015 13:11:47 +0100
Message-ID: <1449749508-1118-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8759326519F
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 13:11:49 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E572AC3B
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:11:49 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The audio component is enabled only when CONFIG_SND_HDA_I915 is set.
Give a dummy macro for allowing the compiler optimize out the relevant
codes when this Kconfig isn't set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 85342d261043..44d0d2374bb6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -152,8 +152,12 @@ struct hdmi_spec {
 	struct i915_audio_component_audio_ops i915_audio_ops;
 };
 
+#ifdef CONFIG_SND_HDA_I915
 #define codec_has_acomp(codec) \
 	((codec)->bus->core.audio_component != NULL)
+#else
+#define codec_has_acomp(codec)	false
+#endif
 
 struct hdmi_audio_infoframe {
 	u8 type; /* 0x84 */
-- 
2.6.3
