From: Sergey Korolev <slipped.on.blade@gmail.com>
Subject: [PATCH] ALSA: E-mu 1616m PCIe support
Date: Wed, 1 Feb 2012 22:33:09 +0400
Message-ID: <CAH2VuH7_2oRmpkvKc5zenJVPaeYAjJKpKkJ5w=Lk9AvdS909wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D873B24588
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 19:33:10 +0100 (CET)
Received: by ggnq4 with SMTP id q4so833459ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Feb 2012 10:33:10 -0800 (PST)
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

diff -urdN linux-2.6.36.orig/sound/pci/emu10k1/emu10k1_main.c
linux-2.6.36/sound/pci/emu10k1/emu10k1_main.c
--- linux-2.6.36.orig/sound/pci/emu10k1/emu10k1_main.c 2010-10-20
22:30:22.000000000 +0200
+++ linux-2.6.36/sound/pci/emu10k1/emu10k1_main.c 2011-01-21
17:48:11.440000537 +0100
@@ -1415,6 +1415,14 @@
  .ca0108_chip = 1,
  .spk71 = 1,
  .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 new revision */
+ /* Tested 21th Jan 2011. */
+ {.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40071102,
+ .driver = "Audigy2", .name = "E-mu 1010 PCIe",
+ .id = "EMU1010",
+ .emu10k2_chip = 1,
+ .ca0108_chip = 1,
+ .spk71 = 1,
+ .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 PCIe */
  /* Tested by James@superbug.co.uk 8th July 2005. */
  /* This is MAEM8810, 0202 is MAEM8820 */
  {.vendor = 0x1102, .device = 0x0004, .subsystem = 0x40011102,
