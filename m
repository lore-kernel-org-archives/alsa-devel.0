From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: add sigmatel 9227/9228/9229 ids
Date: Tue, 2 May 2006 22:53:46 -0700
Message-ID: <20060502225346.B6803@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DA75223
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 07:53:49 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adds support for the 9227/9228/9229 sigmatel hda codecs.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.22
diff -u -r1.22 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	27 Mar 2006 10:51:52 -0000	1.22
+++ alsa-kernel/pci/hda/patch_sigmatel.c	3 May 2006 05:50:49 -0000
@@ -1367,6 +1367,12 @@
  	{ .id = 0x83847681, .name = "STAC9220D/9223D A2", .patch = patch_stac922x },
  	{ .id = 0x83847682, .name = "STAC9221 A2", .patch = patch_stac922x },
  	{ .id = 0x83847683, .name = "STAC9221D A2", .patch = patch_stac922x },
+ 	{ .id = 0x83847618, .name = "STAC9227", .patch = patch_stac922x },
+ 	{ .id = 0x83847619, .name = "STAC9227", .patch = patch_stac922x },
+ 	{ .id = 0x83847616, .name = "STAC9228", .patch = patch_stac922x },
+ 	{ .id = 0x83847617, .name = "STAC9228", .patch = patch_stac922x },
+ 	{ .id = 0x83847614, .name = "STAC9229", .patch = patch_stac922x },
+ 	{ .id = 0x83847615, .name = "STAC9229", .patch = patch_stac922x },
  	{ .id = 0x83847620, .name = "STAC9274", .patch = patch_stac927x },
  	{ .id = 0x83847621, .name = "STAC9274D", .patch = patch_stac927x },
  	{ .id = 0x83847622, .name = "STAC9273X", .patch = patch_stac927x },


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
