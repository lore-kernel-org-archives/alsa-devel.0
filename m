From: robbat2@gentoo.org
Subject: [PATCH] ALSA: HDA: patch_analog: Implement multiple
	outputs for AD1988
Date: Sat, 13 Sep 2008 16:54:58 -0700
Message-ID: <1221350101-11772-2-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ABF8245DF
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Sep 2008 01:55:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@gentoo.org>
List-Id: alsa-devel@alsa-project.org

From: Robin H. Johnson <robbat2@gentoo.org>

Implement the slave_dig_outs for AD1989 cards. Untested due to lack of
hardware.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 0899b6b..b037324 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1826,9 +1826,14 @@ static hda_nid_t ad1988_capsrc_nids[3] = {
 	0x0c, 0x0d, 0x0e
 };
 
-#define AD1988_SPDIF_OUT	0x02
+#define AD1988_SPDIF_OUT		0x02
+#define AD1988_SPDIF_OUT_HDMI	0x0b
 #define AD1988_SPDIF_IN		0x07
 
+static hda_nid_t ad1989b_slave_dig_outs[2] = {
+	AD1988_SPDIF_OUT, AD1988_SPDIF_OUT_HDMI
+};
+
 static struct hda_input_mux ad1988_6stack_capture_source = {
 	.num_items = 5,
 	.items = {
@@ -2143,6 +2148,7 @@ static struct snd_kcontrol_new ad1988_spdif_in_mixers[] = {
 
 static struct snd_kcontrol_new ad1989_spdif_out_mixers[] = {
 	HDA_CODEC_VOLUME("IEC958 Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("HDMI Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -2981,6 +2987,7 @@ static int patch_ad1988(struct hda_codec *codec)
 				ad1989_spdif_out_mixers;
 			spec->init_verbs[spec->num_init_verbs++] =
 				ad1989_spdif_init_verbs;
+			codec->slave_dig_outs = ad1989b_slave_dig_outs;
 		} else {
 			spec->mixers[spec->num_mixers++] =
 				ad1988_spdif_out_mixers;
-- 
1.6.0.1
