From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Make snd_hda_parse_nid_path()
	local
Date: Tue,  8 Dec 2015 13:41:58 +0100
Message-ID: <1449578518-17634-2-git-send-email-tiwai@suse.de>
References: <1449578518-17634-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E45C72660EE
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 13:42:01 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B651EAAC7
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 12:42:01 +0000 (UTC)
In-Reply-To: <1449578518-17634-1-git-send-email-tiwai@suse.de>
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

An exported function snd_hda_parse_nid_path() is used only inside
hda_generic.c.  Let's make it a static local function for a better
code optimization.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 5 ++---
 sound/pci/hda/hda_generic.h | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a644fc3302f0..f3c058f6c831 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -435,7 +435,7 @@ static bool __parse_nid_path(struct hda_codec *codec,
 	return true;
 }
 
-/**
+/*
  * snd_hda_parse_nid_path - parse the widget path from the given nid to
  * the target nid
  * @codec: the HDA codec
@@ -454,7 +454,7 @@ static bool __parse_nid_path(struct hda_codec *codec,
  * with the negative of given value are excluded, only other paths are chosen.
  * when @anchor_nid is zero, no special handling about path selection.
  */
-bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+static bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 			    hda_nid_t to_nid, int anchor_nid,
 			    struct nid_path *path)
 {
@@ -465,7 +465,6 @@ bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 	}
 	return false;
 }
-EXPORT_SYMBOL_GPL(snd_hda_parse_nid_path);
 
 /**
  * snd_hda_add_new_path - parse the path between the given NIDs and
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 692510e59365..f66fc7e25e07 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -308,9 +308,6 @@ void snd_hda_gen_free(struct hda_codec *codec);
 
 int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path);
 struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx);
-bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
-			    hda_nid_t to_nid, int anchor_nid,
-			    struct nid_path *path);
 struct nid_path *
 snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 		     hda_nid_t to_nid, int anchor_nid);
-- 
2.6.3
