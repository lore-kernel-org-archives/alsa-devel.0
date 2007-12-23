From: "Veli-Matti Valtonen" <maligor@gmail.com>
Subject: [PATCH] Another EMU0404 Board ID
Date: Sun, 23 Dec 2007 23:36:32 +0200
Message-ID: <b0edb78a0712231336x469a30eeha122a86d255e7f64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id BA0D824554
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 22:36:33 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so763844fgb.44
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 13:36:32 -0800 (PST)
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

Hey,

This is based on pseudo-random playing around with the capabilities.
With ca0102 this card gives no output atall, ca0108 appears to work
fine, so it rather looks similar to the EMU1010b/EMU1010 changes.

Some other people seem to have succeeded in using this aswell:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3496

diff -u -r alsa-driver-hg20071222/alsa-kernel/pci/emu10k1/emu10k1_main.c
alsa-driver-hg20071222-0404b/alsa-kernel/pci/emu10k1/emu10k1_main.c
--- alsa-driver-hg20071222/alsa-kernel/pci/emu10k1/emu10k1_main.c	2007-12-22
03:00:09.000000000 +0200
+++ alsa-driver-hg20071222-0404b/alsa-kernel/pci/emu10k1/emu10k1_main.c	2007-12-23
23:01:12.807047391 +0200
@@ -1419,6 +1419,14 @@
 	 .ca0102_chip = 1,
 	 .spk71 = 1,
 	 .emu_model = EMU_MODEL_EMU1010}, /* Emu 1010 */
+	/* EMU0404b */
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40021102,
+	 .driver = "Audigy2", .name = "E-mu 0404b [4002]",
+	 .id = "EMU0404",
+	 .emu10k2_chip = 1,
+	 .ca0108_chip = 1,
+	 .spk71 = 1,
+	 .emu_model = EMU_MODEL_EMU0404}, /* EMU 0404 */
 	/* Tested by James@superbug.co.uk 20-3-2007. */
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x40021102,
 	 .driver = "Audigy2", .name = "E-mu 0404 [4002]",
