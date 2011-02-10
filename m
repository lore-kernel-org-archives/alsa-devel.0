From: linux@audioscience.com
Subject: [PATCH 20/28] Clarify firmware id selection.
Date: Thu, 10 Feb 2011 17:26:13 +1300
Message-ID: <1297311981-30448-21-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi6205.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index 971c593..377e56f 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -1290,33 +1290,36 @@ static u16 adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	struct hpi_hw_obj *phw = pao->priv;
 	struct dsp_code dsp_code;
 	u16 boot_code_id[HPI6205_MAX_FILES_TO_LOAD];
-	u16 firmware_id = pao->pci.pci_dev->subsystem_device;
 	u32 temp;
 	int dsp = 0, i = 0;
 	u16 err = 0;
 
 	boot_code_id[0] = HPI_ADAPTER_ASI(0x6205);
 
-	/* special cases where firmware_id != subsys ID */
-	switch (firmware_id) {
+	boot_code_id[1] = pao->pci.pci_dev->subsystem_device;
+	boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(boot_code_id[1]);
+
+	/* fix up cases where bootcode id[1] != subsys id */
+	switch (boot_code_id[1]) {
 	case HPI_ADAPTER_FAMILY_ASI(0x5000):
-		boot_code_id[0] = firmware_id;
-		firmware_id = 0;
+		boot_code_id[0] = boot_code_id[1];
+		boot_code_id[1] = 0;
 		break;
 	case HPI_ADAPTER_FAMILY_ASI(0x5300):
 	case HPI_ADAPTER_FAMILY_ASI(0x5400):
 	case HPI_ADAPTER_FAMILY_ASI(0x6300):
-		firmware_id = HPI_ADAPTER_FAMILY_ASI(0x6400);
+		boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(0x6400);
 		break;
 	case HPI_ADAPTER_FAMILY_ASI(0x5600):
 	case HPI_ADAPTER_FAMILY_ASI(0x6500):
-		firmware_id = HPI_ADAPTER_FAMILY_ASI(0x6600);
+		boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(0x6600);
 		break;
 	case HPI_ADAPTER_FAMILY_ASI(0x8800):
-		firmware_id = HPI_ADAPTER_FAMILY_ASI(0x8900);
+		boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(0x8900);
+		break;
+	default:
 		break;
 	}
-	boot_code_id[1] = firmware_id;
 
 	/* reset DSP by writing a 1 to the WARMRESET bit */
 	temp = C6205_HDCR_WARMRESET;
-- 
1.7.0.4
