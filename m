From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/analog - Handle inverted EAPD
	properly in vmaster hook
Date: Mon,  2 Dec 2013 15:41:09 +0100
Message-ID: <1385995270-12297-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10AB1264F10
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:41:11 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D7988A7D88
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:41:10 +0100 (CET)
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

ad_vmaster_eapd_hook() needs to handle the inverted EAPD case
properly, too.  Otherwise the output gets broken on Lenovo N100 with
AD1986A codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=64971
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 34d86ec5d3dd..f6351b8e0f5d 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -147,6 +147,8 @@ static void ad_vmaster_eapd_hook(void *private_data, int enabled)
 
 	if (!spec->eapd_nid)
 		return;
+	if (codec->inv_eapd)
+		enabled = !enabled;
 	snd_hda_codec_update_cache(codec, spec->eapd_nid, 0,
 				   AC_VERB_SET_EAPD_BTLENABLE,
 				   enabled ? 0x02 : 0x00);
-- 
1.8.4.4
