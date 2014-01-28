From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/11] ALSA: hda - Avoid unnecessary verbs
	write in snd_hda_activate_path()
Date: Tue, 28 Jan 2014 11:06:32 +0100
Message-ID: <1390903600-22772-4-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4602651B9
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:42 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 01E84AC81
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

... by using snd_Hda_codec_update_cache() instead of *_write_cache().
Since all path elements should have been updated by this function,
we are safe to assume that the cache contents are consistent.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8321a97d5c05..437ef13c5a90 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -762,7 +762,7 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 						    AC_PWRST_D0);
 		}
 		if (enable && path->multi[i])
-			snd_hda_codec_write_cache(codec, nid, 0,
+			snd_hda_codec_update_cache(codec, nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
 					    path->idx[i]);
 		if (has_amp_in(codec, path, i))
-- 
1.8.5.2
