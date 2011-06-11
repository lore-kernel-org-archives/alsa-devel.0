From: Florian Zeitz <florob@babelmonkeys.de>
Subject: [PATCH] [ALSA] emu10k1: Add details for E-mu 0404 PCIe
	version
Date: Sun, 12 Jun 2011 01:48:44 +0200
Message-ID: <4DF3FEDC.1060608@babelmonkeys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from babelmonkeys.de (v64231.topnetworks.de [78.46.149.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 2645924337
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jun 2011 01:48:59 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This patch adds the necessary details to support the PCIe version of
E-MU's 0404 card. I have tested this for some time now and it appears to
be working fine.

>From comparing the PCBs it seems the PCIe version just added a PCIe
chipset and left all other components pretty much in place.
For anyone intrigued to take a look at the PCB there are pictures I took
at <http://babelmonkeys.de/~florob/E-MU%200404/>.

This modification was made on top of Takashi Iwai's fix/misc branch.

Regards,
Florian Zeitz

---
 sound/pci/emu10k1/emu10k1_main.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c
b/sound/pci/emu10k1/emu10k1_main.c
index 5e619a8..15f0161 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1440,6 +1440,14 @@ static struct snd_emu_chip_details
emu_chip_details[] = {
 	 .ca0102_chip = 1,
 	 .spk71 = 1,
 	 .emu_model = EMU_MODEL_EMU0404}, /* EMU 0404 */
+	/* EMU0404 PCIe */
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40051102,
+	 .driver = "Audigy2", .name = "E-mu 0404 PCIe [MAEM8984]",
+	 .id = "EMU0404",
+	 .emu10k2_chip = 1,
+	 .ca0108_chip = 1,
+	 .spk71 = 1,
+	 .emu_model = EMU_MODEL_EMU0404}, /* EMU 0404 PCIe ver_03 */
 	/* Note that all E-mu cards require kernel 2.6 or newer. */
 	{.vendor = 0x1102, .device = 0x0008,
 	 .driver = "Audigy2", .name = "SB Audigy 2 Value [Unknown]",
-- 
1.7.5.4
