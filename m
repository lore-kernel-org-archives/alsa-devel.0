From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Clear the leftover component
	assignment at snd_hdac_i915_exit()
Date: Tue, 29 Mar 2016 14:24:07 +0200
Message-ID: <1459254247-6794-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A61B32605C3
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 14:24:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3E644ADBF
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 12:24:08 +0000 (UTC)
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

The commit [d745f5e7b8b2: ALSA: hda - Add the pin / port mapping on
Intel ILK and VLV] introduced a WARN_ON() to check the pointer for
avoiding the double initializations.  But hdac_acomp pointer wasn't
cleared at snd_hdac_i915_exit(), thus after reloading the HD-audio
driver, it may result in the false positive warning.  This patch makes
sure to clear the leftover pointer at exit.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=94736
Reported-by: Daniela Doras-prodan <daniela.doras-prodan@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 750a4ea49fa9..ae0f305a7e41 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -372,6 +372,7 @@ int snd_hdac_i915_exit(struct hdac_bus *bus)
 
 	kfree(acomp);
 	bus->audio_component = NULL;
+	hdac_acomp = NULL;
 
 	return 0;
 }
-- 
2.7.4
