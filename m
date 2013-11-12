From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Check keep_eapd_on before inv_eapd
Date: Tue, 12 Nov 2013 11:39:00 +0100
Message-ID: <1384252740-12534-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC48D2619FA
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 11:39:01 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E01E0A73E6
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 11:39:00 +0100 (CET)
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

We don't change the EAPD bit in set_pin_eapd() if keep_eapd_on flag is
set by the codec driver and enable is false.  But, we also apply the
flipping of enable value according to inv_eapd flag in the same
function, and this confused the former check, handled as if it's
turned ON.  The inverted EAPD check must be applied after keep_eapd_on
check, instead.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 276f6e759bac..3067ed4fe3b2 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -796,10 +796,10 @@ static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
 	if (spec->own_eapd_ctl ||
 	    !(snd_hda_query_pin_caps(codec, pin) & AC_PINCAP_EAPD))
 		return;
-	if (codec->inv_eapd)
-		enable = !enable;
 	if (spec->keep_eapd_on && !enable)
 		return;
+	if (codec->inv_eapd)
+		enable = !enable;
 	snd_hda_codec_update_cache(codec, pin, 0,
 				   AC_VERB_SET_EAPD_BTLENABLE,
 				   enable ? 0x02 : 0x00);
-- 
1.8.4.2
