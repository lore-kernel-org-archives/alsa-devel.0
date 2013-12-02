From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix bad EAPD setup for HP machines
	with AD1984A
Date: Mon,  2 Dec 2013 13:32:21 +0100
Message-ID: <1385987541-4659-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 182812619F3
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 13:32:22 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E544BA7D41
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 13:32:21 +0100 (CET)
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

It seems that EAPD on NID 0x16 is the only control over all outputs on
HP machines with AD1984A while turning EAPD on NID 0x12 breaks the
output.  Thus we need to avoid fiddling EAPD on NID.  As a quick
workaround, just set own_eapd_ctrl flag for the wrong EAPD, then
implement finer EAPD controls.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66321
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 1a83559f4cbd..34d86ec5d3dd 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -962,6 +962,7 @@ static void ad1884_fixup_hp_eapd(struct hda_codec *codec,
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->gen.vmaster_mute.hook = ad1884_vmaster_hp_gpio_hook;
+		spec->gen.own_eapd_ctl = 1;
 		snd_hda_sequence_write_cache(codec, gpio_init_verbs);
 		break;
 	case HDA_FIXUP_ACT_PROBE:
-- 
1.8.4.4
