From: linux@audioscience.com
Subject: [PATCH 21/28] Remove unused code and data.
Date: Thu, 10 Feb 2011 17:26:14 +1300
Message-ID: <1297311981-30448-22-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi6205.c      |   37 +---------------
 pci/asihpi/hpi_internal.h |    4 --
 pci/asihpi/hpifunc.c      |  106 ---------------------------------------------
 3 files changed, 1 insertions(+), 146 deletions(-)

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index 377e56f..33136cb 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -127,9 +127,6 @@ struct hpi_hw_obj {
 	u32 outstream_host_buffer_size[HPI_MAX_STREAMS];
 
 	struct consistent_dma_area h_control_cache;
-	struct consistent_dma_area h_async_event_buffer;
-/*      struct hpi_control_cache_single *pControlCache; */
-	struct hpi_async_event *p_async_event_buffer;
 	struct hpi_control_cache *p_cache;
 };
 
@@ -625,34 +622,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 			pao->has_control_cache = 0;
 		}
 	}
-	/* allocate bus mastering async buffer and tell the DSP about it */
-	if (interface->async_buffer.b.size) {
-		err = hpios_locked_mem_alloc(&phw->h_async_event_buffer,
-			interface->async_buffer.b.size *
-			sizeof(struct hpi_async_event), pao->pci.pci_dev);
-		if (!err)
-			err = hpios_locked_mem_get_virt_addr
-				(&phw->h_async_event_buffer, (void *)
-				&phw->p_async_event_buffer);
-		if (!err)
-			memset((void *)phw->p_async_event_buffer, 0,
-				interface->async_buffer.b.size *
-				sizeof(struct hpi_async_event));
-		if (!err) {
-			err = hpios_locked_mem_get_phys_addr
-				(&phw->h_async_event_buffer, &phys_addr);
-			interface->async_buffer.physical_address32 =
-				phys_addr;
-		}
-		if (err) {
-			if (hpios_locked_mem_valid(&phw->
-					h_async_event_buffer)) {
-				hpios_locked_mem_free
-					(&phw->h_async_event_buffer);
-				phw->p_async_event_buffer = NULL;
-			}
-		}
-	}
 	send_dsp_command(phw, H620_HIF_IDLE);
 
 	{
@@ -716,11 +685,6 @@ static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 
 	phw = pao->priv;
 
-	if (hpios_locked_mem_valid(&phw->h_async_event_buffer)) {
-		hpios_locked_mem_free(&phw->h_async_event_buffer);
-		phw->p_async_event_buffer = NULL;
-	}
-
 	if (hpios_locked_mem_valid(&phw->h_control_cache)) {
 		hpios_locked_mem_free(&phw->h_control_cache);
 		hpi_free_control_cache(phw->p_cache);
@@ -1126,6 +1090,7 @@ static void instream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 		status->auxiliary_data_available = 0;
 
 		hw_message(pao, phm, phr);
+
 		if (phr->error
 			&& hpios_locked_mem_valid(&phw->
 				instream_host_buffers[phm->obj_index])) {
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 9908160..06a8779 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -1541,10 +1541,6 @@ u32 hpi_indexes_to_handle(const char c_object, const u16 adapter_index,
 /* main HPI entry point */
 void hpi_send_recv(struct hpi_message *phm, struct hpi_response *phr);
 
-/* UDP message */
-void hpi_send_recvUDP(struct hpi_message *phm, struct hpi_response *phr,
-	const unsigned int timeout);
-
 /* used in PnP OS/driver */
 u16 hpi_subsys_create_adapter(const struct hpi_resource *p_resource,
 	u16 *pw_adapter_index);
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index b79eba1..3aa1f09 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -263,112 +263,6 @@ u16 hpi_adapter_get_module_by_index(u16 adapter_index, u16 module_index,
 	return hr.error;
 }
 
-u16 hpi_adapter_get_assert2(u16 adapter_index, u16 *p_assert_count,
-	char *psz_assert, u32 *p_param1, u32 *p_param2,
-	u32 *p_dsp_string_addr, u16 *p_processor_id)
-{
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-		HPI_ADAPTER_GET_ASSERT);
-	hm.adapter_index = adapter_index;
-
-	hpi_send_recv(&hm, &hr);
-
-	*p_assert_count = 0;
-
-	if (!hr.error) {
-		*p_assert_count = hr.u.ax.assert.count;
-
-		if (*p_assert_count) {
-			*p_param1 = hr.u.ax.assert.p1;
-			*p_param2 = hr.u.ax.assert.p2;
-			*p_processor_id = hr.u.ax.assert.dsp_index;
-			*p_dsp_string_addr = hr.u.ax.assert.dsp_msg_addr;
-			memcpy(psz_assert, hr.u.ax.assert.sz_message,
-				HPI_STRING_LEN);
-		} else {
-			*psz_assert = 0;
-		}
-	}
-	return hr.error;
-}
-
-u16 hpi_adapter_test_assert(u16 adapter_index, u16 assert_id)
-{
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-		HPI_ADAPTER_TEST_ASSERT);
-	hm.adapter_index = adapter_index;
-	hm.u.ax.test_assert.value = assert_id;
-
-	hpi_send_recv(&hm, &hr);
-
-	return hr.error;
-}
-
-u16 hpi_adapter_enable_capability(u16 adapter_index, u16 capability, u32 key)
-{
-#if 1
-	return HPI_ERROR_UNIMPLEMENTED;
-#else
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-		HPI_ADAPTER_ENABLE_CAPABILITY);
-	hm.adapter_index = adapter_index;
-	hm.u.ax.enable_cap.cap = capability;
-	hm.u.ax.enable_cap.key = key;
-
-	hpi_send_recv(&hm, &hr);
-
-	return hr.error;
-#endif
-}
-
-u16 hpi_adapter_self_test(u16 adapter_index)
-{
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-		HPI_ADAPTER_SELFTEST);
-	hm.adapter_index = adapter_index;
-	hpi_send_recv(&hm, &hr);
-	return hr.error;
-}
-
-u16 hpi_adapter_debug_read(u16 adapter_index, u32 dsp_address, char *p_buffer,
-	int *count_bytes)
-{
-	struct hpi_msg_adapter_debug_read hm;
-	struct hpi_res_adapter_debug_read hr;
-
-	hpi_init_message_responseV1(&hm.h, sizeof(hm), &hr.h, sizeof(hr),
-		HPI_OBJ_ADAPTER, HPI_ADAPTER_DEBUG_READ);
-
-	hm.h.adapter_index = adapter_index;
-	hm.dsp_address = dsp_address;
-
-	if (*count_bytes > (int)sizeof(hr.bytes))
-		*count_bytes = (int)sizeof(hr.bytes);
-
-	hm.count_bytes = *count_bytes;
-
-	hpi_send_recvV1(&hm.h, &hr.h);
-
-	if (!hr.h.error) {
-		int res_bytes = hr.h.size - sizeof(hr.h);
-		if (res_bytes > *count_bytes)
-			res_bytes = *count_bytes;
-		*count_bytes = res_bytes;
-		memcpy(p_buffer, &hr.bytes, res_bytes);
-	} else
-		*count_bytes = 0;
-
-	return hr.h.error;
-}
-
 u16 hpi_adapter_set_property(u16 adapter_index, u16 property, u16 parameter1,
 	u16 parameter2)
 {
-- 
1.7.0.4
