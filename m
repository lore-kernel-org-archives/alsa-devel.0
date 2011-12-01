From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix Realtek automute Line Out ->
	Internal Speaker
Date: Thu, 01 Dec 2011 07:48:35 +0100
Message-ID: <4ED72343.4060002@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030009080904060902080809"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C7FA103841
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 07:48:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030009080904060902080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch is a fixup for 3.0 and 3.1 only - 3.2 has a refactored 
automute for Realtek.

Takashi, could you ack this patch? I think Greg usually wants that 
before applying.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030009080904060902080809
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-Realtek-automute-Line-Out-Internal-Spea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-Realtek-automute-Line-Out-Internal-Spea.pa";
 filename*1="tch"

>From d494dd1f0689328b2c9a62fa168ff774928becc6 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 29 Nov 2011 09:19:45 +0100
Subject: [PATCH] ALSA: HDA: Fix Realtek automute Line Out -> Internal Speaker

In kernels 3.0 and 3.1, no automute control was created unless
Headphone pins were present. This patch enables automute for the
case where there are just Line Out and Speaker pins.

BugLink: http://bugs.launchpad.net/bugs/882693
Cc: stable@kernel.org (3.0 and 3.1)
Tested-by: Marc Legris <marc.legris@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e7dc034..c85ce60 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1605,7 +1605,7 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		spec->automute = 1;
 		spec->automute_mode = ALC_AUTOMUTE_PIN;
 	}
-	if (spec->automute && cfg->line_out_pins[0] &&
+	if (cfg->line_out_pins[0] &&
 	    cfg->speaker_pins[0] &&
 	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
 	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
@@ -1619,6 +1619,10 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 					AC_VERB_SET_UNSOLICITED_ENABLE,
 					AC_USRSP_EN | ALC880_FRONT_EVENT);
 			spec->detect_line = 1;
+			if (!spec->automute) {
+				spec->automute = 1;
+				spec->automute_mode = ALC_AUTOMUTE_PIN;
+			}
 		}
 		spec->automute_lines = spec->detect_line;
 	}
-- 
1.7.5.4


--------------030009080904060902080809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030009080904060902080809--
