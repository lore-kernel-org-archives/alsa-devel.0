From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Shutdown CX20722 on reboot/free to
	avoid spurious noises
Date: Fri, 21 Aug 2015 09:42:35 +0200
Message-ID: <1440142955-3985-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 16786260436
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 09:42:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1487345@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On shutdown/reboot of CX20722, first shut down all EAPDs, then
shut down the afg node to D3.

Failure to do so can lead to spurious noises from the internal speaker
directly after reboot (and before the codec is reinitialized again, i e
in BIOS setup or GRUB menus).

BugLink: https://bugs.launchpad.net/bugs/1487345
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f788a91..ca03c40 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -200,12 +200,33 @@ static int cx_auto_init(struct hda_codec *codec)
 	return 0;
 }
 
-#define cx_auto_free	snd_hda_gen_free
+static void cx_auto_reboot_notify(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (codec->core.vendor_id != 0x14f150f2)
+		return;
+
+	/* Turn the CX20722 codec into D3 to avoid spurious noises
+	   from the internal speaker during (and after) reboot */
+	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
+
+	snd_hda_codec_set_power_to_all(codec, codec->core.afg, AC_PWRST_D3);
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+}
+
+static void cx_auto_free(struct hda_codec *codec)
+{
+	cx_auto_reboot_notify(codec);
+	snd_hda_gen_free(codec);
+}
 
 static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_controls = cx_auto_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
+	.reboot_notify = cx_auto_reboot_notify,
 	.free = cx_auto_free,
 	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
-- 
1.9.1
