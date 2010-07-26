From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda: Fixup commit 79c944ad (caused codec
 initialization failure)
Date: Tue, 27 Jul 2010 00:20:53 +0200
Message-ID: <4C4E0A45.3070008@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040206080406060608060907"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C125E24391
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 00:20:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040206080406060608060907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A recent commit in current HEAD (79c944ad) caused codecs not to be
detected in some cases, found on several Realtek codecs.

Please apply the attached fix for that problem.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040206080406060608060907
Content-Type: text/x-patch;
 name="0002-ALSA-hda-Fixup-commit-79c944ad-caused-codec-initiali.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-hda-Fixup-commit-79c944ad-caused-codec-initiali.pa";
 filename*1="tch"

>From 107d4057bed5037977b8b4c27ada11f14526e8cb Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 27 Jul 2010 00:10:34 +0200
Subject: [PATCH 1/1] ALSA: hda: Fixup commit 79c944ad (caused codec initialization failure)

Commit 79c944ad caused codecs not to be detected in some cases,
found on several Realtek codecs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8cd5da8..710f61a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -724,23 +724,24 @@ static int get_codec_name(struct hda_codec *codec)
  */
 static void /*__devinit*/ setup_fg_nodes(struct hda_codec *codec)
 {
-	int i, total_nodes, function_id;
+	int i, total_nodes, function_id, param_val;
 	hda_nid_t nid;
 
 	total_nodes = snd_hda_get_sub_nodes(codec, AC_NODE_ROOT, &nid);
 	for (i = 0; i < total_nodes; i++, nid++) {
-		function_id = snd_hda_param_read(codec, nid,
+		param_val = snd_hda_param_read(codec, nid,
 						AC_PAR_FUNCTION_TYPE);
+		function_id = param_val & 0xff;
 		switch (function_id) {
 		case AC_GRP_AUDIO_FUNCTION:
 			codec->afg = nid;
-			codec->afg_function_id = function_id & 0xff;
-			codec->afg_unsol = (function_id >> 8) & 1;
+			codec->afg_function_id = function_id;
+			codec->afg_unsol = (param_val >> 8) & 1;
 			break;
 		case AC_GRP_MODEM_FUNCTION:
 			codec->mfg = nid;
-			codec->mfg_function_id = function_id & 0xff;
-			codec->mfg_unsol = (function_id >> 8) & 1;
+			codec->mfg_function_id = function_id;
+			codec->mfg_unsol = (param_val >> 8) & 1;
 			break;
 		default:
 			break;
-- 
1.7.0.4


--------------040206080406060608060907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040206080406060608060907--
