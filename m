From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Multichannel sound distortions with Realtek ALC889a
Date: Wed, 30 Jul 2008 10:11:32 +0200
Message-ID: <200807301011.34188.ml_alsa@mortal-soul.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2ICkIjVXIo8PygD"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 0369324465
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 10:11:36 +0200 (CEST)
Received: from marvin (88-134-158-176-dynip.superkabel.de [88.134.158.176])
	by dd15922.kasserver.com (Postfix) with ESMTP id E4D1A2C1D7F10
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 10:11:36 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_2ICkIjVXIo8PygD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

Earlier this month I already posted about my problems with the ALC889a chip. 
I've gathered some more informations that might help or inform others:

1) the ALC889a is a custom job for Gigabyte and Realtek is not allowed to
   release its data sheet to anyone but Gigabyte. So no data sheet on this
   one.

2) There seem to be two revisions of this chip. I was unable to confirm this
   with Realtek but my revision id is 0x100101 whereas ALSA expects 0x100103.

   Modifing patch_realtek.c appropriately to recognize my revision id and use
   patch_alc883 instead of patch_alc882, doesn't fix the problem but seems to
   help my initial volume problems.

3) Sound distortions only appear on the center channel while playing back
   multi channel content. They sound like voltage sizzling noise. Hard to
   explain. Muting all channels but the center channel makes those distortions
   disappear.

   A test under Vista revealed no distortions or anything like it. So a faulty
   chip is actually pretty unlikely.

Since three weeks I am in contact with Realtek about this problem but there is 
not much to report on that front yet except for a rather friendly and helpful 
contact. Unfortunately due to time constraints and other issues, the problem 
hasn't been confirmed nor denied yet by Realtek. They received a similar mb 
from Gigabyte and are planing on trying to reproduce that problem there.

To make a long story short, I'd appreciate if anyone with an ALC889a chip and 
a 5.1 setup could try to confirm this bug and post about it. If anyone knows 
a way how I could diagnose this further, I am open to suggestions...

Currently I tend to get myself an Asus Xonar D2X or similar and keep this as a 
reminder that one should never buy hardware that's not in some way or another 
open. :-( To defend myself, when I bought my board a few weeks back I was 
under the impression that _all_ HDA codecs work well with ALSA and at least 
there I wouldn't have to worry. Well... far from it. :(

Thanks a lot in advance for any suggestions or help.

Have a nice day,
Matthias Dahl

--Boundary-00=_2ICkIjVXIo8PygD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_realtek.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_realtek.c.diff"

--- patch_realtek.c.orig	2008-06-27 10:11:58.000000000 +0200
+++ patch_realtek.c	2008-07-11 11:46:17.000000000 +0200
@@ -6526,7 +6526,7 @@
 			break;
 		default:
 			/* ALC889A is handled better as ALC888-compatible */
-			if (codec->revision_id == 0x100103) {
+			if (codec->revision_id == 0x100103 || codec->revision_id == 0x100101) {
 				alc_free(codec);
 				return patch_alc883(codec);
 			}
@@ -14661,8 +14661,10 @@
 	{ .id = 0x10ec0880, .name = "ALC880", .patch = patch_alc880 },
 	{ .id = 0x10ec0882, .name = "ALC882", .patch = patch_alc882 },
 	{ .id = 0x10ec0883, .name = "ALC883", .patch = patch_alc883 },
-	{ .id = 0x10ec0885, .rev = 0x100103, .name = "ALC889A",
+	{ .id = 0x10ec0885, .rev = 0x100103, .name = "ALC889A rev2",
 	  .patch = patch_alc882 }, /* should be patch_alc883() in future */
+	{ .id = 0x10ec0885, .rev = 0x100101, .name = "ALC889A rev1",
+	  .patch = patch_alc883 },
 	{ .id = 0x10ec0885, .name = "ALC885", .patch = patch_alc882 },
 	{ .id = 0x10ec0888, .name = "ALC888", .patch = patch_alc883 },
 	{ .id = 0x10ec0889, .name = "ALC889", .patch = patch_alc883 },

--Boundary-00=_2ICkIjVXIo8PygD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_2ICkIjVXIo8PygD--
