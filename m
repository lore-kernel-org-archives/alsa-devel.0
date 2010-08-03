From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH 2/2] Fix Thinkpad X300 so SPDIF is not exposed
Date: Tue, 03 Aug 2010 01:46:44 -0500
Message-ID: <1280818004.2529.237.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 773F0243B0
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 08:46:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Just as with the X301. The X300 does not have a way to do SPDIF either.
It does not have a dock connector, nor does it have the SPDIF through
the headphone jack.

This patch fixes it so X300 does not show SPDIF, since it cannot do it.

To add all Lenovo Thinkpads had different codec subsytem IDs:

X300:
http://launchpadlibrarian.net/34862838/Card0.Codecs.codec.0.txt

Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/pci/hda/patch_analog.c b/pci/hda/patch_analog.c
index afbe314..1fe6c77 100644
--- a/pci/hda/patch_analog.c
+++ b/pci/hda/patch_analog.c
@@ -3662,7 +3662,14 @@ static int patch_ad1984(struct hda_codec *codec)
 		codec->patch_ops.build_pcms = ad1984_build_pcms;
 		break;
 	case AD1984_THINKPAD:
-		spec->multiout.dig_out_nid = AD1884_SPDIF_OUT;
+		if (codec->subsystem_id == 0x17aa20fb) {
+			/* Thinpad X300 does not have the ability to do SPDIF,
+			   or attach to docking station to use SPDIF */
+			spec->multiout.dig_out_nid = 0;
+		}
+		else {
+			spec->multiout.dig_out_nid = AD1884_SPDIF_OUT;
+		}
 		spec->input_mux = &ad1984_thinkpad_capture_source;
 		spec->mixers[0] = ad1984_thinkpad_mixers;
 		spec->init_verbs[spec->num_init_verbs++] = ad1984_thinkpad_init_verbs;
