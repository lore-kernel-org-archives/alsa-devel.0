From: Maxim Kachur <mcdebugger@duganet.ru>
Subject: [PATCH] emu10k1: add chip details for E-mu 1010 PCIe
	card
Date: Wed, 17 Oct 2012 18:47:45 +0400
Message-ID: <507EC511.3050600@duganet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000400080100070300050704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EF59326522C
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 16:48:20 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id m15so4661425lah.38
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 07:48:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000400080100070300050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

emu10k1_main.c: Add chip details for E-mu 1010 PCIe card. It has the same
chip as found in E-mu 1010b but it uses different PCI id.

Signed-off-by: Maxim Kachur <mcdebugger@duganet.ru>
---
  sound/pci/emu10k1/emu10k1_main.c |    9 +++++++++
  1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c 
b/sound/pci/emu10k1/emu10k1_main.c
index bed4485..c21adb6 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1416,6 +1416,15 @@ static struct snd_emu_chip_details 
emu_chip_details[] = {
  	 .ca0108_chip = 1,
  	 .spk71 = 1,
  	 .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 new revision */
+	/* Tested by Maxim Kachur <mcdebugger@duganet.ru> 17th Oct 2012. */
+	/* This is MAEM8986, 0202 is MAEM8980 */
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40071102,
+	 .driver = "Audigy2", .name = "E-mu 1010 PCIe [MAEM8986]",
+	 .id = "EMU1010",
+	 .emu10k2_chip = 1,
+	 .ca0108_chip = 1,
+	 .spk71 = 1,
+	 .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 PCIe */
  	/* Tested by James@superbug.co.uk 8th July 2005. */
  	/* This is MAEM8810, 0202 is MAEM8820 */
  	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x40011102,
-- 
1.7.8.6


--------------000400080100070300050704
Content-Type: text/plain;
 name="Attached Message Part"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part"


--------------000400080100070300050704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000400080100070300050704--
