From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 063/112] ALSA: hda - Fix wrong dirty check in
	snd_hda_codec_resume_amp()
Date: Tue,  8 Jan 2013 12:38:56 +0100
Message-ID: <1357645185-7645-64-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34FC62651FE
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 511ECA52EF
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

The dirty entry has to be checked at the beginning in the loop, not in
the inner loop for channels.  This caused a regression that the right
channel isn't properly written.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f362ef7..48591ab 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1969,6 +1969,9 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 		unsigned int idx, dir, ch;
 
 		buffer = snd_array_elem(&codec->amp_cache.buf, i);
+		if (!buffer->head.dirty)
+			continue;
+		buffer->head.dirty = 0;
 		key = buffer->head.key;
 		if (!key)
 			continue;
@@ -1978,9 +1981,6 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 		for (ch = 0; ch < 2; ch++) {
 			if (!(buffer->head.val & INFO_AMP_VOL(ch)))
 				continue;
-			if (!buffer->head.dirty)
-				continue;
-			buffer->head.dirty = 0;
 			mutex_unlock(&codec->hash_mutex);
 			put_vol_mute(codec, buffer, nid, ch, dir, idx,
 				     buffer->vol[ch]);
-- 
1.8.0.1
