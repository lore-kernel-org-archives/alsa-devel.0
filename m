From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [patch] bugfix and clean driver/pci/asihpi/hpi6205.[ch]
Date: Thu, 24 May 2007 10:05:29 +1200
Message-ID: <200705241005.29822.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary="Boundary-00=_pqLVG6RRa1/a++4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 29BD02468D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 00:05:24 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JII008G5LCVUQ00@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 24 May 2007 10:05:20 +1200 (NZST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_pqLVG6RRa1/a++4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached patch Signed-off-by: Eliot Blennerhassett 
<eblennerhassett@audioscience.com>

Patch makes power of 2 buffering unconditional.
and fixes incorrect buffer allocation when requested size was rounded up to a 
power of 2.

--
Eliot


--Boundary-00=_pqLVG6RRa1/a++4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-driver-hg3285_hpi6205.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-driver-hg3285_hpi6205.patch"

diff -r 5c25d0e8819c pci/asihpi/hpi6205.c
--- a/pci/asihpi/hpi6205.c	Fri May 18 17:56:53 2007 +0200
+++ b/pci/asihpi/hpi6205.c	Thu May 24 09:28:43 2007 +1200
@@ -728,11 +728,6 @@ static void AdapterGetAsserts(HPI_ADAPTE
 	return;
 }
 
-#ifdef HPI6205_POW2BUFFERING
-/* Helper functions for power of 2 buffering */
-
-#endif
-
 //////////////////////////////////////////////////////////////////////
 //                                              OutStream Host buffer functions
 //////////////////////////////////////////////////////////////////////
@@ -747,11 +742,7 @@ static void OutStreamHostBufferAllocate(
 	tBusMasteringInterfaceBuffer *interface = pHw6205->pInterfaceBuffer;
 
 	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
-#ifdef HPI6205_POW2BUFFERING
 	dwSizeToAllocate = roundup_pow_of_two(phm->u.d.u.Buffer.dwBufferSize);
-#else
-	dwSizeToAllocate = phm->u.d.u.Buffer.dwBufferSize;
-#endif
 	phr->u.d.u.stream_info.dwDataAvailable =
 	    pHw6205->OutStreamHostBufferSize[phm->u.d.wStreamIndex];
 	phr->u.d.u.stream_info.dwBufferSize = dwSizeToAllocate;
@@ -775,8 +766,7 @@ static void OutStreamHostBufferAllocate(
 			    HpiOs_LockedMem_Alloc(&pHw6205->
 						  OutStreamHostBuffers[phm->u.d.
 								       wStreamIndex],
-						  phm->u.d.u.Buffer.
-						  dwBufferSize,
+						  dwSizeToAllocate,
 						  pao->Pci.pOsData);
 
 			if (wError) {
@@ -809,7 +799,7 @@ static void OutStreamHostBufferAllocate(
 		status->dwStreamState = HPI_STATE_STOPPED;
 		status->dwDSPIndex = 0;
 		status->dwHostIndex = status->dwDSPIndex;
-		status->dwSizeInBytes = phm->u.d.u.Buffer.dwBufferSize;
+		status->dwSizeInBytes = dwSizeToAllocate;
 		wError =
 		    HpiOs_LockedMem_GetPhysAddr(pHw6205->
 						OutStreamHostBuffers[phm->u.d.
@@ -866,26 +856,11 @@ HPI_InitResponse( phr, HPI_OBJ_OSTREAM, 
 */
 }
 
-#ifdef HPI6205_POW2BUFFERING
 static long OutStreamGetSpaceAvailable(H620_HOSTBUFFER_STATUS * status)
 {
 	return status->dwSizeInBytes - ((long)(status->dwHostIndex) -
 					(long)(status->dwDSPIndex));
 }
-#else
-static long OutStreamGetSpaceAvailable(H620_HOSTBUFFER_STATUS * status)
-{
-	long nDiff;
-
-// When dwDSPindex==dwHostIndex the buffer is empty
-// Need to add code to the HOST to make sure that the buffer is never filled
-// to the point that dwDSPindex==dwHostIndex.
-	nDiff = (long)(status->dwDSPIndex) - (long)(status->dwHostIndex) - 4;	// - 4 bytes at end so we don't overfill
-	if (nDiff < 0)
-		nDiff += status->dwSizeInBytes;
-	return nDiff;
-}
-#endif
 
 static void OutStreamWrite(HPI_ADAPTER_OBJ * pao, HPI_MESSAGE * phm,
 			   HPI_RESPONSE * phr)
@@ -925,7 +900,7 @@ static void OutStreamWrite(HPI_ADAPTER_O
 		phr->wError = HPI_ERROR_INVALID_DATASIZE;
 		return;
 	}
-#ifdef HPI6205_POW2BUFFERING
+
 /* either all data, or enough to fit from current to end of BBM buffer */
 	lFirstWrite = min(phm->u.d.u.Data.dwDataSize,
 			  status->dwSizeInBytes -
@@ -938,31 +913,6 @@ static void OutStreamWrite(HPI_ADAPTER_O
 	       phm->u.d.u.Data.dwDataSize - lFirstWrite);
 
 	status->dwHostIndex += phm->u.d.u.Data.dwDataSize;
-#else
-	lFirstWrite = status->dwSizeInBytes - status->dwHostIndex;
-	if (lFirstWrite > (long)phm->u.d.u.Data.dwDataSize)
-		lFirstWrite = (long)phm->u.d.u.Data.dwDataSize;
-
-	{
-		u32 dwHostIndex = status->dwHostIndex;
-		long lSecondWrite =
-		    (long)phm->u.d.u.Data.dwDataSize - lFirstWrite;;
-
-		CheckBeforeBBMCopy(status, pBBMData, lFirstWrite, lSecondWrite);
-		memcpy(&pBBMData[dwHostIndex], &pAppData[0], lFirstWrite);
-		dwHostIndex += (u32) lFirstWrite;
-		if (dwHostIndex >= status->dwSizeInBytes)
-			dwHostIndex -= status->dwSizeInBytes;
-		if (lSecondWrite) {
-			memcpy(&pBBMData[dwHostIndex], &pAppData[lFirstWrite],
-			       lSecondWrite);
-			dwHostIndex += (u32) lSecondWrite;
-			if (dwHostIndex >= status->dwSizeInBytes)
-				dwHostIndex -= status->dwSizeInBytes;
-		}
-		status->dwHostIndex = dwHostIndex;
-	}
-#endif
 }
 
 static void OutStreamGetInfo(HPI_ADAPTER_OBJ * pao, HPI_MESSAGE * phm,
@@ -1022,11 +972,7 @@ static void InStreamHostBufferAllocate(H
 	tBusMasteringInterfaceBuffer *interface = pHw6205->pInterfaceBuffer;
 
 	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
-#ifdef HPI6205_POW2BUFFERING
 	dwSizeToAllocate = roundup_pow_of_two(phm->u.d.u.Buffer.dwBufferSize);
-#else
-	dwSizeToAllocate = phm->u.d.u.Buffer.dwBufferSize;
-#endif
 	phr->u.d.u.stream_info.dwDataAvailable =
 	    pHw6205->InStreamHostBufferSize[phm->u.d.wStreamIndex];
 	phr->u.d.u.stream_info.dwBufferSize = dwSizeToAllocate;
@@ -1049,8 +995,7 @@ static void InStreamHostBufferAllocate(H
 			    HpiOs_LockedMem_Alloc(&pHw6205->
 						  InStreamHostBuffers[phm->u.d.
 								      wStreamIndex],
-						  phm->u.d.u.Buffer.
-						  dwBufferSize,
+						  dwSizeToAllocate,
 						  pao->Pci.pOsData);
 
 			if (wError) {
@@ -1082,7 +1027,7 @@ static void InStreamHostBufferAllocate(H
 		status->dwStreamState = HPI_STATE_STOPPED;
 		status->dwDSPIndex = 0;
 		status->dwHostIndex = status->dwDSPIndex;
-		status->dwSizeInBytes = phm->u.d.u.Buffer.dwBufferSize;
+		status->dwSizeInBytes = dwSizeToAllocate;
 		wError =
 		    HpiOs_LockedMem_GetPhysAddr(pHw6205->
 						InStreamHostBuffers[phm->u.d.
@@ -1163,25 +1108,10 @@ nValue = (nValue+1) & 0x7fff;
 	HW_Message(pao, phm, phr);
 }
 
-#ifdef HPI6205_POW2BUFFERING
 static long InStreamGetBytesAvailable(H620_HOSTBUFFER_STATUS * status)
 {
 	return (long)(status->dwDSPIndex) - (long)(status->dwHostIndex);
 }
-#else
-static long InStreamGetBytesAvailable(H620_HOSTBUFFER_STATUS * status)
-{
-	long nDiff;
-
-// When dwDSPindex==dwHostIndex the buffer is empty
-// Need to add code to the DSP to make sure that the buffer is never fulled
-// to the point that dwDSPindex==dwHostIndex.
-	nDiff = (long)(status->dwDSPIndex) - (long)(status->dwHostIndex);
-	if (nDiff < 0)
-		nDiff += status->dwSizeInBytes;
-	return nDiff;
-}
-#endif
 
 static void InStreamRead(HPI_ADAPTER_OBJ * pao, HPI_MESSAGE * phm,
 			 HPI_RESPONSE * phr)
@@ -1216,7 +1146,7 @@ long *pTest;
 		phr->wError = HPI_ERROR_INVALID_DATASIZE;
 		return;
 	}
-#ifdef HPI6205_POW2BUFFERING
+
 /* either all data, or enough to fit from current to end of BBM buffer */
 	lFirstRead = min(phm->u.d.u.Data.dwDataSize,
 			 status->dwSizeInBytes -
@@ -1231,45 +1161,6 @@ long *pTest;
 	       phm->u.d.u.Data.dwDataSize - lFirstRead);
 
 	status->dwHostIndex += phm->u.d.u.Data.dwDataSize;
-#else
-	lFirstRead = status->dwSizeInBytes - status->dwHostIndex;
-	if (lFirstRead > (long)phm->u.d.u.Data.dwDataSize)
-		lFirstRead = (long)phm->u.d.u.Data.dwDataSize;
-
-	{			// avoid having status->dwHostIndex invalid, even momentarily
-		u32 dwHostIndex = status->dwHostIndex;
-		long lSecondRead =
-		    (long)phm->u.d.u.Data.dwDataSize - lFirstRead;
-
-		memcpy(&pAppData[0], &pBBMData[dwHostIndex], lFirstRead);
-		dwHostIndex += (u32) lFirstRead;
-		if (dwHostIndex >= status->dwSizeInBytes)
-			dwHostIndex -= status->dwSizeInBytes;
-		if (lSecondRead) {
-			memcpy(&pAppData[lFirstRead], &pBBMData[dwHostIndex],
-			       lSecondRead);
-			dwHostIndex += (u32) lSecondRead;
-			if (dwHostIndex >= status->dwSizeInBytes)
-				dwHostIndex -= status->dwSizeInBytes;
-		}
-		status->dwHostIndex = dwHostIndex;
-	}
-#endif
-/* DBEUG */
-/*
-pTest = (long *)phm->u.d.u.Data.dwpbData;
-for(i=0;i<phm->u.d.u.Data.dwDataSize/sizeof(long);i++)
-{
-if(pTest[i])
-pTest[i]--;
-}
-pTest = (long *)((char *)buffer) + sizeof(H620_HOSTBUFFER_STATUS);
-for(i=0;i<buffer->dwSizeInBytes/sizeof(long);i++)
-{
-if(pTest[i])
-pTest[i]--;
-}
-*/
 }
 
 static void InStreamGetInfo(HPI_ADAPTER_OBJ * pao, HPI_MESSAGE * phm,
diff -r 5c25d0e8819c pci/asihpi/hpi6205.h
--- a/pci/asihpi/hpi6205.h	Fri May 18 17:56:53 2007 +0200
+++ b/pci/asihpi/hpi6205.h	Thu May 24 09:28:39 2007 +1200
@@ -27,15 +27,9 @@ Copyright AudioScience, Inc., 2003
 
 #include "hpi.h"
 
-/** Enable buffering using buffers restricted to power of 2 length.
-Simplifies R/W pointer wrap logic. Allows buffers to be completely filled
-*/
-#define HPI6205_POW2BUFFERING
-
 /***********************************************************
 Defines used for basic messaging
 ************************************************************/
-
 #define H620_HIF_RESET          0
 #define H620_HIF_IDLE           1
 #define H620_HIF_GET_RESP       2

--Boundary-00=_pqLVG6RRa1/a++4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_pqLVG6RRa1/a++4--
