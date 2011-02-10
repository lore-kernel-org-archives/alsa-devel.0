From: linux@audioscience.com
Subject: [PATCH 14/28] Remove int flag polling code preparing
 for stream interrupts.
Date: Thu, 10 Feb 2011 17:26:07 +1300
Message-ID: <1297311981-30448-15-git-send-email-linux@audioscience.com>
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

Interrupt flag used for message handshake will be required for
stream interrupts, so conditionally compiled code without
HPI6205_NO_HSR_POLL defined can never be used;  removing it.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi6205.c |  101 --------------------------------------------------
 pci/asihpi/hpi6205.h |    3 -
 2 files changed, 0 insertions(+), 104 deletions(-)

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index 5fe535b..cbf79a9 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -527,10 +527,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	struct hpi_hw_obj *phw = pao->priv;
 	struct bus_master_interface *interface;
 	u32 phys_addr;
-#ifndef HPI6205_NO_HSR_POLL
-	u32 time_out = HPI6205_TIMEOUT;
-	u32 temp1;
-#endif
 	int i;
 	u16 err;
 
@@ -584,27 +580,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 
 	interface = phw->p_interface_buffer;
 
-#ifndef HPI6205_NO_HSR_POLL
-	/* wait for first interrupt indicating the DSP init is done */
-	time_out = HPI6205_TIMEOUT * 10;
-	temp1 = 0;
-	while (((temp1 & C6205_HSR_INTSRC) == 0) && --time_out)
-		temp1 = ioread32(phw->prHSR);
-
-	if (temp1 & C6205_HSR_INTSRC)
-		HPI_DEBUG_LOG(INFO,
-			"Interrupt confirming DSP code running OK\n");
-	else {
-		HPI_DEBUG_LOG(ERROR,
-			"Timed out waiting for interrupt "
-			"confirming DSP code running\n");
-		return HPI6205_ERROR_6205_NO_IRQ;
-	}
-
-	/* reset the interrupt */
-	iowrite32(C6205_HSR_INTSRC, phw->prHSR);
-#endif
-
 	/* make sure the DSP has started ok */
 	if (!wait_dsp_ack(phw, H620_HIF_RESET, HPI6205_TIMEOUT * 10)) {
 		HPI_DEBUG_LOG(ERROR, "timed out waiting reset state \n");
@@ -1982,9 +1957,6 @@ static short hpi6205_transfer_data(struct hpi_adapter_obj *pao, u8 *p_data,
 	struct hpi_hw_obj *phw = pao->priv;
 	u32 data_transferred = 0;
 	u16 err = 0;
-#ifndef HPI6205_NO_HSR_POLL
-	u32 time_out;
-#endif
 	u32 temp2;
 	struct bus_master_interface *interface = phw->p_interface_buffer;
 
@@ -2009,14 +1981,10 @@ static short hpi6205_transfer_data(struct hpi_adapter_obj *pao, u8 *p_data,
 
 		interface->transfer_size_in_bytes = this_copy;
 
-#ifdef HPI6205_NO_HSR_POLL
 		/* DSP must change this back to nOperation */
 		interface->dsp_ack = H620_HIF_IDLE;
-#endif
-
 		send_dsp_command(phw, operation);
 
-#ifdef HPI6205_NO_HSR_POLL
 		temp2 = wait_dsp_ack(phw, operation, HPI6205_TIMEOUT);
 		HPI_DEBUG_LOG(DEBUG, "spun %d times for data xfer of %d\n",
 			HPI6205_TIMEOUT - temp2, this_copy);
@@ -2029,40 +1997,6 @@ static short hpi6205_transfer_data(struct hpi_adapter_obj *pao, u8 *p_data,
 
 			break;
 		}
-#else
-		/* spin waiting on the result */
-		time_out = HPI6205_TIMEOUT;
-		temp2 = 0;
-		while ((temp2 == 0) && time_out--) {
-			/* give 16k bus mastering transfer time to happen */
-			/*(16k / 132Mbytes/s = 122usec) */
-			hpios_delay_micro_seconds(20);
-			temp2 = ioread32(phw->prHSR);
-			temp2 &= C6205_HSR_INTSRC;
-		}
-		HPI_DEBUG_LOG(DEBUG, "spun %d times for data xfer of %d\n",
-			HPI6205_TIMEOUT - time_out, this_copy);
-		if (temp2 == C6205_HSR_INTSRC) {
-			HPI_DEBUG_LOG(VERBOSE,
-				"Interrupt from HIF <data> OK\n");
-			/*
-			   if(interface->dwDspAck != nOperation) {
-			   HPI_DEBUG_LOG(DEBUG("interface->dwDspAck=%d,
-			   expected %d \n",
-			   interface->dwDspAck,nOperation);
-			   }
-			 */
-		}
-/* need to handle this differently... */
-		else {
-			HPI_DEBUG_LOG(ERROR,
-				"Interrupt from HIF <data> BAD\n");
-			err = HPI_ERROR_DSP_HARDWARE;
-		}
-
-		/* reset the interrupt from the DSP */
-		iowrite32(C6205_HSR_INTSRC, phw->prHSR);
-#endif
 		if (operation == H620_HIF_GET_DATA)
 			memcpy(&p_data[data_transferred],
 				(void *)&interface->u.b_data[0], this_copy);
@@ -2119,9 +2053,6 @@ static unsigned int message_count;
 static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
-#ifndef HPI6205_NO_HSR_POLL
-	u32 temp2;
-#endif
 	u32 time_out, time_out2;
 	struct hpi_hw_obj *phw = pao->priv;
 	struct bus_master_interface *interface = phw->p_interface_buffer;
@@ -2164,38 +2095,6 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 	/* spin waiting on HIF interrupt flag (end of msg process) */
 	time_out = HPI6205_TIMEOUT;
 
-#ifndef HPI6205_NO_HSR_POLL
-	temp2 = 0;
-	while ((temp2 == 0) && --time_out) {
-		temp2 = ioread32(phw->prHSR);
-		temp2 &= C6205_HSR_INTSRC;
-		hpios_delay_micro_seconds(1);
-	}
-	if (temp2 == C6205_HSR_INTSRC) {
-		rmb();	/* ensure we see latest value for dsp_ack */
-		if ((interface->dsp_ack != H620_HIF_GET_RESP)) {
-			HPI_DEBUG_LOG(DEBUG,
-				"(%u)interface->dsp_ack(0x%x) != "
-				"H620_HIF_GET_RESP, t=%u\n", message_count,
-				interface->dsp_ack,
-				HPI6205_TIMEOUT - time_out);
-		} else {
-			HPI_DEBUG_LOG(VERBOSE,
-				"(%u)int with GET_RESP after %u\n",
-				message_count, HPI6205_TIMEOUT - time_out);
-		}
-
-	} else {
-		/* can we do anything else in response to the error ? */
-		HPI_DEBUG_LOG(ERROR,
-			"Interrupt from HIF module BAD (function %x)\n",
-			phm->function);
-	}
-
-	/* reset the interrupt from the DSP */
-	iowrite32(C6205_HSR_INTSRC, phw->prHSR);
-#endif
-
 	/* read the result */
 	if (time_out) {
 		if (interface->u.response_buffer.size <= phr->size)
diff --git a/pci/asihpi/hpi6205.h b/pci/asihpi/hpi6205.h
index e00edb0..df2f02c 100644
--- a/pci/asihpi/hpi6205.h
+++ b/pci/asihpi/hpi6205.h
@@ -25,9 +25,6 @@ Copyright AudioScience, Inc., 2003
 #ifndef _HPI6205_H_
 #define _HPI6205_H_
 
-/* transitional conditional compile shared between host and DSP */
-/* #define HPI6205_NO_HSR_POLL */
-
 #include "hpi_internal.h"
 
 /***********************************************************
-- 
1.7.0.4
