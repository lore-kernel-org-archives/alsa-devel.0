From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 055/112] ALSA: hda - Clear dirty flag upon
	cache write
Date: Tue,  8 Jan 2013 12:38:48 +0100
Message-ID: <1357645185-7645-56-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0128D2651D5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 21A30A52C6
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

When verbs or amps are actually written to the hardware, we can clear
dirty flag so that the later snd_hda_codec_resume_*() calls can skip
these verbs / amps.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 650498b..44b525f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1848,6 +1848,7 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			    bool init_only)
 {
 	struct hda_amp_info *info;
+	unsigned int cache_only;
 
 	if (snd_BUG_ON(mask & ~0xff))
 		mask &= 0xff;
@@ -1865,10 +1866,9 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 		return 0;
 	}
 	info->vol[ch] = val;
-	if (codec->cached_write)
-		info->head.dirty = 1;
+	cache_only = info->head.dirty = codec->cached_write;
 	mutex_unlock(&codec->hash_mutex);
-	if (!codec->cached_write)
+	if (!cache_only)
 		put_vol_mute(codec, info, nid, ch, direction, idx, val);
 	return 1;
 }
@@ -3450,8 +3450,10 @@ int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 	int err;
 	struct hda_cache_head *c;
 	u32 key;
+	unsigned int cache_only;
 
-	if (!codec->cached_write) {
+	cache_only = codec->cached_write;
+	if (!cache_only) {
 		err = snd_hda_codec_write(codec, nid, direct, verb, parm);
 		if (err < 0)
 			return err;
@@ -3465,8 +3467,7 @@ int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 	c = get_alloc_hash(&codec->cmd_cache, key);
 	if (c)
 		c->val = parm;
-	if (codec->cached_write)
-		c->dirty = 1;
+	c->dirty = cache_only;
 	mutex_unlock(&codec->bus->cmd_mutex);
 	return 0;
 }
-- 
1.8.0.1
