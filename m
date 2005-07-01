From: Matt <matt@embeddedalley.com>
Subject: [PATCH][2/2] hda: add sigmatel hp detect support
Date: Fri, 1 Jul 2005 08:55:31 -0700
Message-ID: <20050701085531.B12830@cox.net>
References: <20050701084801.A12830@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050701084801.A12830@cox.net>; from matt@embeddedalley.com on Fri, Jul 01, 2005 at 08:48:01AM -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adds support for detecting hp insertion/removal and enable/disable of
lineouts based on unsolicited events.

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-kernel/pci/hda/hda_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.h,v
retrieving revision 1.9
diff -u -r1.9 hda_codec.h
--- alsa-kernel/pci/hda/hda_codec.h	10 Jun 2005 18:58:24 -0000	1.9
+++ alsa-kernel/pci/hda/hda_codec.h	1 Jul 2005 15:38:08 -0000
@@ -262,6 +262,9 @@
 #define AC_PINCTL_OUT_EN		(1<<6)
 #define AC_PINCTL_HP_EN			(1<<7)
 
+/* Unsolicited response - 8bit */
+#define AC_USRSP_EN			(1<<7)
+
 /* configuration default - 32bit */
 #define AC_DEFCFG_SEQUENCE		(0xf<<0)
 #define AC_DEFCFG_DEF_ASSOC		(0xf<<4)
Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.5
diff -u -r1.5 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	30 Jun 2005 09:54:33 -0000	1.5
+++ alsa-kernel/pci/hda/patch_sigmatel.c	1 Jul 2005 15:38:11 -0000
@@ -36,6 +36,10 @@
 
 #undef STAC_TEST
 
+#define NUM_CONTROL_ALLOC	32
+#define STAC_HP_EVENT		0x37
+#define STAC_UNSOL_ENABLE 	(AC_USRSP_EN | STAC_HP_EVENT)
+
 struct sigmatel_spec {
 	snd_kcontrol_new_t *mixers[4];
 	unsigned int num_mixers;
@@ -507,8 +511,6 @@
 	return 0;
 }
 
-#define NUM_CONTROL_ALLOC	32
-
 enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
@@ -617,10 +619,18 @@
 	hda_nid_t pin = cfg->hp_pin;
 	hda_nid_t nid;
 	int i, err;
+	unsigned int wid_caps;
 
 	if (! pin)
 		return 0;
 
+	wid_caps = snd_hda_param_read(codec, pin, AC_PAR_AUDIO_WIDGET_CAP);
+	if (wid_caps & AC_WCAP_UNSOL_CAP)
+		/* Enable unsolicited responses on the HP widget */
+		snd_hda_codec_write(codec, pin, 0,
+				AC_VERB_SET_UNSOLICITED_ENABLE,
+				STAC_UNSOL_ENABLE);
+
 	nid = snd_hda_codec_read(codec, pin, 0, AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
 	for (i = 0; i < cfg->line_outs; i++) {
 		if (! spec->multiout.dac_nids[i])
@@ -828,6 +838,53 @@
 	kfree(spec);
 }
 
+static void stac92xx_set_pinctl(struct hda_codec *codec, hda_nid_t nid,
+				unsigned int flag)
+{
+	unsigned int pin_ctl = snd_hda_codec_read(codec, nid,
+			0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0x00);
+	snd_hda_codec_write(codec, nid, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL,
+			pin_ctl | flag);
+}
+
+static void stac92xx_reset_pinctl(struct hda_codec *codec, hda_nid_t nid,
+				  unsigned int flag)
+{
+	unsigned int pin_ctl = snd_hda_codec_read(codec, nid,
+			0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0x00);
+	snd_hda_codec_write(codec, nid, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL,
+			pin_ctl & ~flag);
+}
+
+static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i, presence;
+
+	if ((res >> 26) != STAC_HP_EVENT)
+		return;
+
+	presence = snd_hda_codec_read(codec, cfg->hp_pin, 0,
+			AC_VERB_GET_PIN_SENSE, 0x00) >> 31;
+
+	if (presence) {
+		/* disable lineouts, enable hp */
+		for (i = 0; i < cfg->line_outs; i++)
+			stac92xx_reset_pinctl(codec, cfg->line_out_pins[i],
+						AC_PINCTL_OUT_EN);
+		stac92xx_set_pinctl(codec, cfg->hp_pin, AC_PINCTL_OUT_EN);
+	} else {
+		/* enable lineouts, disable hp */
+		for (i = 0; i < cfg->line_outs; i++)
+			stac92xx_set_pinctl(codec, cfg->line_out_pins[i],
+						AC_PINCTL_OUT_EN);
+		stac92xx_reset_pinctl(codec, cfg->hp_pin, AC_PINCTL_OUT_EN);
+	}
+} 
+
 #ifdef CONFIG_PM
 static int stac92xx_resume(struct hda_codec *codec)
 {
@@ -851,6 +908,7 @@
 	.build_pcms = stac92xx_build_pcms,
 	.init = stac92xx_init,
 	.free = stac92xx_free,
+	.unsol_event = stac92xx_unsol_event,
 #ifdef CONFIG_PM
 	.resume = stac92xx_resume,
 #endif


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
