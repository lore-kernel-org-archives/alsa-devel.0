From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 2/6] ALSA: hda/ca0132: Delete redundant UNSOL
	event requests
Date: Fri, 15 Jun 2018 21:56:16 -0400
Message-ID: <20180616015620.26663-3-alastair.bridgewater@gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

During ca0132_init(), ca0132_init_unsol() is run before the
spec->spec_init_verbs are written.  ca0132_init_unsol() calls
snd_hda_jack_detect_enable_callback(), which requests UNSOL events
for three or four nodes, two of which were also (redundantly)
requested by spec_init_verbs.

Kill the redundant AC_VERB_SET_UNSOLICITED_ENABLE verbs.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e03461aab68c..bdd626bde267 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7462,7 +7462,7 @@ static void ca0132_config(struct hda_codec *codec)
 static int ca0132_prepare_verbs(struct hda_codec *codec)
 {
 /* Verbs + terminator (an empty element) */
-#define NUM_SPEC_VERBS 4
+#define NUM_SPEC_VERBS 2
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
@@ -7472,34 +7472,24 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	if (!spec->spec_init_verbs)
 		return -ENOMEM;
 
-	/* HP jack autodetection */
-	spec->spec_init_verbs[0].nid = spec->unsol_tag_hp;
-	spec->spec_init_verbs[0].param = AC_VERB_SET_UNSOLICITED_ENABLE;
-	spec->spec_init_verbs[0].verb = AC_USRSP_EN | spec->unsol_tag_hp;
-
-	/* MIC1 jack autodetection */
-	spec->spec_init_verbs[1].nid = spec->unsol_tag_amic1;
-	spec->spec_init_verbs[1].param = AC_VERB_SET_UNSOLICITED_ENABLE;
-	spec->spec_init_verbs[1].verb = AC_USRSP_EN | spec->unsol_tag_amic1;
-
 	/* config EAPD */
-	spec->spec_init_verbs[2].nid = 0x0b;
-	spec->spec_init_verbs[2].param = 0x78D;
-	spec->spec_init_verbs[2].verb = 0x00;
+	spec->spec_init_verbs[0].nid = 0x0b;
+	spec->spec_init_verbs[0].param = 0x78D;
+	spec->spec_init_verbs[0].verb = 0x00;
 
 	/* Previously commented configuration */
 	/*
-	spec->spec_init_verbs[3].nid = 0x0b;
-	spec->spec_init_verbs[3].param = AC_VERB_SET_EAPD_BTLENABLE;
+	spec->spec_init_verbs[2].nid = 0x0b;
+	spec->spec_init_verbs[2].param = AC_VERB_SET_EAPD_BTLENABLE;
+	spec->spec_init_verbs[2].verb = 0x02;
+
+	spec->spec_init_verbs[3].nid = 0x10;
+	spec->spec_init_verbs[3].param = 0x78D;
 	spec->spec_init_verbs[3].verb = 0x02;
 
 	spec->spec_init_verbs[4].nid = 0x10;
-	spec->spec_init_verbs[4].param = 0x78D;
+	spec->spec_init_verbs[4].param = AC_VERB_SET_EAPD_BTLENABLE;
 	spec->spec_init_verbs[4].verb = 0x02;
-
-	spec->spec_init_verbs[5].nid = 0x10;
-	spec->spec_init_verbs[5].param = AC_VERB_SET_EAPD_BTLENABLE;
-	spec->spec_init_verbs[5].verb = 0x02;
 	*/
 
 	/* Terminator: spec->spec_init_verbs[NUM_SPEC_VERBS-1] */
-- 
2.16.1
