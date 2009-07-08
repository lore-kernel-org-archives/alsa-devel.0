From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: [PATCH 2.6.31-rc2] Missing volume controls for Intel HDA (ALC269/EeePC)
Date: Wed, 08 Jul 2009 15:29:49 +0100
Message-ID: <507D1B5CC4%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757327AbZGHOa5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a regression, introduced in aa202455eec51699e44f658530728162cefa1307
(in alsa-kernel) which I noticed when trying to use the headphone socket on
my EeeCPC 901: the output was *very* quiet, practically silent.

This patch corrects the control types to that which was obviously intended in
the referenced commit.

Signed-Off-By: Darren Salt <linux@youmustbejoking.demon.co.uk>

--- a/sound/pci/hda/patch_realtek.c	2009-07-05 17:30:41.000000000 +0100
+++ b/sound/pci/hda/patch_realtek.c	2009-07-08 14:50:38.000000000 +0100
@@ -12878,9 +12878,9 @@
 
 static struct snd_kcontrol_new alc269_eeepc_mixer[] = {
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x14, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 

-- 
| Darren Salt            | linux at youmustbejoking | nr. Ashington, | Doon
| using Debian GNU/Linux | or ds    ,demon,co,uk    | Northumberland | Army
|   <URL:http://www.youmustbejoking.demon.co.uk/progs.packages.html>

I have one illusion, and that's that I have no illusions.
