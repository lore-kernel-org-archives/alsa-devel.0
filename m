From: Andrey Tataranovich <tataranovich@gmail.com>
Subject: Support for GT440 HDMI audio
Date: Tue, 6 Dec 2011 16:29:18 +0300
Message-ID: <20111206132918.GC2128@debbox.it>
Reply-To: Andrey Tataranovich <tataranovich@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 793F2103B98
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 14:28:49 +0100 (CET)
Received: by eaai13 with SMTP id i13so5132004eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 05:28:46 -0800 (PST)
Content-Disposition: inline
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

 Please include following patch to add support for NVidia GT440 HDMI audio.
This patch working for me on Debian Squeeze with patched alsa-source 1.0.23-dfsg+4.

-- 
WBR, Andrey Tataranovich

--bg08WKrSYDhXBjb5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gt440_hdmi.patch"

diff -uNrp alsa-driver-1.0.23+dfsg.orig/alsa-kernel//pci/hda/patch_nvhdmi.c alsa-driver-1.0.23+dfsg/alsa-kernel//pci/hda/patch_nvhdmi.c
--- alsa-driver-1.0.23+dfsg.orig/alsa-kernel//pci/hda/patch_nvhdmi.c	2010-04-16 14:10:10.000000000 +0300
+++ alsa-driver-1.0.23+dfsg/alsa-kernel//pci/hda/patch_nvhdmi.c	2011-11-24 12:13:59.000000000 +0300
@@ -556,6 +556,8 @@ static struct hda_codec_preset snd_hda_p
 	  .patch = patch_nvhdmi_8ch_89 },
 	{ .id = 0x10de000d, .name = "GT240 HDMI",
 	  .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0014, .name = "GT440 HDMI",
+	  .patch = patch_nvhdmi_8ch_89 },
 	{ .id = 0x10de0067, .name = "MCP67 HDMI", .patch = patch_nvhdmi_2ch },
 	{ .id = 0x10de8001, .name = "MCP73 HDMI", .patch = patch_nvhdmi_2ch },
 	{} /* terminator */
@@ -570,6 +572,7 @@ MODULE_ALIAS("snd-hda-codec-id:10de000a"
 MODULE_ALIAS("snd-hda-codec-id:10de000b");
 MODULE_ALIAS("snd-hda-codec-id:10de000c");
 MODULE_ALIAS("snd-hda-codec-id:10de000d");
+MODULE_ALIAS("snd-hda-codec-id:10de0014");
 MODULE_ALIAS("snd-hda-codec-id:10de0067");
 MODULE_ALIAS("snd-hda-codec-id:10de8001");
 

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bg08WKrSYDhXBjb5--
