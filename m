From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix pincfg at resume on Lenovo
	T470 dock
Date: Mon, 26 Feb 2018 15:42:36 +0100
Message-ID: <20180226144236.3913-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1642B267585
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:42:40 +0100 (CET)
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
Cc: kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

We've added a quirk to enable the recent Lenovo dock support, where it
overwrites the pin configs of NID 0x17 and 19, not only updating the
pin config cache.  It works right after the boot, but the problem is
that the pin configs are occasionally cleared when the machine goes to
PM.  Meanwhile the quirk writes the pin configs only at the pre-probe,
so this won't be applied any longer.

For addressing that issue, this patch moves the code to overwrite the
pin configs into HDA_FIXUP_ACT_INIT section so that it's always
applied at both probe and resume time.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195161
Fixes: 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ce28f7ce64e6..b9c93fa0a51c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4997,13 +4997,14 @@ static void alc_fixup_tpt470_dock(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+	} else if (action == HDA_FIXUP_ACT_INIT) {
 		/* Enable DOCK device */
 		snd_hda_codec_write(codec, 0x17, 0,
 			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
 		/* Enable DOCK device */
 		snd_hda_codec_write(codec, 0x19, 0,
 			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
-		snd_hda_apply_pincfgs(codec, pincfgs);
 	}
 }
 
-- 
2.16.2
