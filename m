From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: fix sigmatel 9227/8/9 codec support
Date: Thu, 6 Jul 2006 11:48:31 -0500
Message-ID: <20060706164831.GA11413@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7100C178
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 18:42:38 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SigmaTel 9227/8/9 IDs must use the 927x patch.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r 0f0815e642ce pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Jul 06 15:13:00 2006 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Jul 06 09:27:10 2006 -0700
@@ -1524,12 +1524,12 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847681, .name = "STAC9220D/9223D A2", .patch = patch_stac922x },
  	{ .id = 0x83847682, .name = "STAC9221 A2", .patch = patch_stac922x },
  	{ .id = 0x83847683, .name = "STAC9221D A2", .patch = patch_stac922x },
- 	{ .id = 0x83847618, .name = "STAC9227", .patch = patch_stac922x },
- 	{ .id = 0x83847619, .name = "STAC9227", .patch = patch_stac922x },
- 	{ .id = 0x83847616, .name = "STAC9228", .patch = patch_stac922x },
- 	{ .id = 0x83847617, .name = "STAC9228", .patch = patch_stac922x },
- 	{ .id = 0x83847614, .name = "STAC9229", .patch = patch_stac922x },
- 	{ .id = 0x83847615, .name = "STAC9229", .patch = patch_stac922x },
+ 	{ .id = 0x83847618, .name = "STAC9227", .patch = patch_stac927x },
+ 	{ .id = 0x83847619, .name = "STAC9227", .patch = patch_stac927x },
+ 	{ .id = 0x83847616, .name = "STAC9228", .patch = patch_stac927x },
+ 	{ .id = 0x83847617, .name = "STAC9228", .patch = patch_stac927x },
+ 	{ .id = 0x83847614, .name = "STAC9229", .patch = patch_stac927x },
+ 	{ .id = 0x83847615, .name = "STAC9229", .patch = patch_stac927x },
  	{ .id = 0x83847620, .name = "STAC9274", .patch = patch_stac927x },
  	{ .id = 0x83847621, .name = "STAC9274D", .patch = patch_stac927x },
  	{ .id = 0x83847622, .name = "STAC9273X", .patch = patch_stac927x },

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
