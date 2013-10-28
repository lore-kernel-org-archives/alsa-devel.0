From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: hda - Fix possible NULL dereference
	in snd_hda_get_pin_label()
Date: Mon, 28 Oct 2013 14:14:06 +0100
Message-ID: <1382966050-12752-3-git-send-email-tiwai@suse.de>
References: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 52C7626160F
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9592A5E71
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

Fix a possible NULL access of indexp in fill_audio_out_name() called
from snd_hda_get_pin_label().

Spotted by coverity CID 402035.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 48a9d00..853c6a6 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -638,7 +638,7 @@ static int fill_audio_out_name(struct hda_codec *codec, hda_nid_t nid,
 			/* don't add channel suffix for Headphone controls */
 			int idx = get_hp_label_index(codec, nid, cfg->hp_pins,
 						     cfg->hp_outs);
-			if (idx >= 0)
+			if (idx >= 0 && indexp)
 				*indexp = idx;
 			sfx = "";
 		}
-- 
1.8.4.1
