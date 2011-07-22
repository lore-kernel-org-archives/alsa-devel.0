From: linux@audioscience.com
Subject: [PATCH 07/15] ALSA: asihpi - Remove unused structures,
 macros and functions
Date: Fri, 22 Jul 2011 15:52:48 +1200
Message-ID: <1311306785-23116-14-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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
 sound/pci/asihpi/hpi6205.c      |    6 ------
 sound/pci/asihpi/hpi_internal.h |   13 -------------
 sound/pci/asihpi/hpidspcd.c     |    1 -
 sound/pci/asihpi/hpimsgx.c      |    2 --
 sound/pci/asihpi/hpios.c        |    8 --------
 5 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 3e31a3f..3c75df8 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -658,9 +658,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 			hr.u.ax.info.num_outstreams +
 			hr.u.ax.info.num_instreams;
 
-		hpios_locked_mem_prepare((max_streams * 6) / 10, max_streams,
-			65536, pao->pci.pci_dev);
-
 		HPI_DEBUG_LOG(VERBOSE,
 			"got adapter info type %x index %d serial %d\n",
 			hr.u.ax.info.adapter_type, hr.u.ax.info.adapter_index,
@@ -709,9 +706,6 @@ static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 				[i]);
 			phw->outstream_host_buffer_size[i] = 0;
 		}
-
-	hpios_locked_mem_unprepare(pao->pci.pci_dev);
-
 	kfree(phw);
 }
 
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 848fb75..332fb59 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -32,12 +32,6 @@ HPI internal definitions
 #include "hpios.h"
 
 /* physical memory allocation */
-void hpios_locked_mem_init(void
-	);
-void hpios_locked_mem_free_all(void
-	);
-#define hpios_locked_mem_prepare(a, b, c, d);
-#define hpios_locked_mem_unprepare(a)
 
 /** Allocate and map an area of locked memory for bus master DMA operations.
 
@@ -1431,12 +1425,6 @@ struct hpi_control_cache_microphone {
 	char temp_padding[6];
 };
 
-struct hpi_control_cache_generic {
-	struct hpi_control_cache_info i;
-	u32 dw1;
-	u32 dw2;
-};
-
 struct hpi_control_cache_single {
 	union {
 		struct hpi_control_cache_info i;
@@ -1452,7 +1440,6 @@ struct hpi_control_cache_single {
 		struct hpi_control_cache_silencedetector silence;
 		struct hpi_control_cache_sampleclock clk;
 		struct hpi_control_cache_microphone microphone;
-		struct hpi_control_cache_generic generic;
 	} u;
 };
 
diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index a03eb86..c5c6531 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -36,7 +36,6 @@ struct dsp_code_private {
 #define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
 	    HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
 
-#include <linux/pci.h>
 /*-------------------------------------------------------------------*/
 short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
 	u32 *os_error_code)
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 111f774..83b7e73 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -186,7 +186,6 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr,
 		/* Initialize this module's internal state */
 		hpios_msgxlock_init(&msgx_lock);
 		memset(&hpi_entry_points, 0, sizeof(hpi_entry_points));
-		hpios_locked_mem_init();
 		/* Init subsys_findadapters response to no-adapters */
 		HPIMSGX__reset(HPIMSGX_ALLADAPTERS);
 		hpi_init_response(phr, HPI_OBJ_SUBSYSTEM,
@@ -197,7 +196,6 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr,
 	case HPI_SUBSYS_DRIVER_UNLOAD:
 		HPI_COMMON(phm, phr);
 		HPIMSGX__cleanup(HPIMSGX_ALLADAPTERS, h_owner);
-		hpios_locked_mem_free_all();
 		hpi_init_response(phr, HPI_OBJ_SUBSYSTEM,
 			HPI_SUBSYS_DRIVER_UNLOAD, 0);
 		return;
diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index 742ee12..ff2a19b 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -39,10 +39,6 @@ void hpios_delay_micro_seconds(u32 num_micro_sec)
 
 }
 
-void hpios_locked_mem_init(void)
-{
-}
-
 /** Allocated an area of locked memory for bus master DMA operations.
 
 On error, return -ENOMEM, and *pMemArea.size = 0
@@ -85,7 +81,3 @@ u16 hpios_locked_mem_free(struct consistent_dma_area *p_mem_area)
 		return 1;
 	}
 }
-
-void hpios_locked_mem_free_all(void)
-{
-}
-- 
1.7.0.4
