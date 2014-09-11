From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 2/7] ALSA: hda - Make
	snd_hda_jack_tbl_new() static
Date: Thu, 11 Sep 2014 16:19:12 +0200
Message-ID: <1410445157-23198-3-git-send-email-tiwai@suse.de>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C4C2656E0
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:19:20 +0200 (CEST)
In-Reply-To: <1410445157-23198-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

It's called only in hda_jack.c, so make it local.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_jack.c | 3 +--
 sound/pci/hda/hda_jack.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 9c8f24f2d56b..7f332794993f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -94,7 +94,7 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get_from_tag);
 /**
  * snd_hda_jack_tbl_new - create a jack-table entry for the given NID
  */
-struct hda_jack_tbl *
+static struct hda_jack_tbl *
 snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
@@ -108,7 +108,6 @@ snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
 	jack->tag = codec->jacktbl.used;
 	return jack;
 }
-EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_new);
 
 void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 {
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index c1abc7324d68..67f42db9c89c 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -42,8 +42,6 @@ snd_hda_jack_tbl_get(struct hda_codec *codec, hda_nid_t nid);
 struct hda_jack_tbl *
 snd_hda_jack_tbl_get_from_tag(struct hda_codec *codec, unsigned char tag);
 
-struct hda_jack_tbl *
-snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid);
 void snd_hda_jack_tbl_clear(struct hda_codec *codec);
 
 void snd_hda_jack_set_dirty_all(struct hda_codec *codec);
-- 
2.1.0
