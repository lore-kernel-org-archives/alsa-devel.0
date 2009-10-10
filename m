From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 21/30] ALSA: HDA VIA: Move backdoor verbs to
	vt17xx_volume_init_verb
Date: Sat, 10 Oct 2009 19:08:32 +0800
Message-ID: <4AD06B30.9080303@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 00337103BA2
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:08:25 +0200 (CEST)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Move backdoor verbs to vt17xx_volume_init_verb

As init verbs, vt17xx_volume_init_verb is a better place to hold them.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3085,6 +3085,8 @@
 	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* Enable Mic Boost Volume backdoor */
 	{0x1, 0xf98, 0x1},
+	/* don't bybass mixer */
+	{0x1, 0xf88, 0xc0},
 	{ }
 };
 
@@ -3544,6 +3546,10 @@
 	/* PW6 PW7 Output enable */
 	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{0x1C, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	/* mixer enable */
+	{0x1, 0xF88, 0x3},
+	/* GPIO 0~2 */
+	{0x1, 0xF82, 0x3F},
 	{ }
 };
 
@@ -3785,8 +3791,6 @@
 {
 	struct via_spec *spec;
 	int err;
-	unsigned int response;
-	unsigned char control;
 
 	/* create a codec specific record */
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -3831,18 +3835,6 @@
 	spec->loopback.amplist = vt1702_loopbacks;
 #endif
 
-	/* Open backdoor */
-	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF8C, 0);
-	control = (unsigned char)(response & 0xff);
-	control |= 0x3;
-	snd_hda_codec_write(codec,  codec->afg, 0, 0xF88, control);
-
-	/* Enable GPIO 0&1 for volume&mute control */
-	/* Enable GPIO 2 for DMIC-DATA */
-	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF84, 0);
-	control = (unsigned char)((response >> 16) & 0x3f);
-	snd_hda_codec_write(codec,  codec->afg, 0, 0xF82, control);
-
 	return 0;
 }
