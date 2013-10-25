From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add missing initial vmaster hook
	at build_controls callback
Date: Fri, 25 Oct 2013 23:58:20 +0200
Message-ID: <1382738300-19744-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B19A261719
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 23:55:28 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D1378A5557
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 23:55:27 +0200 (CEST)
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

The generic parser has a support of vmaster hook, but this is
initialized only in the init callback with the check of the presence
of the corresponding kctl.  However, since kctl is NULL at the very
first init callback that is called before build_controls callback, the
vmaster hook sync is skipped there.  Eventually this leads to the
uninitialized state depending on the hook implementation.

This patch adds a simple workaround, just calling the sync function
explicitly at build_controls callback.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 26ad4f0..b7c89df 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4475,9 +4475,11 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 					    true, &spec->vmaster_mute.sw_kctl);
 		if (err < 0)
 			return err;
-		if (spec->vmaster_mute.hook)
+		if (spec->vmaster_mute.hook) {
 			snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute,
 						 spec->vmaster_mute_enum);
+			snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
+		}
 	}
 
 	free_kctls(spec); /* no longer needed */
-- 
1.8.4
