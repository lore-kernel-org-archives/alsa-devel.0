From: linux@audioscience.com
Subject: [[PATCH] snd-asihpi: 7/8] Simplify driver unload
	cleanup.
Date: Tue, 05 Apr 2011 20:55:47 +1200
Message-ID: <1301993748-21113-7-git-send-email-linux@audioscience.com>
References: <1301993748-21113-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301993748-21113-1-git-send-email-linux@audioscience.com>
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

Replacing subsys_delete_adapter with adapter_delete
allows some special-case adapter lookup code to be removed.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi6000.c      |   39 +++++++-----------
 pci/asihpi/hpi6205.c      |   97 +++++++++++++++++++++++----------------------
 pci/asihpi/hpi_internal.h |   17 ++++----
 pci/asihpi/hpicmn.c       |    1 -
 pci/asihpi/hpimsgx.c      |   31 ++++++--------
 pci/asihpi/hpioctl.c      |   54 +++++++++++++------------
 6 files changed, 113 insertions(+), 126 deletions(-)

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index 3e3c2ef..09befda 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -200,8 +200,8 @@ static void hpi_read_block(struct dsp_obj *pdo, u32 address, u32 *pdata,
 static void subsys_create_adapter(struct hpi_message *phm,
 	struct hpi_response *phr);
 
-static void subsys_delete_adapter(struct hpi_message *phm,
-	struct hpi_response *phr);
+static void adapter_delete(struct hpi_adapter_obj *pao,
+	struct hpi_message *phm, struct hpi_response *phr);
 
 static void adapter_get_asserts(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm, struct hpi_response *phr);
@@ -222,9 +222,6 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
 	case HPI_SUBSYS_CREATE_ADAPTER:
 		subsys_create_adapter(phm, phr);
 		break;
-	case HPI_SUBSYS_DELETE_ADAPTER:
-		subsys_delete_adapter(phm, phr);
-		break;
 	default:
 		phr->error = HPI_ERROR_INVALID_FUNC;
 		break;
@@ -279,6 +276,10 @@ static void adapter_message(struct hpi_adapter_obj *pao,
 		adapter_get_asserts(pao, phm, phr);
 		break;
 
+	case HPI_ADAPTER_DELETE:
+		adapter_delete(pao, phm, phr);
+		break;
+
 	default:
 		hw_message(pao, phm, phr);
 		break;
@@ -333,26 +334,22 @@ void HPI_6000(struct hpi_message *phm, struct hpi_response *phr)
 {
 	struct hpi_adapter_obj *pao = NULL;
 
-	/* subsytem messages get executed by every HPI. */
-	/* All other messages are ignored unless the adapter index matches */
-	/* an adapter in the HPI */
-	/*HPI_DEBUG_LOG(DEBUG, "O %d,F %x\n", phm->wObject, phm->wFunction); */
-
-	/* if Dsp has crashed then do not communicate with it any more */
 	if (phm->object != HPI_OBJ_SUBSYSTEM) {
 		pao = hpi_find_adapter(phm->adapter_index);
 		if (!pao) {
-			HPI_DEBUG_LOG(DEBUG,
-				" %d,%d refused, for another HPI?\n",
-				phm->object, phm->function);
+			hpi_init_response(phr, phm->object, phm->function,
+				HPI_ERROR_BAD_ADAPTER_NUMBER);
+			HPI_DEBUG_LOG(DEBUG, "invalid adapter index: %d \n",
+				phm->adapter_index);
 			return;
 		}
 
+		/* Don't even try to communicate with crashed DSP */
 		if (pao->dsp_crashed >= 10) {
 			hpi_init_response(phr, phm->object, phm->function,
 				HPI_ERROR_DSP_HARDWARE);
-			HPI_DEBUG_LOG(DEBUG, " %d,%d dsp crashed.\n",
-				phm->object, phm->function);
+			HPI_DEBUG_LOG(DEBUG, "adapter %d dsp crashed\n",
+				phm->adapter_index);
 			return;
 		}
 	}
@@ -463,15 +460,9 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	phr->error = 0;
 }
 
-static void subsys_delete_adapter(struct hpi_message *phm,
-	struct hpi_response *phr)
+static void adapter_delete(struct hpi_adapter_obj *pao,
+	struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct hpi_adapter_obj *pao = NULL;
-
-	pao = hpi_find_adapter(phm->obj_index);
-	if (!pao)
-		return;
-
 	delete_adapter_obj(pao);
 	hpi_delete_adapter(pao);
 	phr->error = 0;
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index 620525b..5303734 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -152,8 +152,8 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 
 static void subsys_create_adapter(struct hpi_message *phm,
 	struct hpi_response *phr);
-static void subsys_delete_adapter(struct hpi_message *phm,
-	struct hpi_response *phr);
+static void adapter_delete(struct hpi_adapter_obj *pao,
+	struct hpi_message *phm, struct hpi_response *phr);
 
 static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	u32 *pos_error_code);
@@ -223,15 +223,13 @@ static u16 boot_loader_test_pld(struct hpi_adapter_obj *pao, int dsp_index);
 
 /*****************************************************************************/
 
-static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
+static void subsys_message(struct hpi_adapter_obj *pao,
+	struct hpi_message *phm, struct hpi_response *phr)
 {
 	switch (phm->function) {
 	case HPI_SUBSYS_CREATE_ADAPTER:
 		subsys_create_adapter(phm, phr);
 		break;
-	case HPI_SUBSYS_DELETE_ADAPTER:
-		subsys_delete_adapter(phm, phr);
-		break;
 	default:
 		phr->error = HPI_ERROR_INVALID_FUNC;
 		break;
@@ -279,6 +277,10 @@ static void adapter_message(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
 	switch (phm->function) {
+	case HPI_ADAPTER_DELETE:
+		adapter_delete(pao, phm, phr);
+		break;
+
 	default:
 		hw_message(pao, phm, phr);
 		break;
@@ -371,36 +373,17 @@ static void instream_message(struct hpi_adapter_obj *pao,
 /** Entry point to this HPI backend
  * All calls to the HPI start here
  */
-void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
+void _HPI_6205(struct hpi_adapter_obj *pao, struct hpi_message *phm,
+	struct hpi_response *phr)
 {
-	struct hpi_adapter_obj *pao = NULL;
-
-	/* subsytem messages are processed by every HPI.
-	 * All other messages are ignored unless the adapter index matches
-	 * an adapter in the HPI
-	 */
-	/* HPI_DEBUG_LOG(DEBUG, "HPI Obj=%d, Func=%d\n", phm->wObject,
-	   phm->wFunction); */
-
-	/* if Dsp has crashed then do not communicate with it any more */
-	if (phm->object != HPI_OBJ_SUBSYSTEM) {
-		pao = hpi_find_adapter(phm->adapter_index);
-		if (!pao) {
-			HPI_DEBUG_LOG(DEBUG,
-				" %d,%d refused, for another HPI?\n",
-				phm->object, phm->function);
-			return;
-		}
-
-		if ((pao->dsp_crashed >= 10)
-			&& (phm->function != HPI_ADAPTER_DEBUG_READ)) {
-			/* allow last resort debug read even after crash */
-			hpi_init_response(phr, phm->object, phm->function,
-				HPI_ERROR_DSP_HARDWARE);
-			HPI_DEBUG_LOG(WARNING, " %d,%d dsp crashed.\n",
-				phm->object, phm->function);
-			return;
-		}
+	if (pao && (pao->dsp_crashed >= 10)
+		&& (phm->function != HPI_ADAPTER_DEBUG_READ)) {
+		/* allow last resort debug read even after crash */
+		hpi_init_response(phr, phm->object, phm->function,
+			HPI_ERROR_DSP_HARDWARE);
+		HPI_DEBUG_LOG(WARNING, " %d,%d dsp crashed.\n", phm->object,
+			phm->function);
+		return;
 	}
 
 	/* Init default response  */
@@ -412,7 +395,7 @@ void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
 	case HPI_TYPE_MESSAGE:
 		switch (phm->object) {
 		case HPI_OBJ_SUBSYSTEM:
-			subsys_message(phm, phr);
+			subsys_message(pao, phm, phr);
 			break;
 
 		case HPI_OBJ_ADAPTER:
@@ -444,6 +427,26 @@ void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
 	}
 }
 
+void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
+{
+	struct hpi_adapter_obj *pao = NULL;
+
+	if (phm->object != HPI_OBJ_SUBSYSTEM) {
+		/* normal messages must have valid adapter index */
+		pao = hpi_find_adapter(phm->adapter_index);
+	} else {
+		/* subsys messages don't address an adapter */
+		_HPI_6205(NULL, phm, phr);
+		return;
+	}
+
+	if (pao)
+		_HPI_6205(pao, phm, phr);
+	else
+		hpi_init_response(phr, phm->object, phm->function,
+			HPI_ERROR_BAD_ADAPTER_NUMBER);
+}
+
 /*****************************************************************************/
 /* SUBSYSTEM */
 
@@ -491,13 +494,11 @@ static void subsys_create_adapter(struct hpi_message *phm,
 }
 
 /** delete an adapter - required by WDM driver */
-static void subsys_delete_adapter(struct hpi_message *phm,
-	struct hpi_response *phr)
+static void adapter_delete(struct hpi_adapter_obj *pao,
+	struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct hpi_adapter_obj *pao;
 	struct hpi_hw_obj *phw;
 
-	pao = hpi_find_adapter(phm->obj_index);
 	if (!pao) {
 		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 		return;
@@ -563,11 +564,12 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	}
 
 	err = adapter_boot_load_dsp(pao, pos_error_code);
-	if (err)
+	if (err) {
+		HPI_DEBUG_LOG(ERROR, "DSP code load failed\n");
 		/* no need to clean up as SubSysCreateAdapter */
 		/* calls DeleteAdapter on error. */
 		return err;
-
+	}
 	HPI_DEBUG_LOG(INFO, "load DSP code OK\n");
 
 	/* allow boot load even if mem alloc wont work */
@@ -604,6 +606,7 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 				control_cache.number_of_controls,
 				interface->control_cache.size_in_bytes,
 				p_control_cache_virtual);
+
 			if (!phw->p_cache)
 				err = HPI_ERROR_MEMORY_ALLOC;
 		}
@@ -675,16 +678,14 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 }
 
 /** Free memory areas allocated by adapter
- * this routine is called from SubSysDeleteAdapter,
+ * this routine is called from AdapterDelete,
   * and SubSysCreateAdapter if duplicate index
 */
 static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 {
-	struct hpi_hw_obj *phw;
+	struct hpi_hw_obj *phw = pao->priv;
 	int i;
 
-	phw = pao->priv;
-
 	if (hpios_locked_mem_valid(&phw->h_control_cache)) {
 		hpios_locked_mem_free(&phw->h_control_cache);
 		hpi_free_control_cache(phw->p_cache);
@@ -1275,6 +1276,7 @@ static u16 adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	case HPI_ADAPTER_FAMILY_ASI(0x6300):
 		boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(0x6400);
 		break;
+	case HPI_ADAPTER_FAMILY_ASI(0x5500):
 	case HPI_ADAPTER_FAMILY_ASI(0x5600):
 	case HPI_ADAPTER_FAMILY_ASI(0x6500):
 		boot_code_id[1] = HPI_ADAPTER_FAMILY_ASI(0x6600);
@@ -2059,7 +2061,6 @@ static int wait_dsp_ack(struct hpi_hw_obj *phw, int state, int timeout_us)
 static void send_dsp_command(struct hpi_hw_obj *phw, int cmd)
 {
 	struct bus_master_interface *interface = phw->p_interface_buffer;
-
 	u32 r;
 
 	interface->host_cmd = cmd;
@@ -2088,7 +2089,7 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 		phr->specific_error = sizeof(interface->u);
 		phr->size = sizeof(struct hpi_response_header);
 		HPI_DEBUG_LOG(ERROR,
-			"message len %d too big for buffer %zd \n", phm->size,
+			"message len %d too big for buffer %ld \n", phm->size,
 			sizeof(interface->u));
 		return 0;
 	}
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index af678be..d829a65 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -294,7 +294,7 @@ enum HPI_CONTROL_ATTRIBUTES {
 
 /* These defines are used to fill in protocol information for an Ethernet packet
     sent using HMI on CS18102 */
-/** ID supplied by Cirrius for ASI packets. */
+/** ID supplied by Cirrus for ASI packets. */
 #define HPI_ETHERNET_PACKET_ID                  0x85
 /** Simple packet - no special routing required */
 #define HPI_ETHERNET_PACKET_V1                  0x01
@@ -307,7 +307,7 @@ enum HPI_CONTROL_ATTRIBUTES {
 /** This packet must make its way to the host across the HPI interface */
 #define HPI_ETHERNET_PACKET_HOSTED_VIA_HPI_V1   0x41
 
-#define HPI_ETHERNET_UDP_PORT (44600)	/*!< UDP messaging port */
+#define HPI_ETHERNET_UDP_PORT 44600 /**< HPI UDP service */
 
 /** Default network timeout in milli-seconds. */
 #define HPI_ETHERNET_TIMEOUT_MS 500
@@ -397,14 +397,14 @@ enum HPI_FUNCTION_IDS {
 	HPI_SUBSYS_OPEN = HPI_FUNC_ID(SUBSYSTEM, 1),
 	HPI_SUBSYS_GET_VERSION = HPI_FUNC_ID(SUBSYSTEM, 2),
 	HPI_SUBSYS_GET_INFO = HPI_FUNC_ID(SUBSYSTEM, 3),
-	HPI_SUBSYS_FIND_ADAPTERS = HPI_FUNC_ID(SUBSYSTEM, 4),
+	/* HPI_SUBSYS_FIND_ADAPTERS     = HPI_FUNC_ID(SUBSYSTEM, 4), */
 	HPI_SUBSYS_CREATE_ADAPTER = HPI_FUNC_ID(SUBSYSTEM, 5),
 	HPI_SUBSYS_CLOSE = HPI_FUNC_ID(SUBSYSTEM, 6),
-	HPI_SUBSYS_DELETE_ADAPTER = HPI_FUNC_ID(SUBSYSTEM, 7),
+	/* HPI_SUBSYS_DELETE_ADAPTER    = HPI_FUNC_ID(SUBSYSTEM, 7), */
 	HPI_SUBSYS_DRIVER_LOAD = HPI_FUNC_ID(SUBSYSTEM, 8),
 	HPI_SUBSYS_DRIVER_UNLOAD = HPI_FUNC_ID(SUBSYSTEM, 9),
-	HPI_SUBSYS_READ_PORT_8 = HPI_FUNC_ID(SUBSYSTEM, 10),
-	HPI_SUBSYS_WRITE_PORT_8 = HPI_FUNC_ID(SUBSYSTEM, 11),
+	/* HPI_SUBSYS_READ_PORT_8               = HPI_FUNC_ID(SUBSYSTEM, 10), */
+	/* HPI_SUBSYS_WRITE_PORT_8              = HPI_FUNC_ID(SUBSYSTEM, 11), */
 	HPI_SUBSYS_GET_NUM_ADAPTERS = HPI_FUNC_ID(SUBSYSTEM, 12),
 	HPI_SUBSYS_GET_ADAPTER = HPI_FUNC_ID(SUBSYSTEM, 13),
 	HPI_SUBSYS_SET_NETWORK_INTERFACE = HPI_FUNC_ID(SUBSYSTEM, 14),
@@ -433,7 +433,8 @@ enum HPI_FUNCTION_IDS {
 	HPI_ADAPTER_DEBUG_READ = HPI_FUNC_ID(ADAPTER, 18),
 	HPI_ADAPTER_IRQ_QUERY_AND_CLEAR = HPI_FUNC_ID(ADAPTER, 19),
 	HPI_ADAPTER_IRQ_CALLBACK = HPI_FUNC_ID(ADAPTER, 20),
-#define HPI_ADAPTER_FUNCTION_COUNT 20
+	HPI_ADAPTER_DELETE = HPI_FUNC_ID(ADAPTER, 21),
+#define HPI_ADAPTER_FUNCTION_COUNT 21
 
 	HPI_OSTREAM_OPEN = HPI_FUNC_ID(OSTREAM, 1),
 	HPI_OSTREAM_CLOSE = HPI_FUNC_ID(OSTREAM, 2),
@@ -1561,8 +1562,6 @@ void hpi_send_recv(struct hpi_message *phm, struct hpi_response *phr);
 u16 hpi_subsys_create_adapter(const struct hpi_resource *p_resource,
 	u16 *pw_adapter_index);
 
-u16 hpi_subsys_delete_adapter(u16 adapter_index);
-
 u16 hpi_outstream_host_buffer_get_info(u32 h_outstream, u8 **pp_buffer,
 	struct hpi_hostbuffer_status **pp_status);
 
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 3e9c5c2..0428f28 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -667,7 +667,6 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
 		phr->u.s.num_adapters = adapters.gw_num_adapters;
 		break;
 	case HPI_SUBSYS_CREATE_ADAPTER:
-	case HPI_SUBSYS_DELETE_ADAPTER:
 		break;
 	default:
 		phr->error = HPI_ERROR_INVALID_FUNC;
diff --git a/pci/asihpi/hpimsgx.c b/pci/asihpi/hpimsgx.c
index bcbdf30..888e379 100644
--- a/pci/asihpi/hpimsgx.c
+++ b/pci/asihpi/hpimsgx.c
@@ -211,24 +211,6 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr,
 		HPIMSGX__init(phm, phr);
 		break;
 
-	case HPI_SUBSYS_DELETE_ADAPTER:
-		HPIMSGX__cleanup(phm->obj_index, h_owner);
-		{
-			struct hpi_message hm;
-			struct hpi_response hr;
-			hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-				HPI_ADAPTER_CLOSE);
-			hm.adapter_index = phm->obj_index;
-			hw_entry_point(&hm, &hr);
-		}
-		if ((phm->obj_index < HPI_MAX_ADAPTERS)
-			&& hpi_entry_points[phm->obj_index]) {
-			hpi_entry_points[phm->obj_index] (phm, phr);
-			hpi_entry_points[phm->obj_index] = NULL;
-		} else
-			phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
-
-		break;
 	default:
 		/* Must explicitly handle every subsys message in this switch */
 		hpi_init_response(phr, HPI_OBJ_SUBSYSTEM, phm->function,
@@ -247,6 +229,19 @@ static void adapter_message(struct hpi_message *phm, struct hpi_response *phr,
 	case HPI_ADAPTER_CLOSE:
 		adapter_close(phm, phr);
 		break;
+	case HPI_ADAPTER_DELETE:
+		HPIMSGX__cleanup(phm->adapter_index, h_owner);
+		{
+			struct hpi_message hm;
+			struct hpi_response hr;
+			hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+				HPI_ADAPTER_CLOSE);
+			hm.adapter_index = phm->adapter_index;
+			hw_entry_point(&hm, &hr);
+		}
+		hw_entry_point(phm, phr);
+		break;
+
 	default:
 		hw_entry_point(phm, phr);
 		break;
diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 26186be..844295e 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -25,6 +25,7 @@ Common Linux HPI ioctl and module probe/remove functions
 #include "hpidebug.h"
 #include "hpimsgx.h"
 #include "hpioctl.h"
+#include "hpicmn.h"
 
 #include <linux/fs.h>
 #include <linux/slab.h>
@@ -156,26 +157,24 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		goto out;
 	}
 
-	pa = &adapters[hm->h.adapter_index];
+	switch (hm->h.function) {
+	case HPI_SUBSYS_CREATE_ADAPTER:
+	case HPI_ADAPTER_DELETE:
+		/* Application must not use these functions! */
+		hr->h.size = sizeof(hr->h);
+		hr->h.error = HPI_ERROR_INVALID_OPERATION;
+		hr->h.function = hm->h.function;
+		uncopied_bytes = copy_to_user(puhr, hr, hr->h.size);
+		if (uncopied_bytes)
+			err = -EFAULT;
+		else
+			err = 0;
+		goto out;
+	}
+
 	hr->h.size = res_max_size;
 	if (hm->h.object == HPI_OBJ_SUBSYSTEM) {
-		switch (hm->h.function) {
-		case HPI_SUBSYS_CREATE_ADAPTER:
-		case HPI_SUBSYS_DELETE_ADAPTER:
-			/* Application must not use these functions! */
-			hr->h.size = sizeof(hr->h);
-			hr->h.error = HPI_ERROR_INVALID_OPERATION;
-			hr->h.function = hm->h.function;
-			uncopied_bytes = copy_to_user(puhr, hr, hr->h.size);
-			if (uncopied_bytes)
-				err = -EFAULT;
-			else
-				err = 0;
-			goto out;
-
-		default:
-			hpi_send_recv_f(&hm->m0, &hr->r0, file);
-		}
+		hpi_send_recv_f(&hm->m0, &hr->r0, file);
 	} else {
 		u16 __user *ptr = NULL;
 		u32 size = 0;
@@ -183,8 +182,9 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
 		u32 adapter = hm->h.adapter_index;
+		pa = &adapters[adapter];
 
-		if ((hm->h.adapter_index > HPI_MAX_ADAPTERS) || (!pa->type)) {
+		if ((adapter > HPI_MAX_ADAPTERS) || (!pa->type)) {
 			hpi_init_response(&hr->r0, HPI_OBJ_ADAPTER,
 				HPI_ADAPTER_OPEN,
 				HPI_ERROR_BAD_ADAPTER_NUMBER);
@@ -390,17 +390,20 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 
 	adapter.index = hr.u.s.adapter_index;
 	adapter.type = hr.u.s.adapter_type;
+
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+		HPI_ADAPTER_OPEN);
 	hm.adapter_index = adapter.index;
+	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
-	err = hpi_adapter_open(adapter.index);
-	if (err)
+	if (hr.error)
 		goto err;
 
 	adapter.snd_card_asihpi = NULL;
 	/* WARNING can't init mutex in 'adapter'
 	 * and then copy it to adapters[] ?!?!
 	 */
-	adapters[hr.u.s.adapter_index] = adapter;
+	adapters[adapter.index] = adapter;
 	mutex_init(&adapters[adapter.index].mutex);
 	pci_set_drvdata(pci_dev, &adapters[adapter.index]);
 
@@ -435,10 +438,9 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 	struct hpi_adapter *pa;
 	pa = pci_get_drvdata(pci_dev);
 
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_SUBSYSTEM,
-		HPI_SUBSYS_DELETE_ADAPTER);
-	hm.obj_index = pa->index;
-	hm.adapter_index = HPI_ADAPTER_INDEX_INVALID;
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+		HPI_ADAPTER_DELETE);
+	hm.adapter_index = pa->index;
 	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
 	/* unmap PCI memory space, mapped during device init. */
-- 
1.7.0.4
