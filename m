From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Always immediately update
	mute LED with pin VREF
Date: Sat, 17 Mar 2018 22:52:52 +0100
Message-ID: <20180317215252.27672-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8DC266F68
 for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2018 22:52:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 46063ABC8
 for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2018 21:52:53 +0000 (UTC)
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

Some HP laptops have a mute mute LED controlled by a pin VREF.  The
Realtek codec driver updates the VREF via vmaster hook by calling
snd_hda_set_pin_ctl_cache().

This works fine as long as the driver is running in a normal mode.
However, when the VREF change happens during the codec being in
runtime PM suspend, the regmap access will skip and postpone the
actual register change.  This ends up with the unchanged LED status
until the next runtime PM resume even if you change the Master mute
switch.  (Interestingly, the machine keeps the LED status even after
the codec goes into D3 -- but it's another story.)

For improving this usability, let the driver temporarily powering up /
down only during the pin VREF change.  This can be achieved easily by
wrapping the call with snd_hda_power_up_pm() / *_down_pm().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9af301c6bba2..5ef056f2aecc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3596,8 +3596,12 @@ static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 	pinval = snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);
 	pinval &= ~AC_PINCTL_VREFEN;
 	pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
-	if (spec->mute_led_nid)
+	if (spec->mute_led_nid) {
+		/* temporarily power up/down for setting VREF */
+		snd_hda_power_up_pm(codec);
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
+		snd_hda_power_down_pm(codec);
+	}
 }
 
 /* Make sure the led works even in runtime suspend */
-- 
2.16.2
