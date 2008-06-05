From: linux@audioscience.com
Subject: [PATCH - ASIHPI 7/8] Support variable size cached
	control information.
Date: Thu, 05 Jun 2008 16:07:00 +1200
Message-ID: <1212638821-2779-7-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
	<1212638821-2779-3-git-send-email-linux@audioscience.com>
	<1212638821-2779-4-git-send-email-linux@audioscience.com>
	<1212638821-2779-5-git-send-email-linux@audioscience.com>
	<1212638821-2779-6-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 505B8103852
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:19 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:17 +1200 (NZST)
In-reply-to: <1212638821-2779-6-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <linux@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index ec2ae66..6d1834e 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -158,6 +158,7 @@ struct hpi_hw_obj {
 	u16 wDspCrashed;	/* when '1' DSP has crashed/died/OTL */
 
 	struct hpi_control_cache_single aControlCache[HPI_NMIXER_CONTROLS];
+	struct hpi_control_cache *pCache;
 };
 
 static u16 Hpi6000_DspBlockWrite32(
@@ -319,8 +320,7 @@ static void ControlMessage(
 			}
 
 			if (HpiCheckControlCache
-				(&((struct hpi_hw_obj *)pao->priv)->
-					aControlCache[phm->u.c.wControlIndex],
+				(((struct hpi_hw_obj *)pao->priv)->pCache,
 					phm, phr))
 				break;
 		}
@@ -331,8 +331,8 @@ static void ControlMessage(
 		break;
 	case HPI_CONTROL_SET_STATE:
 		HW_Message(pao, phm, phr);
-		HpiSyncControlCache(&((struct hpi_hw_obj *)pao->priv)->
-			aControlCache[phm->u.c.wControlIndex], phm, phr);
+		HpiSyncControlCache(
+			((struct hpi_hw_obj *)pao->priv)->pCache, phm, phr);
 		break;
 	default:
 		phr->wError = HPI_ERROR_INVALID_FUNC;
@@ -431,7 +431,7 @@ void HPI_6000(
 	/* subsytem messages get executed by every HPI. */
 	/* All other messages are ignored unless the adapter index matches */
 	/* an adapter in the HPI */
-	HPI_DEBUG_LOG(DEBUG, "O %d,F %d\n", phm->wObject, phm->wFunction);
+	HPI_DEBUG_LOG(DEBUG, "O %d,F %x\n", phm->wObject, phm->wFunction);
 
 	/* if Dsp has crashed then do not communicate with it any more */
 	if (phm->wObject != HPI_OBJ_SUBSYSTEM) {
@@ -573,15 +573,19 @@ static void SubSysDeleteAdapter(
 )
 {
 	struct hpi_adapter_obj *pao = NULL;
-	void *priv;
+	struct hpi_hw_obj *phw;
 
 	pao = HpiFindAdapter(phm->wAdapterIndex);
 	if (!pao)
 		return;
 
-	priv = pao->priv;
+	phw = (struct hpi_hw_obj *)pao->priv;
+
+	if (pao->wHasControlCache)
+		HpiFreeControlCache(phw->pCache);
+
 	HpiDeleteAdapter(pao);
-	kfree(priv);
+	kfree(phw);
 
 	phr->wError = 0;
 }
@@ -594,6 +598,8 @@ static short CreateAdapterObj(
 {
 	short nBootError = 0;
 	u32 dwDspIndex = 0;
+	u32 dwControlCacheSize = 0;
+	u32 dwControlCacheCount = 0;
 	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
 
 	/* init error reporting */
@@ -693,10 +699,18 @@ static short CreateAdapterObj(
 		sizeof(struct hpi_control_cache_single) *
 		HPI_NMIXER_CONTROLS);
 	/* Read the control cache length to figure out if it is turned on */
-	if (HpiReadWord
-		(&phw->ado[0], HPI_HIF_ADDR(dwControlCacheSizeInBytes)))
+	dwControlCacheSize = HpiReadWord(&phw->ado[0],
+		HPI_HIF_ADDR(dwControlCacheSizeInBytes));
+	if (dwControlCacheSize) {
+		dwControlCacheCount = HpiReadWord(&phw->ado[0],
+			HPI_HIF_ADDR(dwControlCacheCount));
 		pao->wHasControlCache = 1;
-	else
+
+		phw->pCache = HpiAllocControlCache(dwControlCacheCount,
+			dwControlCacheSize, (struct hpi_control_cache_info *)
+			&phw->aControlCache[0]
+			);
+	} else
 		pao->wHasControlCache = 0;
 
 	HPI_DEBUG_LOG(DEBUG, "Get adapter info ASI%04X index %d\n",
diff --git a/pci/asihpi/hpi6000.h b/pci/asihpi/hpi6000.h
index ba75b0b..348ad8d 100644
--- a/pci/asihpi/hpi6000.h
+++ b/pci/asihpi/hpi6000.h
@@ -45,6 +45,7 @@ struct hpi_hif_6000 {
 	u32 dwControlCacheIsDirty;
 	u32 dwControlCacheAddress;
 	u32 dwControlCacheSizeInBytes;
+	u32 dwControlCacheCount;
 };
 
 #define HPI_HIF_PACK_ADAPTER_INFO(adapter, versionMajor, versionMinor) \
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index b74add0..ff010a7 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -126,8 +126,10 @@ struct hpi_hw_obj {
 
 	struct consistent_dma_area hControlCache;
 	struct consistent_dma_area hAsyncEventBuffer;
-	struct hpi_control_cache_single *pControlCache;
+/*      struct hpi_control_cache_single *pControlCache; */
 	struct hpi_async_event *pAsyncEventBuffer;
+	struct hpi_control_cache *pCache;
+
 };
 
 /*****************************************************************************/
@@ -172,12 +174,6 @@ static void SubSysDeleteAdapter(
 	struct hpi_response *phr
 );
 
-static void AdapterGetAsserts(
-	struct hpi_adapter_obj *pao,
-	struct hpi_message *phm,
-	struct hpi_response *phr
-);
-
 static u16 CreateAdapterObj(
 	struct hpi_adapter_obj *pao,
 	u32 *pdwOsErrorCode
@@ -325,9 +321,7 @@ static void ControlMessage(
 	case HPI_CONTROL_GET_STATE:
 		if (pao->wHasControlCache) {
 			rmb();	/* make sure we see updates DMAed from DSP */
-			if (HpiCheckControlCache
-				(&pHw6205->pControlCache[phm->u.c.
-						wControlIndex], phm, phr))
+			if (HpiCheckControlCache(pHw6205->pCache, phm, phr))
 				break;
 		}
 		HW_Message(pao, phm, phr);
@@ -338,9 +332,7 @@ static void ControlMessage(
 	case HPI_CONTROL_SET_STATE:
 		HW_Message(pao, phm, phr);
 		if (pao->wHasControlCache)
-			HpiSyncControlCache(&pHw6205->
-				pControlCache[phm->u.c.
-					wControlIndex], phm, phr);
+			HpiSyncControlCache(pHw6205->pCache, phm, phr);
 		break;
 	default:
 		phr->wError = HPI_ERROR_INVALID_FUNC;
@@ -354,14 +346,7 @@ static void AdapterMessage(
 	struct hpi_response *phr
 )
 {
-
 	switch (phm->wFunction) {
-	case HPI_ADAPTER_GET_INFO:
-		HW_Message(pao, phm, phr);
-		break;
-	case HPI_ADAPTER_GET_ASSERT:
-		AdapterGetAsserts(pao, phm, phr);
-		break;
 	default:
 		HW_Message(pao, phm, phr);
 		break;
@@ -506,6 +491,7 @@ void HPI_6205(
 			AdapterMessage(pao, phm, phr);
 			break;
 
+		case HPI_OBJ_CONTROLEX:
 		case HPI_OBJ_CONTROL:
 			ControlMessage(pao, phm, phr);
 			break;
@@ -694,20 +680,25 @@ static u16 CreateAdapterObj(
 	 * Allocate bus mastering control cache buffer and tell the DSP about it
 	 */
 	if (interface->aControlCache.dwNumberOfControls) {
+		void *pControlCacheVirtual;
+
 		err = HpiOs_LockedMem_Alloc(&pHw6205->hControlCache,
-			interface->aControlCache.
-			dwNumberOfControls *
-			sizeof(struct hpi_control_cache_single),
+			interface->aControlCache.dwSizeInBytes,
 			pao->Pci.pOsData);
 		if (!err)
 			err = HpiOs_LockedMem_GetVirtAddr(&pHw6205->
-				hControlCache, (void *)
-				&pHw6205->pControlCache);
-		if (!err)
-			memset((void *)pHw6205->pControlCache, 0,
-				interface->aControlCache.
-				dwNumberOfControls *
-				sizeof(struct hpi_control_cache_single));
+				hControlCache, &pControlCacheVirtual);
+		if (!err) {
+			memset(pControlCacheVirtual, 0,
+				interface->aControlCache.dwSizeInBytes);
+
+			pHw6205->pCache =
+				HpiAllocControlCache(interface->aControlCache.
+				dwNumberOfControls,
+				interface->aControlCache.dwSizeInBytes,
+				(struct hpi_control_cache_info *)
+				pControlCacheVirtual);
+		}
 		if (!err) {
 			err = HpiOs_LockedMem_GetPhysAddr(&pHw6205->
 				hControlCache, &dwPhysAddr);
@@ -718,10 +709,8 @@ static u16 CreateAdapterObj(
 		if (!err)
 			pao->wHasControlCache = 1;
 		else {
-			if (HpiOs_LockedMem_Valid(&pHw6205->hControlCache)) {
+			if (HpiOs_LockedMem_Valid(&pHw6205->hControlCache))
 				HpiOs_LockedMem_Free(&pHw6205->hControlCache);
-				pHw6205->pControlCache = NULL;
-			}
 			pao->wHasControlCache = 0;
 		}
 	}
@@ -816,7 +805,7 @@ static void DeleteAdapterObj(
 
 	if (HpiOs_LockedMem_Valid(&pHw6205->hControlCache)) {
 		HpiOs_LockedMem_Free(&pHw6205->hControlCache);
-		pHw6205->pControlCache = NULL;
+		HpiFreeControlCache(pHw6205->pCache);
 	}
 
 	if (HpiOs_LockedMem_Valid(&pHw6205->hLockedMem)) {
@@ -846,19 +835,6 @@ static void DeleteAdapterObj(
 }
 
 /*****************************************************************************/
-/* ADAPTER */
-
-static void AdapterGetAsserts(
-	struct hpi_adapter_obj *pao,
-	struct hpi_message *phm,
-	struct hpi_response *phr
-)
-{
-	HW_Message(pao, phm, phr);	/*get DSP asserts */
-	return;
-}
-
-/*****************************************************************************/
 /* OutStream Host buffer functions */
 
 /** Allocate or attach buffer for busmastering
diff --git a/pci/asihpi/hpi6205.h b/pci/asihpi/hpi6205.h
index c5309cb..2c92d59 100644
--- a/pci/asihpi/hpi6205.h
+++ b/pci/asihpi/hpi6205.h
@@ -67,7 +67,7 @@ This is used for dynamic control cache allocation
 struct controlcache_6205 {
 	u32 dwNumberOfControls;
 	u32 dwPhysicalPCI32address;
-	u32 dwSpare;
+	u32 dwSizeInBytes;
 };
 
 /*********************************************************************
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 29fe40f..af83a2e 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -21,6 +21,7 @@
 (C) Copyright AudioScience Inc. 1998-2003
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpicmn.c"
+
 #include "hpi.h"
 #include "hpidebug.h"
 #include "hpicmn.h"
@@ -106,12 +107,16 @@ struct hpi_adapter_obj *HpiFindAdapter(
 
 	pao = &adapters.adapter[wAdapterIndex];
 	if (pao->wAdapterType != 0) {
-		HPI_DEBUG_LOG(VERBOSE, "Found adapter index %d\n",
-			wAdapterIndex);
+		/*
+		   HPI_DEBUG_LOG(VERBOSE, "Found adapter index %d\n",
+		   wAdapterIndex);
+		 */
 		return (pao);
 	} else {
-		HPI_DEBUG_LOG(VERBOSE, "No adapter index %d\n",
-			wAdapterIndex);
+		/*
+		   HPI_DEBUG_LOG(VERBOSE, "No adapter index %d\n",
+		   wAdapterIndex);
+		 */
 		return (NULL);
 	}
 }
@@ -171,25 +176,141 @@ static void SubSysGetAdapters(
 	phr->wError = 0;	/* the function completed OK; */
 }
 
-/**
-* CheckControlCache checks if a given struct hpi_control_cache_single control
-* value is in the cache and fills the struct hpi_response accordingly.
-* It returns nonzero if a cache hit occurred, zero otherwise.
+static unsigned int ControlCacheAllocCheck(
+	struct hpi_control_cache *pC
+)
+{
+	unsigned int i;
+	int nCached = 0;
+	if (!pC)
+		return 0;
+	if ((!pC->dwInit) &&
+		(pC->pCache != NULL) &&
+		(pC->dwControlCount) && (pC->dwCacheSizeInBytes)
+		) {
+		u32 *pMasterCache;
+		pC->dwInit = 1;
+
+		pMasterCache = (u32 *)pC->pCache;
+		for (i = 0; i < pC->dwControlCount; i++) {
+			struct hpi_control_cache_info *info =
+				(struct hpi_control_cache_info *)pMasterCache;
+
+			if (info->ControlType) {
+				pC->pInfo[i] = info;
+				nCached++;
+			} else
+				pC->pInfo[i] = NULL;
+
+			if (info->nSizeIn32bitWords)
+				pMasterCache += info->nSizeIn32bitWords;
+			else
+				pMasterCache +=
+					sizeof(struct
+					hpi_control_cache_single) /
+					sizeof(u32);
+
+		}
+		/*
+		   We didn't find anything to cache, so try again later !
+		 */
+		if (!nCached)
+			pC->dwInit = 0;
+	}
+	return pC->dwInit;
+}
+
+/** Find a control.
+*/
+static short FindControl(
+	struct hpi_message *phm,
+	struct hpi_control_cache *pCache,
+	struct hpi_control_cache_info **pI,
+	u16 *pwControlIndex
+)
+{
+	if (phm->wObject == HPI_OBJ_CONTROL) {
+		*pwControlIndex = phm->u.c.wControlIndex;
+	} else {	/* controlex */
+		*pwControlIndex = phm->u.cx.wControlIndex;
+		HPI_DEBUG_LOG(VERBOSE,
+			"HpiCheckControlCache() ControlEx %d\n",
+			*pwControlIndex);
+	}
+
+	if (!ControlCacheAllocCheck(pCache)) {
+		HPI_DEBUG_LOG(VERBOSE,
+			"ControlCacheAllocCheck() failed. adap%d ci%d\n",
+			phm->wAdapterIndex, *pwControlIndex);
+		return 0;
+	}
+
+	*pI = pCache->pInfo[*pwControlIndex];
+	if (!*pI) {
+		HPI_DEBUG_LOG(VERBOSE,
+			"Uncached Adap %d, Control %d\n",
+			phm->wAdapterIndex, *pwControlIndex);
+		return 0;
+	} else {
+		HPI_DEBUG_LOG(VERBOSE,
+			"HpiCheckControlCache() Type %d\n",
+			(*pI)->ControlType);
+	}
+	return 1;
+}
+
+/** Used by the kernel driver to figure out if a buffer needs mapping.
+ */
+short HpiCheckBufferMapping(
+	struct hpi_control_cache *pCache,
+	struct hpi_message *phm,
+	void **p,
+	unsigned int *pN
+)
+{
+	*pN = 0;
+	*p = NULL;
+	if ((phm->wFunction == HPI_CONTROL_GET_STATE) &&
+		(phm->wObject == HPI_OBJ_CONTROLEX)
+		) {
+		u16 wControlIndex;
+		struct hpi_control_cache_info *pI;
+
+		if (!FindControl(phm, pCache, &pI, &wControlIndex))
+			return 0;
+	}
+	return 0;
+}
+
+/** CheckControlCache checks the cache and fills the struct hpi_response
+* accordingly. It returns one if a cache hit occurred, zero otherwise.
 */
 short HpiCheckControlCache(
-	struct hpi_control_cache_single *pC,
+	struct hpi_control_cache *pCache,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 )
 {
 	short found = 1;
-	/* if the control type in the cache is non-zero then */
-	/* we have cached control information to process */
+	u16 wControlIndex;
+	struct hpi_control_cache_info *pI;
+	struct hpi_control_cache_single *pC;
+
+	if (!FindControl(phm, pCache, &pI, &wControlIndex))
+		return 0;
+
 	phr->wSize =
 		sizeof(struct hpi_response_header) +
 		sizeof(struct hpi_control_res);
 	phr->wError = 0;
-	switch (pC->ControlType) {
+
+	/* pC is the default cached control strucure. May be cast to
+	   something else in the following switch statement.
+	 */
+	pC = (struct hpi_control_cache_single *)pI;
+
+	switch (pI->ControlType) {
+
 	case HPI_CONTROL_METER:
 		if (phm->u.c.wAttribute == HPI_METER_PEAK) {
 			phr->u.c.anLogValue[0] = pC->u.p.anLogPeak[0];
@@ -198,45 +319,50 @@ short HpiCheckControlCache(
 			phr->u.c.anLogValue[0] = pC->u.p.anLogRMS[0];
 			phr->u.c.anLogValue[1] = pC->u.p.anLogRMS[1];
 		} else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_VOLUME:
 		if (phm->u.c.wAttribute == HPI_VOLUME_GAIN) {
 			phr->u.c.anLogValue[0] = pC->u.v.anLog[0];
 			phr->u.c.anLogValue[1] = pC->u.v.anLog[1];
 		} else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_MULTIPLEXER:
 		if (phm->u.c.wAttribute == HPI_MULTIPLEXER_SOURCE) {
 			phr->u.c.dwParam1 = pC->u.x.wSourceNodeType;
 			phr->u.c.dwParam2 = pC->u.x.wSourceNodeIndex;
 		} else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_CHANNEL_MODE:
 		if (phm->u.c.wAttribute == HPI_CHANNEL_MODE_MODE)
 			phr->u.c.dwParam1 = pC->u.m.wMode;
 		else
-			found = 0;	/* signal that message was not cached */
-
+			found = 0;
+		break;
 	case HPI_CONTROL_LEVEL:
 		if (phm->u.c.wAttribute == HPI_LEVEL_GAIN) {
 			phr->u.c.anLogValue[0] = pC->u.l.anLog[0];
 			phr->u.c.anLogValue[1] = pC->u.l.anLog[1];
 		} else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_TUNER:
-		if (phm->u.c.wAttribute == HPI_TUNER_FREQ)
-			phr->u.c.dwParam1 = pC->u.t.dwFreqInkHz;
-		else if (phm->u.c.wAttribute == HPI_TUNER_BAND)
-			phr->u.c.dwParam1 = pC->u.t.wBand;
-		else if ((phm->u.c.wAttribute == HPI_TUNER_LEVEL) &&
-			(phm->u.c.dwParam1 == HPI_TUNER_LEVEL_AVERAGE))
-			phr->u.c.dwParam1 = pC->u.t.wLevel;
-		else
-			found = 0;	/* signal that message was not cached */
+		{
+			struct hpi_control_cache_single *pCT =
+				(struct hpi_control_cache_single *)pI;
+			if (phm->u.c.wAttribute == HPI_TUNER_FREQ)
+				phr->u.c.dwParam1 = pCT->u.t.dwFreqInkHz;
+			else if (phm->u.c.wAttribute == HPI_TUNER_BAND)
+				phr->u.c.dwParam1 = pCT->u.t.wBand;
+			else if ((phm->u.c.wAttribute == HPI_TUNER_LEVEL) &&
+				(phm->u.c.dwParam1 ==
+					HPI_TUNER_LEVEL_AVERAGE))
+				phr->u.c.dwParam1 = pCT->u.t.wLevel;
+			else
+				found = 0;
+		}
 		break;
 	case HPI_CONTROL_AESEBU_RECEIVER:
 		if (phm->u.c.wAttribute == HPI_AESEBURX_ERRORSTATUS)
@@ -244,26 +370,26 @@ short HpiCheckControlCache(
 		else if (phm->u.c.wAttribute == HPI_AESEBURX_FORMAT)
 			phr->u.c.dwParam1 = pC->u.aes3rx.dwSource;
 		else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_AESEBU_TRANSMITTER:
 		if (phm->u.c.wAttribute == HPI_AESEBUTX_FORMAT)
 			phr->u.c.dwParam1 = pC->u.aes3tx.dwFormat;
 		else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_TONEDETECTOR:
 		if (phm->u.c.wAttribute == HPI_TONEDETECTOR_STATE)
 			phr->u.c.dwParam1 = pC->u.tone.wState;
 		else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_SILENCEDETECTOR:
 		if (phm->u.c.wAttribute == HPI_SILENCEDETECTOR_STATE) {
 			phr->u.c.dwParam1 = pC->u.silence.dwState;
 			phr->u.c.dwParam2 = pC->u.silence.dwCount;
 		} else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
 		break;
 	case HPI_CONTROL_SAMPLECLOCK:
 		if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SOURCE)
@@ -278,17 +404,105 @@ short HpiCheckControlCache(
 		} else if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SAMPLERATE)
 			phr->u.c.dwParam1 = pC->u.clk.dwSampleRate;
 		else
-			found = 0;	/* signal that message was not cached */
+			found = 0;
+		break;
+#ifndef HPI_OS_WIN16	/* SGT - below does not compile in Borland C */
+	case HPI_CONTROL_PAD:
+		{
+			struct hpi_control_cache_pad *pPad =
+				(struct hpi_control_cache_pad *)pC;
+
+			if (!(pPad->dwFieldValidFlags &
+					(1 << HPI_CTL_ATTR_INDEX(phm->u.c.
+							wAttribute)))) {
+				/* attribute not supported */
+				phr->wError =
+					HPI_ERROR_INVALID_CONTROL_ATTRIBUTE;
+				break;
+			}
+
+			if (phm->u.c.wAttribute == HPI_PAD_PROGRAM_ID)
+				phr->u.c.dwParam1 = pPad->dwPI;
+			else if (phm->u.c.wAttribute == HPI_PAD_PROGRAM_TYPE)
+				phr->u.c.dwParam1 = pPad->dwPTY;
+			else {
+				struct attribs {
+					u8 *pData;
+					unsigned int nSize;
+				};
+				struct attribs aDesc[] = {
+					{NULL, 0},
+					/* HPI_PAD_CHANNEL_NAME */
+					{pPad->cChannel, sizeof(pPad->
+								cChannel)}
+					,
+					/* HPI_PAD_ARTIST */
+					{pPad->cArtist, sizeof(pPad->cArtist)}
+					,
+					/* HPI_PAD_TITLE */
+					{pPad->cTitle, sizeof(pPad->cTitle)}
+					,
+					/* HPI_PAD_COMMENT */
+					{pPad->cComment, sizeof(pPad->
+								cComment)}
+					,
+				};
+
+				const u32 dwAttribute = phm->u.c.wAttribute;
+				const u32 dwIndex =
+					HPI_CTL_ATTR_INDEX(dwAttribute);
+				const u32 dwOffset = phm->u.c.dwParam1;
+				int nStringLength = 0;
+				int nRemainingChars = 0;
+
+				HPI_DEBUG_LOG(VERBOSE, "PADS control\n");
+
+				/* check the field type */
+				HPI_DEBUG_LOG(VERBOSE,
+					"PADS HPI_PADS_ %d\n", dwAttribute);
+
+				switch (dwAttribute) {
+				case HPI_PAD_CHANNEL_NAME:
+				case HPI_PAD_ARTIST:
+				case HPI_PAD_TITLE:
+				case HPI_PAD_COMMENT:
+					break;
+				default:
+					phr->wError = HPI_ERROR_INVALID_FUNC;
+				}
+				if (phr->wError)
+					break;
+
+				nStringLength = strlen(aDesc[dwIndex].pData);
+				if (dwOffset > (unsigned)nStringLength) {
+					phr->wError =
+						HPI_ERROR_INVALID_CONTROL_VALUE;
+					break;
+				}
+				HPI_DEBUG_LOG(VERBOSE,
+					"PADS memcpy (%d), offset %d \n",
+					8, dwOffset);
+				memcpy(&phr->u.cu.chars8.szData[0],
+					&aDesc[dwIndex].pData[dwOffset], 8);
+				nRemainingChars =
+					nStringLength - dwOffset - 8;
+				if (nRemainingChars < 0)
+					nRemainingChars = 0;
+				phr->u.cu.chars8.dwRemainingChars =
+					nRemainingChars;
+			}
+		}
 		break;
+#endif
 	default:
-		found = 0;	/* signal that message was not cached */
+		found = 0;
 		break;
 	}
-	if (found == 0)
-		HPI_DEBUG_LOG(VERBOSE, "Adap %d, Control %d, "
-			"Control type %d, Cached %d\n",
-			phm->wAdapterIndex, pC->ControlIndex,
-			pC->ControlType, found);
+	if (pI->ControlType && !found)
+		HPI_DEBUG_LOG(VERBOSE,
+			"Uncached Adap %d, Control %d, Control type %d\n",
+			phm->wAdapterIndex, pI->ControlIndex,
+			pI->ControlType);
 
 	return found;
 }
@@ -300,15 +514,24 @@ Volume and Level return the limited values in the response, so use these
 Multiplexer does so use sent values
 */
 void HpiSyncControlCache(
-	struct hpi_control_cache_single *pC,
+	struct hpi_control_cache *pCache,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 )
 {
-	if (phr->wError)
+	u16 wControlIndex;
+	struct hpi_control_cache_single *pC;
+	struct hpi_control_cache_info *pI;
+
+	if (!FindControl(phm, pCache, &pI, &wControlIndex))
 		return;
 
-	switch (pC->ControlType) {
+	/* pC is the default cached control strucure.
+	   May be cast to something else in the following switch statement.
+	 */
+	pC = (struct hpi_control_cache_single *)pI;
+
+	switch (pI->ControlType) {
 	case HPI_CONTROL_VOLUME:
 		if (phm->u.c.wAttribute == HPI_VOLUME_GAIN) {
 			pC->u.v.anLog[0] = phr->u.c.anLogValue[0];
@@ -323,8 +546,8 @@ void HpiSyncControlCache(
 		}
 		break;
 	case HPI_CONTROL_CHANNEL_MODE:
-		/* mux does not return its setting on Set command. */
-		if (phm->u.c.wAttribute == HPI_MULTIPLEXER_SOURCE)
+		/* mode does not return its setting on Set command. */
+		if (phm->u.c.wAttribute == HPI_CHANNEL_MODE_MODE)
 			pC->u.m.wMode = (u16)phm->u.c.dwParam1;
 		break;
 	case HPI_CONTROL_LEVEL:
@@ -340,6 +563,7 @@ void HpiSyncControlCache(
 	case HPI_CONTROL_AESEBU_RECEIVER:
 		if (phm->u.c.wAttribute == HPI_AESEBURX_FORMAT)
 			pC->u.aes3rx.dwSource = phm->u.c.dwParam1;
+		break;
 	case HPI_CONTROL_SAMPLECLOCK:
 		if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SOURCE)
 			pC->u.clk.wSource = (u16)phm->u.c.dwParam1;
@@ -358,6 +582,35 @@ void HpiSyncControlCache(
 		break;
 	}
 }
+struct hpi_control_cache *HpiAllocControlCache(
+	const u32 dwNumberOfControls,
+	const u32 dwSizeInBytes,
+	struct hpi_control_cache_info *pDSPControlBuffer
+)
+{
+	struct hpi_control_cache *pCache =
+		kmalloc(sizeof(*pCache), GFP_KERNEL);
+	pCache->dwCacheSizeInBytes = dwSizeInBytes;
+	pCache->dwControlCount = dwNumberOfControls;
+	pCache->pCache = (struct hpi_control_cache_single *)pDSPControlBuffer;
+	pCache->dwInit = 0;
+	pCache->pInfo =
+		kmalloc(sizeof(*pCache->pInfo) * pCache->dwControlCount,
+		GFP_KERNEL);
+	return pCache;
+}
+
+void HpiFreeControlCache(
+	struct hpi_control_cache *pCache
+)
+{
+	if ((pCache->dwInit) && (pCache->pInfo)) {
+		kfree(pCache->pInfo);
+		pCache->pInfo = NULL;
+		pCache->dwInit = 0;
+		kfree(pCache);
+	}
+}
 
 static void SubSysMessage(
 	struct hpi_message *phm,
diff --git a/pci/asihpi/hpicmn.h b/pci/asihpi/hpicmn.h
index 4b7692a..b0763e2 100644
--- a/pci/asihpi/hpicmn.h
+++ b/pci/asihpi/hpicmn.h
@@ -32,6 +32,18 @@ struct hpi_adapter_obj {
 	void *priv;
 };
 
+struct hpi_control_cache {
+	u32 dwInit;	       /**< indicates whether the
+				structures are initialized */
+	u32 dwControlCount;
+	u32 dwCacheSizeInBytes;
+	struct hpi_control_cache_info
+	**pInfo;		/**< pointer to allocated memory of
+				lookup pointers. */
+	struct hpi_control_cache_single
+	*pCache;		/**< pointer to DSP's control cache. */
+};
+
 struct hpi_adapter_obj *HpiFindAdapter(
 	u16 wAdapterIndex
 );
@@ -44,12 +56,22 @@ void HpiDeleteAdapter(
 );
 
 short HpiCheckControlCache(
-	struct hpi_control_cache_single *pC,
+	struct hpi_control_cache *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 );
+struct hpi_control_cache *HpiAllocControlCache(
+	const u32 dwNumberOfControls,
+	const u32 dwSizeInBytes,
+	struct hpi_control_cache_info
+	*pDSPControlBuffer
+);
+void HpiFreeControlCache(
+	struct hpi_control_cache *pCache
+);
+
 void HpiSyncControlCache(
-	struct hpi_control_cache_single *pC,
+	struct hpi_control_cache *pC,
 	struct hpi_message *phm,
 	struct hpi_response *phr
 );
@@ -57,3 +79,9 @@ u16 HpiValidateResponse(
 	struct hpi_message *phm,
 	struct hpi_response *phr
 );
+short HpiCheckBufferMapping(
+	struct hpi_control_cache *pCache,
+	struct hpi_message *phm,
+	void **p,
+	unsigned int *pN
+);
-- 
1.5.4.3
