From: Richard Samson <samson.richard@gmail.com>
Subject: [PATCH] add new Fermi 5xx codec IDs to snd-hda
Date: Mon, 28 Feb 2011 02:10:54 +0100
Message-ID: <1298855454.2347.27.camel@cartman.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A2B01037EE
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 02:10:57 +0100 (CET)
Received: by bwz10 with SMTP id 10so3550590bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2011 17:10:57 -0800 (PST)
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

Hello,

It's my first patch/post here, i'm not sure if this list is the right
place to suggest this patch.

To follow up a previous commit on snd-hda :
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commitdiff;h=9cf2657d05f9f9e04c3e113d68bf7cef5a942070

I added a new entry in patch_hdmi.c to get sound working on my own 560
Ti card :

--- patch_hdmi.c        2011-02-15 22:29:51.000000000 +0100
+++ patch_hdmi_GTX-560Ti.c      2011-02-27 23:52:56.984613414 +0100
@@ -1634,6 +1634,7 @@
 { .id = 0x10de0012, .name = "GPU 12 HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
 { .id = 0x10de0013, .name = "GPU 13 HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
 { .id = 0x10de0014, .name = "GPU 14 HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
+{ .id = 0x10de0016, .name = "GPU 16 HDMI/DP",   .patch =
patch_nvhdmi_8ch_89 },
 { .id = 0x10de0018, .name = "GPU 18 HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
 { .id = 0x10de0019, .name = "GPU 19 HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
 { .id = 0x10de001a, .name = "GPU 1a HDMI/DP",  .patch =
patch_nvhdmi_8ch_89 },
@@ -1676,6 +1677,7 @@
 MODULE_ALIAS("snd-hda-codec-id:10de0012");
 MODULE_ALIAS("snd-hda-codec-id:10de0013");
 MODULE_ALIAS("snd-hda-codec-id:10de0014");
+MODULE_ALIAS("snd-hda-codec-id:10de0016");
 MODULE_ALIAS("snd-hda-codec-id:10de0018");
 MODULE_ALIAS("snd-hda-codec-id:10de0019");
 MODULE_ALIAS("snd-hda-codec-id:10de001a");

I think other 5xx cards need new value also.

Regards,

---
Richard Samson
samson.richard@gmail.com
