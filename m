From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix EAPD GPIO control for
	Sigmatel codecs
Date: Fri, 19 Jul 2013 17:09:01 +0200
Message-ID: <1374246542-14244-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B54452652E7
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:07:48 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8B7FEA5387
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:07:48 +0200 (CEST)
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

The EAPD GPIO is dynamically turned on/off for some machines with
Sigmatel codecs, but this didn't work as expected, and it resulted in
spontaneous lost of speaker outputs per HP plugging or power-saving.

This patch fixes the bug by simply including spec->eapd_mask into
spec->gpio_mask and spec->gpio_data bits.

Reported-and-tested-by: Eric Shattow <lucent@gmail.com>
Cc: <stable@vger.kernel.org> [v3.9+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index e2f8359..766e567 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -417,9 +417,11 @@ static void stac_update_outputs(struct hda_codec *codec)
 			val &= ~spec->eapd_mask;
 		else
 			val |= spec->eapd_mask;
-		if (spec->gpio_data != val)
+		if (spec->gpio_data != val) {
+			spec->gpio_data = val;
 			stac_gpio_set(codec, spec->gpio_mask, spec->gpio_dir,
 				      val);
+		}
 	}
 }
 
@@ -3612,20 +3614,18 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 static int stac_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	unsigned int gpio;
 	int i;
 
 	/* override some hints */
 	stac_store_hints(codec);
 
 	/* set up GPIO */
-	gpio = spec->gpio_data;
 	/* turn on EAPD statically when spec->eapd_switch isn't set.
 	 * otherwise, unsol event will turn it on/off dynamically
 	 */
 	if (!spec->eapd_switch)
-		gpio |= spec->eapd_mask;
-	stac_gpio_set(codec, spec->gpio_mask, spec->gpio_dir, gpio);
+		spec->gpio_data |= spec->eapd_mask;
+	stac_gpio_set(codec, spec->gpio_mask, spec->gpio_dir, spec->gpio_data);
 
 	snd_hda_gen_init(codec);
 
@@ -3915,6 +3915,7 @@ static void stac_setup_gpio(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 
+	spec->gpio_mask |= spec->eapd_mask;
 	if (spec->gpio_led) {
 		if (!spec->vref_mute_led_nid) {
 			spec->gpio_mask |= spec->gpio_led;
-- 
1.8.3.1
