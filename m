From: linux@audioscience.com
Subject: [PATCH 3/6] Add ASI5200 family.
Date: Tue, 06 Jul 2010 08:37:08 +1200
Message-ID: <1278362231-10160-4-git-send-email-linux@audioscience.com>
References: <1278362231-10160-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1278362231-10160-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi6000.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index 12dab5e..f7e374e 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -687,6 +687,7 @@ static short hpi6000_adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	switch (pao->pci.subsys_device_id) {
 	case 0x5100:
 	case 0x5110:	/* ASI5100 revB or higher with C6711D */
+	case 0x5200:	/* ASI5200 PC_ie version of ASI5100 */
 	case 0x6100:
 	case 0x6200:
 		boot_load_family = HPI_ADAPTER_FAMILY_ASI(0x6200);
@@ -1133,6 +1134,12 @@ static short hpi6000_adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 						subsys_device_id) ==
 					HPI_ADAPTER_FAMILY_ASI(0x5100))
 					mask = 0x00000000L;
+				/* ASI5200 uses AX6 code, */
+				/* but has no PLD r/w register to test */
+				if (HPI_ADAPTER_FAMILY_ASI(pao->pci.
+						subsys_device_id) ==
+					HPI_ADAPTER_FAMILY_ASI(0x5200))
+					mask = 0x00000000L;
 				break;
 			case HPI_ADAPTER_FAMILY_ASI(0x8800):
 				/* ASI8800 has 16bit path to FPGA */
-- 
1.7.0.4
