From: mengdong.lin@intel.com
Subject: [PATCH 1/2] ALSA: hda/realtek - Remove depop delay for
	suspend and resume if applicable
Date: Fri, 29 Nov 2013 00:35:26 -0500
Message-ID: <6b1ded4b9b806846c363a508ebbb9dc859ae1787.1385703143.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB0B26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:32:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

From: Kailang Yang <kailang@realtek.com>

This patch defines a flag "no_depop_delay" in alc_spec. If this flag is set,
delay in alc_eapd_shutup and alc_resume will be skipped.

Machine-specific fixup can set this flag to reduce suspend/resume time, if
the codec and hardware analog design can avoid pop noise without this delay.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6366a66..503cf78 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -118,7 +118,8 @@ struct alc_spec {
 
 	int init_amp;
 	int codec_variant;	/* flag for other variants */
-	bool has_alc5505_dsp;
+	unsigned int has_alc5505_dsp:1;
+	unsigned int no_depop_delay:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -280,8 +281,11 @@ static void alc_auto_setup_eapd(struct hda_codec *codec, bool on)
  */
 static void alc_eapd_shutup(struct hda_codec *codec)
 {
+	struct alc_spec *spec = codec->spec;
+
 	alc_auto_setup_eapd(codec, false);
-	msleep(200);
+	if (!spec->no_depop_delay)
+		msleep(200);
 	snd_hda_shutup_pins(codec);
 }
 
@@ -863,7 +867,10 @@ static int alc_suspend(struct hda_codec *codec)
 #ifdef CONFIG_PM
 static int alc_resume(struct hda_codec *codec)
 {
-	msleep(150); /* to avoid pop noise */
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->no_depop_delay)
+		msleep(150); /* to avoid pop noise */
 	codec->patch_ops.init(codec);
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
@@ -4448,7 +4455,7 @@ static int patch_alc269(struct hda_codec *codec)
 	}
 
 	if (snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
-		spec->has_alc5505_dsp = true;
+		spec->has_alc5505_dsp = 1;
 		spec->init_hook = alc5505_dsp_init;
 	}
 
-- 
1.8.1.2
