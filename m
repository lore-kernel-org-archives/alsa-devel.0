From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH 4/5] asihpi: replace volatile with barriers
Date: Thu, 06 Mar 2008 14:51:02 +1300
Message-ID: <200803061451.02146.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 086A1103895
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 02:48:01 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXA00CSUCYZQB00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 06 Mar 2008 14:47:59 +1300 (NZDT)
Content-disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Replace volatile with barriers where required.
Other minor cleanups. 

Signed-off-by: Eliot Blennerhassett <linux@audioscience.com
---
diff -r 6def4892d3f5 pci/asihpi/hpi6205.c
--- a/pci/asihpi/hpi6205.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpi6205.c	Thu Mar 06 12:21:54 2008 +1300
@@ -27,6 +27,7 @@
 (C) Copyright AudioScience Inc. 1998-2003
 
*******************************************************************************/
 #define SOURCEFILE_NAME "hpi6205.c"
+
 #include "hpi.h"
 #include "hpidebug.h"
 #include "hpi6205.h"
@@ -35,42 +36,42 @@
 
 /*****************************************************************************/
 /* HPI6205 specific error codes */
-#define HPI6205_ERROR_BASE		    1000
-#define HPI6205_ERROR_MEM_ALLOC		    1001
-#define HPI6205_ERROR_6205_NO_IRQ	    1002
-#define HPI6205_ERROR_6205_INIT_FAILED	    1003
+#define HPI6205_ERROR_BASE                      1000
+/*#define HPI6205_ERROR_MEM_ALLOC 1001 */
+#define HPI6205_ERROR_6205_NO_IRQ               1002
+#define HPI6205_ERROR_6205_INIT_FAILED          1003
 /*#define HPI6205_ERROR_MISSING_DSPCODE 1004 */
-#define HPI6205_ERROR_UNKNOWN_PCI_DEVICE   1005
-#define HPI6205_ERROR_6205_REG				1006
-#define HPI6205_ERROR_6205_DSPPAGE			1007
-#define HPI6205_ERROR_BAD_DSPINDEX			1008
-#define HPI6205_ERROR_C6713_HPIC			1009
-#define HPI6205_ERROR_C6713_HPIA			1010
-#define HPI6205_ERROR_C6713_PLL				1011
-#define HPI6205_ERROR_DSP_INTMEM	    1012
-#define HPI6205_ERROR_DSP_EXTMEM			1013
-#define HPI6205_ERROR_DSP_PLD		    1014
-#define HPI6205_ERROR_MSG_RESP_IDLE_TIMEOUT 1015
-#define HPI6205_ERROR_MSG_RESP_TIMEOUT		1016
-#define HPI6205_ERROR_6205_EEPROM			1017
-#define HPI6205_ERROR_DSP_EMIF				1018
+#define HPI6205_ERROR_UNKNOWN_PCI_DEVICE        1005
+#define HPI6205_ERROR_6205_REG                  1006
+#define HPI6205_ERROR_6205_DSPPAGE              1007
+#define HPI6205_ERROR_BAD_DSPINDEX              1008
+#define HPI6205_ERROR_C6713_HPIC                1009
+#define HPI6205_ERROR_C6713_HPIA                1010
+#define HPI6205_ERROR_C6713_PLL                 1011
+#define HPI6205_ERROR_DSP_INTMEM                1012
+#define HPI6205_ERROR_DSP_EXTMEM                1013
+#define HPI6205_ERROR_DSP_PLD                   1014
+#define HPI6205_ERROR_MSG_RESP_IDLE_TIMEOUT     1015
+#define HPI6205_ERROR_MSG_RESP_TIMEOUT          1016
+#define HPI6205_ERROR_6205_EEPROM               1017
+#define HPI6205_ERROR_DSP_EMIF                  1018
 
 #define Hpi6205_Error(nDspIndex, err) (err)
 /*****************************************************************************/
 /* for C6205 PCI i/f */
 /* Host Status Register (HSR) bitfields */
-#define C6205_HSR_INTSRC	0x01
-#define C6205_HSR_INTAVAL	0x02
-#define C6205_HSR_INTAM		0x04
-#define C6205_HSR_CFGERR	0x08
-#define C6205_HSR_EEREAD	0x10
+#define C6205_HSR_INTSRC        0x01
+#define C6205_HSR_INTAVAL       0x02
+#define C6205_HSR_INTAM         0x04
+#define C6205_HSR_CFGERR        0x08
+#define C6205_HSR_EEREAD        0x10
 /* Host-to-DSP Control Register (HDCR) bitfields */
-#define C6205_HDCR_WARMRESET	0x01
-#define C6205_HDCR_DSPINT		0x02
-#define C6205_HDCR_PCIBOOT		0x04
+#define C6205_HDCR_WARMRESET    0x01
+#define C6205_HDCR_DSPINT       0x02
+#define C6205_HDCR_PCIBOOT      0x04
 /* DSP Page Register (DSPP) bitfields, */
 /* defines 4 Mbyte page that BAR0 points to */
-#define C6205_DSPP_MAP1		0x400
+#define C6205_DSPP_MAP1         0x400
 
 /* BAR0 maps to prefetchable 4 Mbyte memory block set by DSPP.
  * BAR1 maps to non-prefetchable 8 Mbyte memory block
@@ -79,7 +80,7 @@
  * needs to be added to the BAR1 base address set in the PCI config reg
  */
 #define C6205_BAR1_PCI_IO_OFFSET (0x027FFF0L)
-#define C6205_BAR1_HSR (C6205_BAR1_PCI_IO_OFFSET)
+#define C6205_BAR1_HSR  (C6205_BAR1_PCI_IO_OFFSET)
 #define C6205_BAR1_HDCR (C6205_BAR1_PCI_IO_OFFSET+4)
 #define C6205_BAR1_DSPP (C6205_BAR1_PCI_IO_OFFSET+8)
 
@@ -87,23 +88,23 @@
 #define C6205_BAR0_TIMER1_CTL (0x01980000L)
 
 /* For first 6713 in CE1 space, using DA17,16,2 */
-#define HPICL_ADDR		0x01400000L
-#define HPICH_ADDR	0x01400004L
-#define HPIAL_ADDR	0x01410000L
-#define HPIAH_ADDR	0x01410004L
-#define HPIDIL_ADDR	0x01420000L
-#define HPIDIH_ADDR	0x01420004L
-#define HPIDL_ADDR	0x01430000L
-#define HPIDH_ADDR	0x01430004L
-
-#define C6713_EMIF_GCTL			0x01800000
-#define C6713_EMIF_CE1			0x01800004
-#define C6713_EMIF_CE0		0x01800008
-#define C6713_EMIF_CE2		0x01800010
-#define C6713_EMIF_CE3		0x01800014
-#define C6713_EMIF_SDRAMCTL	0x01800018
-#define C6713_EMIF_SDRAMTIMING	0x0180001C
-#define C6713_EMIF_SDRAMEXT	0x01800020
+#define HPICL_ADDR      0x01400000L
+#define HPICH_ADDR      0x01400004L
+#define HPIAL_ADDR      0x01410000L
+#define HPIAH_ADDR      0x01410004L
+#define HPIDIL_ADDR     0x01420000L
+#define HPIDIH_ADDR     0x01420004L
+#define HPIDL_ADDR      0x01430000L
+#define HPIDH_ADDR      0x01430004L
+
+#define C6713_EMIF_GCTL         0x01800000
+#define C6713_EMIF_CE1          0x01800004
+#define C6713_EMIF_CE0          0x01800008
+#define C6713_EMIF_CE2          0x01800010
+#define C6713_EMIF_CE3          0x01800014
+#define C6713_EMIF_SDRAMCTL     0x01800018
+#define C6713_EMIF_SDRAMTIMING  0x0180001C
+#define C6713_EMIF_SDRAMEXT     0x01800020
 
 struct hpi_hw_obj {
 	/* PCI registers */
@@ -114,7 +115,7 @@ struct hpi_hw_obj {
 	u32 dwDspPage;
 
 	struct consistent_dma_area hLockedMem;
-	volatile struct bus_master_interface *pInterfaceBuffer;
+	struct bus_master_interface *pInterfaceBuffer;
 
 	u16 flagOStreamJustReset[HPI_MAX_STREAMS];
 	/* a non-NULL handle means there is an HPI allocated buffer */
@@ -134,6 +135,17 @@ struct hpi_hw_obj {
 /* local prototypes */
 
 #define CheckBeforeBBMCopy(status, pBBMData, lFirstWrite, lSecondWrite)
+
+static int WaitDspAck(
+	struct hpi_hw_obj *pHw6205,
+	int state,
+	int timeout_us
+);
+
+static void SendDspCommand(
+	struct hpi_hw_obj *pHw6205,
+	int cmd
+);
 
 static u16 Hpi6205_AdapterBootLoadDsp(
 	struct hpi_adapter_obj *pao,
@@ -312,11 +324,13 @@ static void ControlMessage(
 
 	switch (phm->wFunction) {
 	case HPI_CONTROL_GET_STATE:
-		if (pao->wHasControlCache)
+		if (pao->wHasControlCache) {
+			rmb();	/* make sure we see updates DMAed from DSP */
 			if (HpiCheckControlCache
 				(&pHw6205->pControlCache[phm->u.c.
 						wControlIndex], phm, phr))
 				break;
+		}
 		HW_Message(pao, phm, phr);
 		break;
 	case HPI_CONTROL_GET_INFO:
@@ -597,7 +611,7 @@ static u16 CreateAdapterObj(
 )
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface;
+	struct bus_master_interface *interface;
 	u32 dwPhysAddr;
 	u32 dwTimeOut = HPI6205_TIMEOUT;
 	u32 dwTemp1;
@@ -631,6 +645,7 @@ static u16 CreateAdapterObj(
 
 	HPI_DEBUG_LOG(DEBUG, "Interface buffer address %p\n",
 		pHw6205->pInterfaceBuffer);
+
 	if (pHw6205->pInterfaceBuffer) {
 		memset((void *)pHw6205->pInterfaceBuffer, 0,
 			sizeof(struct bus_master_interface));
@@ -647,7 +662,7 @@ static u16 CreateAdapterObj(
 
 	/* allow boot load even if mem alloc wont work */
 	if (!pHw6205->pInterfaceBuffer)
-		return (Hpi6205_Error(0, HPI6205_ERROR_MEM_ALLOC));
+		return (Hpi6205_Error(0, HPI_ERROR_MEMORY_ALLOC));
 
 	interface = pHw6205->pInterfaceBuffer;
 
@@ -671,14 +686,8 @@ static u16 CreateAdapterObj(
 	iowrite32(C6205_HSR_INTSRC, pHw6205->prHSR);
 
 	/* make sure the DSP has started ok */
-	dwTimeOut = 100;
-	while ((interface->dwDspAck != H620_HIF_RESET) && dwTimeOut) {
-		dwTimeOut--;
-		HpiOs_DelayMicroSeconds(10000);
-	}
-
-	if (dwTimeOut == 0) {
-		HPI_DEBUG_LOG(ERROR, "Timed out waiting ack \n");
+	if (!WaitDspAck(pHw6205, H620_HIF_RESET, HPI6205_TIMEOUT)) {
+		HPI_DEBUG_LOG(ERROR, "Timed out waiting reset state \n");
 		return (Hpi6205_Error(0, HPI6205_ERROR_6205_INIT_FAILED));
 	}
 	/* Note that *pao, *pHw6205 are zeroed after allocation,
@@ -746,14 +755,7 @@ static u16 CreateAdapterObj(
 			}
 		}
 	}
-	/* set interface to idle */
-	interface->dwHostCmd = H620_HIF_IDLE;
-	/* interrupt the DSP again */
-	dwTemp1 = ioread32(pHw6205->prHDCR);
-	dwTemp1 |= (u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-	dwTemp1 &= ~(u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
+	SendDspCommand(pHw6205, H620_HIF_IDLE);
 
 	{
 		struct hpi_message hM;
@@ -789,7 +791,7 @@ static u16 CreateAdapterObj(
 	}
 
 	HPI_DEBUG_LOG(VERBOSE, "Get adapter info OK\n");
-	pao->wOpen = 0;		/* upon creation the adapter is closed */
+	pao->wOpen = 0;	/* upon creation the adapter is closed */
 
 	HPI_DEBUG_LOG(INFO, "Bootload DSP OK\n");
 	return (0);
@@ -872,8 +874,7 @@ static void OutStreamHostBufferAllocate(
 	u32 dwCommand = phm->u.d.u.Buffer.dwCommand;
 	/*u16 wStreamIndex = phm->u.d.wStreamIndex; */
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
 
 	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
 
@@ -941,7 +942,7 @@ static void OutStreamHostBufferAllocate(
 		/* GRANT phase.  Set up the BBM status, tell the DSP about
 		   the buffer so it can start using BBM.
 		 */
-		volatile struct hostbuffer_status_6205 *status;
+		struct hostbuffer_status_6205 *status;
 
 		if (phm->u.d.u.Buffer.
 			dwBufferSize & (phm->u.d.u.Buffer.dwBufferSize - 1)) {
@@ -1005,7 +1006,7 @@ static void OutStreamHostBufferFree(
 }
 
 static long OutStreamGetSpaceAvailable(
-	volatile struct hostbuffer_status_6205 *status
+	struct hostbuffer_status_6205 *status
 )
 {
 	return status->dwSizeInBytes - ((long)(status->dwHostIndex) -
@@ -1019,9 +1020,8 @@ static void OutStreamWrite(
 )
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
-	volatile struct hostbuffer_status_6205 *status;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+	struct hostbuffer_status_6205 *status;
 	long dwSpaceAvailable;
 	if (!pHw6205->OutStreamHostBufferSize[phm->u.d.wStreamIndex]) {
 		/* there  is no BBM buffer */
@@ -1126,9 +1126,8 @@ static void OutStreamGetInfo(
 )
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
-	volatile struct hostbuffer_status_6205 *status;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+	struct hostbuffer_status_6205 *status;
 
 	if (!pHw6205->OutStreamHostBufferSize[phm->u.d.wStreamIndex]) {
 		HW_Message(pao, phm, phr);
@@ -1188,13 +1187,13 @@ static void InStreamHostBufferAllocate(
 	u16 err = 0;
 	u32 dwCommand = phm->u.d.u.Buffer.dwCommand;
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
 
 	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
 
 	if (dwCommand == HPI_BUFFER_CMD_EXTERNAL ||
 		dwCommand == HPI_BUFFER_CMD_INTERNAL_ALLOC) {
+
 		phm->u.d.u.Buffer.dwBufferSize =
 			roundup_pow_of_two(phm->u.d.u.Buffer.dwBufferSize);
 		phr->u.d.u.stream_info.dwDataAvailable =
@@ -1247,7 +1246,7 @@ static void InStreamHostBufferAllocate(
 
 	if (dwCommand == HPI_BUFFER_CMD_EXTERNAL ||
 		dwCommand == HPI_BUFFER_CMD_INTERNAL_GRANTADAPTER) {
-		volatile struct hostbuffer_status_6205 *status;
+		struct hostbuffer_status_6205 *status;
 
 		if (phm->u.d.u.Buffer.
 			dwBufferSize & (phm->u.d.u.Buffer.dwBufferSize - 1)) {
@@ -1267,6 +1266,7 @@ static void InStreamHostBufferAllocate(
 		status->dwDSPIndex = 0;
 		status->dwHostIndex = status->dwDSPIndex;
 		status->dwSizeInBytes = phm->u.d.u.Buffer.dwBufferSize;
+
 		HW_Message(pao, phm, phr);
 		if (phr->wError
 			&& HpiOs_LockedMem_Valid(&pHw6205->
@@ -1297,10 +1297,10 @@ static void InStreamHostBufferFree(
 		}
 
 		if (dwCommand == HPI_BUFFER_CMD_EXTERNAL ||
-			dwCommand == HPI_BUFFER_CMD_INTERNAL_FREE) {
+			dwCommand == HPI_BUFFER_CMD_INTERNAL_FREE)
 			HpiOs_LockedMem_Free(&pHw6205->
 				InStreamHostBuffers[phm->u.d.wStreamIndex]);
-		}
+
 	} else {
 		/* Should HPI_ERROR_INVALID_OPERATION be returned
 		   if no host buffer is allocated? */
@@ -1321,7 +1321,7 @@ static void InStreamStart(
 }
 
 static long InStreamGetBytesAvailable(
-	volatile struct hostbuffer_status_6205 *status
+	struct hostbuffer_status_6205 *status
 )
 {
 	return (long)(status->dwDSPIndex) - (long)(status->dwHostIndex);
@@ -1334,9 +1334,8 @@ static void InStreamRead(
 )
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
-	volatile struct hostbuffer_status_6205 *status;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+	struct hostbuffer_status_6205 *status;
 	long dwDataAvailable;
 	u8 *pBBMData;
 	long lFirstRead;
@@ -1387,9 +1386,8 @@ static void InStreamGetInfo(
 )
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
-	volatile struct hostbuffer_status_6205 *status;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+	struct hostbuffer_status_6205 *status;
 	if (!pHw6205->InStreamHostBufferSize[phm->u.d.wStreamIndex]) {
 		HW_Message(pao, phm, phr);
 		return;
@@ -1451,7 +1449,7 @@ static u16 Hpi6205_AdapterBootLoadDsp(
 	dwTemp = C6205_HDCR_WARMRESET;
 	iowrite32(dwTemp, pHw6205->prHDCR);
 	HpiOs_DelayMicroSeconds(1000);
-/*	for(i=0;i<1000; i++) dwTemp = ioread32(pao,pHw6205->prHDCR); */
+/*      for(i=0;i<1000; i++) dwTemp = ioread32(pao,pHw6205->prHDCR); */
 
 	/* check that PCI i/f was configured by EEPROM */
 	dwTemp = ioread32(pHw6205->prHSR);
@@ -1620,7 +1618,7 @@ static u16 Hpi6205_AdapterBootLoadDsp(
 	if (pHw6205->pInterfaceBuffer) {
 		/* we need to tell the card the physical PCI address */
 		u32 dwPhysicalPCIaddress;
-		volatile struct bus_master_interface *interface =
+		struct bus_master_interface *interface =
 			pHw6205->pInterfaceBuffer;
 		u32 dwHostMailboxAddressOnDsp;
 		u32 dwPhysicalPCIaddressVerify = 0;
@@ -1628,6 +1626,7 @@ static u16 Hpi6205_AdapterBootLoadDsp(
 		/* set ack so we know when DSP is ready to go */
 		/* (dwDspAck will be changed to HIF_RESET) */
 		interface->dwDspAck = H620_HIF_UNKNOWN;
+		wmb();	/* ensure ack is written before dsp writes back */
 
 		err = HpiOs_LockedMem_GetPhysAddr(&pHw6205->hLockedMem,
 			&dwPhysicalPCIaddress);
@@ -1715,7 +1714,7 @@ static u16 BootLoader_WriteMem32(
 	struct hpi_hw_obj *pHw6205 = pao->priv;
 	u16 err = 0;
 	__iomem u32 *pData;
-	/*	u32 dwVerifyData=0; */
+	/*      u32 dwVerifyData=0; */
 
 	if (nDSPIndex == 0) {
 		/* DSP 0 is always C6205 */
@@ -1771,8 +1770,8 @@ static u16 BootLoader_ConfigEMIF(
 
 		/* Set the EMIF */
 		/* memory map of C6205 */
-		/* 00000000-0000FFFF	16Kx32 internal program */
-		/* 00400000-00BFFFFF	CE0	2Mx32 SDRAM running @ 100MHz */
+		/* 00000000-0000FFFF    16Kx32 internal program */
+		/* 00400000-00BFFFFF    CE0     2Mx32 SDRAM running @ 100MHz */
 
 		/* EMIF config */
 		/*------------ */
@@ -1899,7 +1898,7 @@ static u16 BootLoader_ConfigEMIF(
 		BootLoader_WriteMem32(pao, nDSPIndex, 0x01B7C120, 0x8002);
 		/* peri = 189/2 */
 		BootLoader_WriteMem32(pao, nDSPIndex, 0x01B7C11C, 0x8001);
-		/* cpu	= 189/1 */
+		/* cpu  = 189/1 */
 		BootLoader_WriteMem32(pao, nDSPIndex, 0x01B7C118, 0x8000);
 		HpiOs_DelayMicroSeconds(1000);
 		/* ** SGT test to take GPO3 high when we start the PLL */
@@ -1980,15 +1979,15 @@ static u16 BootLoader_TestMemory(
 				dwTestAddr);
 			if (dwData != dwTestData) {
 				HPI_DEBUG_LOG(VERBOSE,
-					"Memtest error details	"
+					"Memtest error details  "
 					"%08x %08x %08x %i\n",
 					dwTestAddr, dwTestData,
 					dwData, nDSPIndex);
 				return (1);	/* error */
 			}
 			dwTestData = dwTestData << 1;
-		}		/* for(j) */
-	}			/* for(i) */
+		}	/* for(j) */
+	}	/* for(i) */
 
 	/* for the next 100 locations test each location, leaving it as zero */
 	/* write a zero to the next word in memory before we read */
@@ -2001,7 +2000,7 @@ static u16 BootLoader_TestMemory(
 		dwData = BootLoader_ReadMem32(pao, nDSPIndex, dwTestAddr);
 		if (dwData != dwTestData) {
 			HPI_DEBUG_LOG(VERBOSE,
-				"Memtest error details	"
+				"Memtest error details  "
 				"%08x %08x %08x %i\n",
 				dwTestAddr, dwTestData, dwData, nDSPIndex);
 			return (1);	/* error */
@@ -2015,7 +2014,7 @@ static u16 BootLoader_TestMemory(
 		dwTestAddr = dwStartAddress + (u32)i *4;
 		BootLoader_WriteMem32(pao, nDSPIndex, dwTestAddr, 0x0);
 	}
-	return (0);		/*success! */
+	return (0);	/*success! */
 }
 
 static u16 BootLoader_TestInternalMemory(
@@ -2134,22 +2133,14 @@ static short Hpi6205_TransferData(
 	/*u8  *pData =(u8  *)phm->u.d.u.Data.dwpbData; */
 	/*u16 wTimeOut=8; */
 	u16 err = 0;
-	u32 dwTimeOut, dwTemp1, dwTemp2;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
+	u32 dwTimeOut, dwTemp2;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
 
 	dwDataSize &= ~3L;	/* round dwDataSize down to nearest 4 bytes */
 
 	/* make sure state is IDLE */
-	dwTimeOut = HPI6205_TIMEOUT;
-	dwTemp2 = 0;
-	while ((interface->dwDspAck != H620_HIF_IDLE) && dwTimeOut--)
-		HpiOs_DelayMicroSeconds(1);
-
-	if (interface->dwDspAck != H620_HIF_IDLE)
+	if (!WaitDspAck(pHw6205, H620_HIF_IDLE, HPI6205_TIMEOUT))
 		return HPI_ERROR_DSP_HARDWARE;
-
-	interface->dwHostCmd = nOperation;
 
 	while (dwDataTransferred < dwDataSize) {
 		u32 nThisCopy = dwDataSize - dwDataTransferred;
@@ -2162,13 +2153,7 @@ static short Hpi6205_TransferData(
 				&pData[dwDataTransferred], nThisCopy);
 
 		interface->dwTransferSizeInBytes = nThisCopy;
-
-		/* interrupt the DSP */
-		dwTemp1 = ioread32(pHw6205->prHDCR);
-		dwTemp1 |= (u32)C6205_HDCR_DSPINT;
-		iowrite32(dwTemp1, pHw6205->prHDCR);
-		dwTemp1 &= ~(u32)C6205_HDCR_DSPINT;
-		iowrite32(dwTemp1, pHw6205->prHDCR);
+		SendDspCommand(pHw6205, nOperation);
 
 		/* spin waiting on the result */
 		dwTimeOut = HPI6205_TIMEOUT;
@@ -2212,20 +2197,55 @@ static short Hpi6205_TransferData(
 	if (interface->dwDspAck != nOperation)
 		HPI_DEBUG_LOG(DEBUG, "interface->dwDspAck=%d, expected %d\n",
 			interface->dwDspAck, nOperation);
-	/*			err=HPI_ERROR_DSP_HARDWARE; */
-
-	/* set interface back to idle */
-	interface->dwHostCmd = H620_HIF_IDLE;
-	/* interrupt the DSP again */
-	dwTemp1 = ioread32(pHw6205->prHDCR);
-	dwTemp1 |= (u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-	dwTemp1 &= ~(u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
+	/*                      err=HPI_ERROR_DSP_HARDWARE; */
+
+	SendDspCommand(pHw6205, H620_HIF_IDLE);
 
 	return err;
 }
 
+/* wait for up to timeout_us microseconds for the DSP
+   to signal state by DMA into dwDspAck
+*/
+static int WaitDspAck(
+	struct hpi_hw_obj *pHw6205,
+	int state,
+	int timeout_us
+)
+{
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+	int t = timeout_us / 4;
+
+	rmb();	/* ensure interface->dwDspAck is up to date */
+	while ((interface->dwDspAck != state) && t--) {
+		HpiOs_DelayMicroSeconds(4);
+		rmb();	/* DSP changes dwDspAck by DMA */
+	}
+
+	/*HPI_DEBUG_LOG(VERBOSE, "Spun %d for %d\n", timeout_us/4-t, state); */
+	return t;
+}
+
+/* set the busmaster interface to cmd, then interrupt the DSP */
+static void SendDspCommand(
+	struct hpi_hw_obj *pHw6205,
+	int cmd
+)
+{
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
+
+	u32 r;
+
+	interface->dwHostCmd = cmd;
+	wmb();	/* DSP gets state by DMA, make sure it is written to memory */
+	/* before we interrupt the DSP */
+	r = ioread32(pHw6205->prHDCR);
+	r |= (u32)C6205_HDCR_DSPINT;
+	iowrite32(r, pHw6205->prHDCR);
+	r &= ~(u32)C6205_HDCR_DSPINT;
+	iowrite32(r, pHw6205->prHDCR);
+}
+
 static unsigned int messageCount;
 
 static u16 Hpi6205_MessageResponseSequence(
@@ -2234,46 +2254,26 @@ static u16 Hpi6205_MessageResponseSequen
 	struct hpi_response *phr
 )
 {
-	u32 dwTemp1, dwTemp2, dwTimeOut, dwTimeOut2;
+	u32 dwTemp2, dwTimeOut, dwTimeOut2;
 	struct hpi_hw_obj *pHw6205 = pao->priv;
-	volatile struct bus_master_interface *interface =
-		pHw6205->pInterfaceBuffer;
+	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
 	u16 err = 0;
 
 	messageCount++;
 	/* Assume buffer of type struct bus_master_interface
 	   is allocated "noncacheable" */
 
-	/* make sure state is IDLE */
-	dwTimeOut = HPI6205_TIMEOUT;
-	dwTemp2 = 0;
-	while ((interface->dwDspAck != H620_HIF_IDLE) && --dwTimeOut)
-		HpiOs_DelayMicroSeconds(1);
-
-	if (dwTimeOut == 0) {
+	if (!WaitDspAck(pHw6205, H620_HIF_IDLE, HPI6205_TIMEOUT)) {
 		HPI_DEBUG_LOG(DEBUG, "Timeout waiting for idle\n");
 		return (Hpi6205_Error
 			(0, HPI6205_ERROR_MSG_RESP_IDLE_TIMEOUT));
 	}
 	interface->u.MessageBuffer = *phm;
 	/* signal we want a response */
-	interface->dwHostCmd = H620_HIF_GET_RESP;
-
-	/* interrupt the DSP */
-	dwTemp1 = ioread32(pHw6205->prHDCR);
-	dwTemp1 |= (u32)C6205_HDCR_DSPINT;
-	HpiOs_DelayMicroSeconds(1);
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-	dwTemp1 &= ~(u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-
-	/* spin waiting on state change (start of msg process) */
-	dwTimeOut2 = HPI6205_TIMEOUT;
-	dwTemp2 = 0;
-	while ((interface->dwDspAck != H620_HIF_GET_RESP) && --dwTimeOut2) {
-		dwTemp2 = ioread32(pHw6205->prHSR);
-		dwTemp2 &= C6205_HSR_INTSRC;
-	}
+	SendDspCommand(pHw6205, H620_HIF_GET_RESP);
+
+	dwTimeOut2 = WaitDspAck(pHw6205, H620_HIF_GET_RESP, HPI6205_TIMEOUT);
+
 	if (dwTimeOut2 == 0) {
 		HPI_DEBUG_LOG(DEBUG,
 			"(%u)Timed out waiting for "
@@ -2284,16 +2284,16 @@ static u16 Hpi6205_MessageResponseSequen
 			"(%u)Transition to GET_RESP after %u\n",
 			messageCount, HPI6205_TIMEOUT - dwTimeOut2);
 	}
-
 	/* spin waiting on HIF interrupt flag (end of msg process) */
 	dwTimeOut = HPI6205_TIMEOUT;
 	dwTemp2 = 0;
 	while ((dwTemp2 == 0) && --dwTimeOut) {
 		dwTemp2 = ioread32(pHw6205->prHSR);
 		dwTemp2 &= C6205_HSR_INTSRC;
-		/* HpiOs_DelayMicroSeconds(5); */
+		HpiOs_DelayMicroSeconds(1);
 	}
 	if (dwTemp2 == C6205_HSR_INTSRC) {
+		rmb();	/* ensure we see latest value for dwDspAck */
 		if ((interface->dwDspAck != H620_HIF_GET_RESP)) {
 			HPI_DEBUG_LOG(DEBUG,
 				"(%u)interface->dwDspAck(0x%x) != "
@@ -2306,12 +2306,12 @@ static u16 Hpi6205_MessageResponseSequen
 				messageCount, HPI6205_TIMEOUT - dwTimeOut);
 		}
 
-	}
-/* need to handle this differently... */
-	else
+	} else {
+		/* can we do anything else in response to the error ? */
 		HPI_DEBUG_LOG(ERROR,
 			"Interrupt from HIF module BAD (wFunction %x)\n",
 			phm->wFunction);
+	}
 
 	/* reset the interrupt from the DSP */
 	iowrite32(C6205_HSR_INTSRC, pHw6205->prHSR);
@@ -2321,15 +2321,8 @@ static u16 Hpi6205_MessageResponseSequen
 		*phr = interface->u.ResponseBuffer;
 
 	/* set interface back to idle */
-	interface->dwHostCmd = H620_HIF_IDLE;
-	/* interrupt the DSP again */
-	dwTemp1 = ioread32(pHw6205->prHDCR);
-	dwTemp1 |= (u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-	dwTemp1 &= ~(u32)C6205_HDCR_DSPINT;
-	iowrite32(dwTemp1, pHw6205->prHDCR);
-
-/* EWB move timeoutcheck to after IDLE command, maybe recover? */
+	SendDspCommand(pHw6205, H620_HIF_IDLE);
+
 	if ((dwTimeOut == 0) || (dwTimeOut2 == 0)) {
 		HPI_DEBUG_LOG(DEBUG, "Something timed out!\n");
 		return Hpi6205_Error(0, HPI6205_ERROR_MSG_RESP_TIMEOUT);
@@ -2337,13 +2330,7 @@ static u16 Hpi6205_MessageResponseSequen
 	/* special case for adapter close - */
 	/* wait for the DSP to indicate it is idle */
 	if (phm->wFunction == HPI_ADAPTER_CLOSE) {
-		/* make sure state is IDLE */
-		dwTimeOut = HPI6205_TIMEOUT;
-		dwTemp2 = 0;
-		while ((interface->dwDspAck != H620_HIF_IDLE) && --dwTimeOut)
-			HpiOs_DelayMicroSeconds(1);
-
-		if (dwTimeOut == 0) {
+		if (!WaitDspAck(pHw6205, H620_HIF_IDLE, HPI6205_TIMEOUT)) {
 			HPI_DEBUG_LOG(DEBUG,
 				"Timeout waiting for idle "
 				"(on AdapterClose)\n");
diff -r 6def4892d3f5 pci/asihpi/hpicmn.c
--- a/pci/asihpi/hpicmn.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpicmn.c	Thu Mar 06 12:21:31 2008 +1300
@@ -148,7 +148,7 @@ static void SubSysGetAdapters(
 
 	/* input:  NONE */
 	/* output: wNumAdapters */
-	/*		   awAdapter[] */
+	/*                 awAdapter[] */
 	/* */
 
 	short i;
@@ -178,7 +178,7 @@ static void SubSysGetAdapters(
 * It returns nonzero if a cache hit occurred, zero otherwise.
 */
 short HpiCheckControlCache(
-	volatile struct hpi_control_cache_single *pC,
+	struct hpi_control_cache_single *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 )
@@ -301,7 +301,7 @@ Multiplexer does so use sent values
 Multiplexer does so use sent values
 */
 void HpiSyncControlCache(
-	volatile struct hpi_control_cache_single *pC,
+	struct hpi_control_cache_single *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 )
diff -r 6def4892d3f5 pci/asihpi/hpicmn.h
--- a/pci/asihpi/hpicmn.h	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpicmn.h	Thu Mar 06 12:21:30 2008 +1300
@@ -44,12 +44,12 @@ void HpiDeleteAdapter(
 );
 
 short HpiCheckControlCache(
-	volatile struct hpi_control_cache_single *pC,
+	struct hpi_control_cache_single *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 );
 void HpiSyncControlCache(
-	volatile struct hpi_control_cache_single *pC,
+	struct hpi_control_cache_single *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 );
