From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: hda - Remove locally dead codes
Date: Mon, 28 Oct 2013 14:14:08 +0100
Message-ID: <1382966050-12752-5-git-send-email-tiwai@suse.de>
References: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB6A26163E
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5FAEA5D9F
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:31 +0100 (CET)
In-Reply-To: <1382966050-12752-1-git-send-email-tiwai@suse.de>
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

Reported by coverity.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c     | 3 +--
 sound/pci/hda/patch_realtek.c | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0faab3b..de1a767 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2634,8 +2634,7 @@ static int map_slaves(struct hda_codec *codec, const char * const *slaves,
 	items = codec->mixers.list;
 	for (i = 0; i < codec->mixers.used; i++) {
 		struct snd_kcontrol *sctl = items[i].kctl;
-		if (!sctl || !sctl->id.name ||
-		    sctl->id.iface != SNDRV_CTL_ELEM_IFACE_MIXER)
+		if (!sctl || sctl->id.iface != SNDRV_CTL_ELEM_IFACE_MIXER)
 			continue;
 		for (s = slaves; *s; s++) {
 			char tmpname[sizeof(sctl->id.name)];
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1f0a040..8947035 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -554,8 +554,6 @@ do_sku:
 			nid = portd;
 		else if (tmp == 3)
 			nid = porti;
-		else
-			return 1;
 		if (found_in_nid_list(nid, spec->gen.autocfg.line_out_pins,
 				      spec->gen.autocfg.line_outs))
 			return 1;
-- 
1.8.4.1
