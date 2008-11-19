From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: EAPD mute on suspend
Date: Tue, 18 Nov 2008 20:54:17 -0500
Message-ID: <492371C9.2010407@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 21068244EF
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 02:54:32 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Moved support for EAPD mute on suspend from stac92hd71xx_suspend
to the generic stac92xx_suspend function.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index e0298df..900d99f 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -4077,7 +4077,17 @@ static int stac92xx_resume(struct hda_codec *codec)
 		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
 	return 0;
 }
-#endif
+
+static int stac92xx_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	if (spec->eapd_mask)
+		stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data &
+				~spec->eapd_mask);
+	return 0;
+}
+#endif

 static struct hda_codec_ops stac92xx_patch_ops = {
 	.build_controls = stac92xx_build_controls,
@@ -4087,6 +4097,7 @@ static struct hda_codec_ops stac92xx_patch_ops = {
 	.unsol_event = stac92xx_unsol_event,
 #ifdef SND_HDA_NEEDS_RESUME
 	.resume = stac92xx_resume,
+	.suspend = stac92xx_suspend,
 #endif
 };

@@ -4498,14 +4509,8 @@ static int stac92hd71xx_resume(struct hda_codec *codec)

 static int stac92hd71xx_suspend(struct hda_codec *codec, pm_message_t state)
 {
-	struct sigmatel_spec *spec = codec->spec;
-
-	stac92hd71xx_set_power_state(codec, AC_PWRST_D3);
-	if (spec->eapd_mask)
-		stac_gpio_set(codec, spec->gpio_mask,
-				spec->gpio_dir, spec->gpio_data &
-				~spec->eapd_mask);
-	return 0;
+	stac92hd71xx_set_power_state(codec, AC_PWRST_D3);	
+	return stac92xx_suspend(codec, state);
 };

 #endif
