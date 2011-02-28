From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Realtek: Fixup jack detection to
	input subsystem
Date: Mon, 28 Feb 2011 16:07:20 +0100
Message-ID: <4D6BBA28.8080506@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060702070005020905070804"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B8DE24552
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 16:07:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060702070005020905070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060702070005020905070804
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Realtek-Fixup-jack-detection-to-input-subsy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Realtek-Fixup-jack-detection-to-input-subsy.pa";
 filename*1="tch"

>From 70f1b37d58c9c6322bb84368c9da299bfe2b0c57 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 28 Feb 2011 15:58:07 +0100
Subject: [PATCH] ALSA: HDA: Realtek: Fixup jack detection to input subsystem

This patch fixes an error in the jack detection reporting,
causing the jack detection sometimes not to be reported
correctly to the input subsystem. It should apply to several
Realtek codecs.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3328a25..c052fc5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1133,11 +1133,8 @@ static void alc_automute_speaker(struct hda_codec *codec, int pinctl)
 		nid = spec->autocfg.hp_pins[i];
 		if (!nid)
 			break;
-		if (snd_hda_jack_detect(codec, nid)) {
-			spec->jack_present = 1;
-			break;
-		}
-		alc_report_jack(codec, spec->autocfg.hp_pins[i]);
+		alc_report_jack(codec, nid);
+		spec->jack_present |= snd_hda_jack_detect(codec, nid);
 	}
 
 	mute = spec->jack_present ? HDA_AMP_MUTE : 0;
-- 
1.7.1


--------------060702070005020905070804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060702070005020905070804--
