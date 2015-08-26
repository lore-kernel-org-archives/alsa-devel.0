From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Remove superfluous pcm NULL check
Date: Wed, 26 Aug 2015 15:23:55 +0200
Message-ID: <1440595435-1113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D29A3260522
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 15:23:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9D8FAAD7C
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 13:23:56 +0000 (UTC)
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

The variable pcm can be never NULL since it was rewritten with
list_for_each_entry().

Suggested-by: Markus Osterhoff <linux-kernel@k-raum.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2c021911f88a..37f43a1b34ef 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3102,8 +3102,7 @@ static int add_std_chmaps(struct hda_codec *codec)
 			struct snd_pcm_chmap *chmap;
 			const struct snd_pcm_chmap_elem *elem;
 
-			if (!pcm || !pcm->pcm || pcm->own_chmap ||
-			    !hinfo->substreams)
+			if (!pcm->pcm || pcm->own_chmap || !hinfo->substreams)
 				continue;
 			elem = hinfo->chmap ? hinfo->chmap : snd_pcm_std_chmaps;
 			err = snd_pcm_add_chmap_ctls(pcm->pcm, str, elem,
-- 
2.5.0
