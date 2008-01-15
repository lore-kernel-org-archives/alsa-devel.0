From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] remove 11c1:1040 from patch_si3054.c id list
Date: Tue, 15 Jan 2008 20:04:19 +0200
Message-ID: <200801152004.20141.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kWPjHFS6IBVhCq4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 7657A2435C
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 19:04:36 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so2696682fgb.44
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 10:04:35 -0800 (PST)
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

--Boundary-00=_kWPjHFS6IBVhCq4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Codec with id 11c1:1040 sitting on hda bus isn't si3054-compatible.
It should be removed from patch_si3054.c id list

--Boundary-00=_kWPjHFS6IBVhCq4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="remove_11c1_1040_from_si3054.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove_11c1_1040_from_si3054.patch"

--- patch_si3054.c.old	2008-01-13 16:17:54.000000000 +0200
+++ patch_si3054.c	2008-01-15 20:00:40.000000000 +0200
@@ -286,7 +286,6 @@
 struct hda_codec_preset snd_hda_preset_si3054[] = {
  	{ .id = 0x163c3055, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x163c3155, .name = "Si3054", .patch = patch_si3054 },
- 	{ .id = 0x11c11040, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x11c13026, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x11c13055, .name = "Si3054", .patch = patch_si3054 },
  	{ .id = 0x11c13155, .name = "Si3054", .patch = patch_si3054 },

--Boundary-00=_kWPjHFS6IBVhCq4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_kWPjHFS6IBVhCq4--
