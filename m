From: linux@audioscience.com
Subject: [PATCH 10/28] Update error codes.
Date: Thu, 10 Feb 2011 17:26:03 +1300
Message-ID: <1297311981-30448-11-git-send-email-linux@audioscience.com>
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

Some error codes had duplicate meanings. Just use one.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi6205.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index 5ebf8f8..a3f650d 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -38,7 +38,7 @@
 
 /*****************************************************************************/
 /* HPI6205 specific error codes */
-#define HPI6205_ERROR_BASE                      1000	/* not actually used anywhere */
+#define HPI6205_ERROR_BASE 1000	/* not actually used anywhere */
 
 /* operational/messaging errors */
 #define HPI6205_ERROR_MSG_RESP_IDLE_TIMEOUT     1015
@@ -293,7 +293,7 @@ static void outstream_message(struct hpi_adapter_obj *pao,
 {
 
 	if (phm->obj_index >= HPI_MAX_STREAMS) {
-		phr->error = HPI_ERROR_INVALID_STREAM;
+		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 		HPI_DEBUG_LOG(WARNING,
 			"Message referencing invalid stream %d "
 			"on adapter index %d\n", phm->obj_index,
@@ -337,7 +337,7 @@ static void instream_message(struct hpi_adapter_obj *pao,
 {
 
 	if (phm->obj_index >= HPI_MAX_STREAMS) {
-		phr->error = HPI_ERROR_INVALID_STREAM;
+		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 		HPI_DEBUG_LOG(WARNING,
 			"Message referencing invalid stream %d "
 			"on adapter index %d\n", phm->obj_index,
@@ -864,6 +864,7 @@ static void outstream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 		status->dSP_index = 0;
 		status->host_index = status->dSP_index;
 		status->size_in_bytes = phm->u.d.u.buffer.buffer_size;
+		status->auxiliary_data_available = 0;
 
 		hw_message(pao, phm, phr);
 
@@ -995,8 +996,8 @@ static void outstream_write(struct hpi_adapter_obj *pao,
 	/*
 	 * This version relies on the DSP code triggering an OStream buffer
 	 * update immediately following a SET_FORMAT call. The host has
-	 * already written data into the BBM buffer, but the DSP won't know about
-	 * it until dwHostIndex is adjusted.
+	 * already written data into the BBM buffer, but the DSP won't know
+	 * about it until dwHostIndex is adjusted.
 	 */
 	if (phw->flag_outstream_just_reset[phm->obj_index]) {
 		/* Format can only change after reset. Must tell DSP. */
@@ -1140,6 +1141,7 @@ static void instream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 		status->dSP_index = 0;
 		status->host_index = status->dSP_index;
 		status->size_in_bytes = phm->u.d.u.buffer.buffer_size;
+		status->auxiliary_data_available = 0;
 
 		hw_message(pao, phm, phr);
 		if (phr->error
@@ -1982,7 +1984,7 @@ static short hpi6205_transfer_data(struct hpi_adapter_obj *pao, u8 *p_data,
 	struct bus_master_interface *interface = phw->p_interface_buffer;
 
 	if (!p_data)
-		return HPI_ERROR_INVALID_DATA_TRANSFER;
+		return HPI_ERROR_INVALID_DATA_POINTER;
 
 	data_size &= ~3L;	/* round data_size down to nearest 4 bytes */
 
@@ -2122,8 +2124,7 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 
 	message_count++;
 	if (phm->size > sizeof(interface->u)) {
-		/* really MESSAGE buffer too small */
-		phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
+		phr->error = HPI_ERROR_MESSAGE_BUFFER_TOO_SMALL;
 		phr->specific_error = sizeof(interface->u);
 		phr->size = sizeof(struct hpi_response_header);
 		HPI_DEBUG_LOG(ERROR,
-- 
1.7.0.4
