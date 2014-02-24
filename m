From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Avoid codec D3 for keeping mute
	LED up on Lenovo Yxx0
Date: Mon, 24 Feb 2014 10:52:41 +0100
Message-ID: <1393235561-15733-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 440A9265327
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 10:52:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1A017ACA0
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 09:52:41 +0000 (UTC)
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

The GPIO line used for the mute LED control on Lenovo Yxx0 laptops is
cleared unexpectedly when the codec goes to D3, typically by
power-saving.  For avoiding it, add a power filter in the fixup.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=16373
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3829cb5ebc2b..817a52efe750 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4832,6 +4832,17 @@ static void alc662_led_gpio1_mute_hook(void *private_data, int enabled)
 				    spec->gpio_led);
 }
 
+/* avoid D3 for keeping GPIO up */
+static unsigned int gpio_led_power_filter(struct hda_codec *codec,
+					  hda_nid_t nid,
+					  unsigned int power_state)
+{
+	struct alc_spec *spec = codec->spec;
+	if (nid == codec->afg && power_state == AC_PWRST_D3 && spec->gpio_led)
+		return AC_PWRST_D0;
+	return power_state;
+}
+
 static void alc662_fixup_led_gpio1(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
-- 
1.8.5.2
