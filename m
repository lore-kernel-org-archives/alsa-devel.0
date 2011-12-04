From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: [PATCH] ALSA: hda: invert mute led polarity for HP
	laptops
Date: Sun, 04 Dec 2011 15:13:29 -0200
Message-ID: <1323018809.3883.2.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from horatio.sagui.org (horatio.sagui.org [173.230.138.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 08A931037FC
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 18:13:36 +0100 (CET)
Received: from oberon.sagui.org (unknown [189.101.188.123])
	by horatio.sagui.org (Postfix) with ESMTPSA id 075BDA08
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Dec 2011 15:13:31 -0200 (BRST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At least two HP laptop models with the IDT 92HD81B1X5 codec have the
polarity of the mute led inverted with respect to the current driver
default. Change the polarity for these machines only.

Signed-off-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
---
 sound/pci/hda/patch_sigmatel.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d8d2f9d..c920a27 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5601,6 +5601,16 @@ static void stac92hd8x_fill_auto_spec(struct hda_codec *codec)
 	spec->num_dmics = spec->auto_dmic_cnt;
 }
 
+static int stac92hd8x_hp_mute_led_polarity(struct hda_codec *codec)
+{
+	switch (codec->subsystem_id) {
+	case 0x103c1650:
+		return 1;
+	}
+	return 0;
+}
+
+
 static int patch_stac92hd83xxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -5642,7 +5652,7 @@ again:
 
 	codec->patch_ops = stac92xx_patch_ops;
 
-	if (find_mute_led_gpio(codec, 0))
+	if (find_mute_led_gpio(codec, stac92hd8x_hp_mute_led_polarity(codec)))
 		snd_printd("mute LED gpio %d polarity %d\n",
 				spec->gpio_led,
 				spec->gpio_led_polarity);
-- 
1.7.7.3
