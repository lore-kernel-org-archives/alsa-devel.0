From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing va_end() call in
	snd_hda_codec_pcm_new()
Date: Mon, 27 Apr 2015 16:49:03 +0200
Message-ID: <1430146143-29579-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B48ED2605C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 16:49:04 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 71E40AB22
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 14:49:04 +0000 (UTC)
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

Reported by coverity CID 1296024.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 27333e0d8ebe..b49feff0a319 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -873,14 +873,15 @@ struct hda_pcm *snd_hda_codec_pcm_new(struct hda_codec *codec,
 	struct hda_pcm *pcm;
 	va_list args;
 
-	va_start(args, fmt);
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
 		return NULL;
 
 	pcm->codec = codec;
 	kref_init(&pcm->kref);
+	va_start(args, fmt);
 	pcm->name = kvasprintf(GFP_KERNEL, fmt, args);
+	va_end(args);
 	if (!pcm->name) {
 		kfree(pcm);
 		return NULL;
-- 
2.3.5
