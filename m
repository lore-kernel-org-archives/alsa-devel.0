From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: HDA: Add Front control for ALC887
Date: Fri, 19 Nov 2010 10:31:20 +0100
Message-ID: <4CE643E8.1090208@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050400000103080707060807"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ADE5243EC
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 10:31:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050400000103080707060807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

HP and Line out share DAC, so we need a switch to turn line out off.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050400000103080707060807
Content-Type: text/x-patch;
 name="0003-ALSA-HDA-Add-Front-control-for-ALC887.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-ALSA-HDA-Add-Front-control-for-ALC887.patch"

>From 955438a1e0f21218d207196456d8e46295f5feec Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 17 Nov 2010 15:06:15 +0100
Subject: [PATCH 3/3] ALSA: HDA: Add Front control for ALC887

HP and Line out share DAC, so we need a switch to turn line out off.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4cc7bb2..86df37c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10836,8 +10836,16 @@ static int alc882_parse_auto_config(struct hda_codec *codec)
 	err = alc880_auto_fill_dac_nids(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
-	if (codec->vendor_id == 0x10ec0887)
+	if (codec->vendor_id == 0x10ec0887) {
 		err = alc861vd_auto_create_multi_out_ctls(spec, &spec->autocfg);
+		if (err < 0)
+			return err;
+		/* We need something to switch that doesn't affect headphones */
+		if (spec->autocfg.line_out_pins[0])
+			err = add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, "Front",
+				  HDA_COMPOSE_AMP_VAL(spec->autocfg.line_out_pins[0], 3, 0, HDA_OUTPUT));
+
+        }
 	else
 		err = alc880_auto_create_multi_out_ctls(spec, &spec->autocfg);
 	if (err < 0)
-- 
1.7.1


--------------050400000103080707060807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050400000103080707060807--
