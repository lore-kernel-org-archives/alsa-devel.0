From: eliot@blennerhassett.gen.nz
Subject: [PATCH 04/10] ALSA: asihpi: Use CONFIG_64BIT directly
Date: Thu, 20 Nov 2014 16:22:51 +1300
Message-ID: <1416453777-7155-5-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id AD7C9265870
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:42 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007V7IU4ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:40 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpi_internal.h | 16 ++++++++++------
 sound/pci/asihpi/hpios.h        |  4 ----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index bc86cb7..c9bdc28 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -554,17 +554,21 @@ struct hpi_pci {
 	struct pci_dev *pci_dev;
 };
 
+/** Adapter specification resource */
+struct hpi_adapter_specification {
+	u32 type;
+	u8 modules[4];
+};
+
 struct hpi_resource {
 	union {
 		const struct hpi_pci *pci;
 		const char *net_if;
+		struct hpi_adapter_specification adapter_spec;
+		const void *sw_if;
 	} r;
-#ifndef HPI64BIT		/* keep structure size constant */
-	u32 pad_to64;
-#endif
 	u16 bus_type;		/* HPI_BUS_PNPISA, _PCI, _USB etc */
 	u16 padding;
-
 };
 
 /** Format info used inside struct hpi_message
@@ -582,7 +586,7 @@ struct hpi_msg_format {
 struct hpi_msg_data {
 	struct hpi_msg_format format;
 	u8 *pb_data;
-#ifndef HPI64BIT
+#ifndef CONFIG_64BIT
 	u32 padding;
 #endif
 	u32 data_size;
@@ -595,7 +599,7 @@ struct hpi_data_legacy32 {
 	u32 data_size;
 };
 
-#ifdef HPI64BIT
+#ifdef CONFIG_64BIT
 /* Compatibility version of struct hpi_data*/
 struct hpi_data_compat32 {
 	struct hpi_msg_format format;
diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index d3fbd0d..d17d017 100644
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -41,10 +41,6 @@ HPI Operating System Specific macros for Linux Kernel driver
 
 #define HPI_NO_OS_FILE_OPS
 
-#ifdef CONFIG_64BIT
-#define HPI64BIT
-#endif
-
 /** Details of a memory area allocated with  pci_alloc_consistent
 Need all info for parameters to pci_free_consistent
 */
-- 
1.9.1
