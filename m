From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Make sure mute LEDs stay on during
	runtime suspend (Realtek)
Date: Wed,  6 Nov 2013 10:50:44 +0100
Message-ID: <1383731444-6487-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AD12610A1
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:50:45 +0100 (CET)
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
Cc: David Henningsson <david.henningsson@canonical.com>, 1248465@bugs.launchpad.net, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Some HP machines with Realtek codecs have mute LEDs connected to VREF pins.
However when these go into runtime suspend, the pin powers down and its
pin control is disabled, thus disabling the LED too.

This patch fixes that issue by making sure that the pin stays in D0 with
correct pin control.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/1248465
Tested-by: Franz Hsieh <franz.hsieh@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a51f48c..0acbe82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2955,6 +2955,23 @@ static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
 }
 
+/* Make sure the led works even in runtime suspend */
+static unsigned int led_power_filter(struct hda_codec *codec,
+						  hda_nid_t nid,
+						  unsigned int power_state)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (power_state != AC_PWRST_D3 || nid != spec->mute_led_nid)
+		return power_state;
+
+	/* Set pin ctl again, it might have just been set to 0 */
+	snd_hda_set_pin_ctl(codec, nid,
+			    snd_hda_codec_get_pin_target(codec, nid));
+
+	return AC_PWRST_D0;
+}
+
 static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
 				     const struct hda_fixup *fix, int action)
 {
@@ -2974,6 +2991,7 @@ static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
 		spec->mute_led_nid = pin - 0x0a + 0x18;
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
+		codec->power_filter = led_power_filter;
 		snd_printd("Detected mute LED for %x:%d\n", spec->mute_led_nid,
 			   spec->mute_led_polarity);
 		break;
@@ -2989,6 +3007,7 @@ static void alc269_fixup_hp_mute_led_mic1(struct hda_codec *codec,
 		spec->mute_led_nid = 0x18;
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
+		codec->power_filter = led_power_filter;
 	}
 }
 
@@ -3001,6 +3020,7 @@ static void alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
 		spec->mute_led_nid = 0x19;
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
+		codec->power_filter = led_power_filter;
 	}
 }
 
-- 
1.7.9.5
