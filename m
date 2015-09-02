From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing inline for dummy
	snd_hdac_set_codec_wakeup()
Date: Wed,  2 Sep 2015 12:28:32 +0200
Message-ID: <1441189712-27827-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 50AB12604DD
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 12:28:35 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F03D3ACFC
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 10:28:34 +0000 (UTC)
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

This seems overlooked.

Fixes: 98d8fc6c5d36 ('ALSA: hda - Move hda_i915.c from sound/pci/hda to sound/hda')
Cc: <stable@vger.kernel.org> # v4.2+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_i915.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index a5b5cae03e87..930b41e5acf4 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -14,7 +14,7 @@ int snd_hdac_i915_init(struct hdac_bus *bus);
 int snd_hdac_i915_exit(struct hdac_bus *bus);
 int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops *);
 #else
-static int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
+static inline int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
 	return 0;
 }
-- 
2.5.1
