From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Remove unused
	snd_hda_get_nid_path()
Date: Tue,  8 Dec 2015 13:41:57 +0100
Message-ID: <1449578518-17634-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A2B266088
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 13:42:00 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EF0A1AB12
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 12:41:59 +0000 (UTC)
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

An exported helper function snd_hda_get_nid_path() is nowhere used.
Let's remove it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 16 ----------------
 sound/pci/hda/hda_generic.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index c6e8a651cea1..a644fc3302f0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -279,22 +279,6 @@ static struct nid_path *get_nid_path(struct hda_codec *codec,
 }
 
 /**
- * snd_hda_get_nid_path - get the path between the given NIDs
- * @codec: the HDA codec
- * @from_nid: the NID where the path start from
- * @to_nid: the NID where the path ends at
- *
- * Return the found nid_path object or NULL for error.
- * Passing 0 to either @from_nid or @to_nid behaves as a wildcard.
- */
-struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
-				      hda_nid_t from_nid, hda_nid_t to_nid)
-{
-	return get_nid_path(codec, from_nid, to_nid, 0);
-}
-EXPORT_SYMBOL_GPL(snd_hda_get_nid_path);
-
-/**
  * snd_hda_get_path_idx - get the index number corresponding to the path
  * instance
  * @codec: the HDA codec
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 56e4139b9032..692510e59365 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -306,8 +306,6 @@ int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
 int snd_hda_gen_init(struct hda_codec *codec);
 void snd_hda_gen_free(struct hda_codec *codec);
 
-struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
-				      hda_nid_t from_nid, hda_nid_t to_nid);
 int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path);
 struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx);
 bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
-- 
2.6.3
