From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-es1968: Add ESS vendor ID to pm_whitelist
Date: Sun, 4 Nov 2012 23:34:58 +0100
Message-ID: <201211042334.59034.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Add generic ESS vendor ID to pm_whitelist. This should fix suspend on
all Maestro-2 and Maestro-2E based PCI cards.
Tested on Terratec DMX and SF64-PCE2.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2655,6 +2655,8 @@ static struct ess_device_list pm_whitelist[] __devinitdata = {
 	{ TYPE_MAESTRO2E, 0x1179 },
 	{ TYPE_MAESTRO2E, 0x14c0 },	/* HP omnibook 4150 */
 	{ TYPE_MAESTRO2E, 0x1558 },
+	{ TYPE_MAESTRO2E, 0x125d },	/* a PCI card, e.g. Terratec DMX */
+	{ TYPE_MAESTRO2, 0x125d },	/* a PCI card, e.g. SF64-PCE2 */
 };
 
 static struct ess_device_list mpu_blacklist[] __devinitdata = {
-- 
Ondrej Zary
