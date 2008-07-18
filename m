From: linux@audioscience.com
Subject: [PATCH - asihpi 4/5] add extra checks to control cache
Date: Fri, 18 Jul 2008 18:00:18 +1200
Message-ID: <1216360819-1847-4-git-send-email-linux@audioscience.com>
References: <1216360819-1847-1-git-send-email-linux@audioscience.com>
	<1216360819-1847-2-git-send-email-linux@audioscience.com>
	<1216360819-1847-3-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1216360819-1847-3-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 4594a26..6543bf3 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -22,7 +22,7 @@
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpicmn.c"
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpidebug.h"
 #include "hpicmn.h"
 
@@ -304,8 +304,8 @@ short HpiCheckControlCache(
 		sizeof(struct hpi_control_res);
 	phr->wError = 0;
 
-	/* pC is the default cached control strucure.
-	   May be cast to something else in the following switch statement.
+	/* pC is the default cached control strucure. May be cast to
+	   something else in the following switch statement.
 	 */
 	pC = (struct hpi_control_cache_single *)pI;
 
@@ -406,7 +406,6 @@ short HpiCheckControlCache(
 		else
 			found = 0;
 		break;
-#ifndef HPI_OS_WIN16	/* SGT - below does not compile in Borland C */
 	case HPI_CONTROL_PAD:
 		{
 			struct hpi_control_cache_pad *pPad =
@@ -474,6 +473,8 @@ short HpiCheckControlCache(
 					break;
 
 				nStringLength = strlen(aDesc[dwIndex].pData);
+				if (nStringLength > (int)aDesc[dwIndex].nSize)
+					nStringLength = aDesc[dwIndex].nSize;
 				if (dwOffset > (unsigned)nStringLength) {
 					phr->wError =
 						HPI_ERROR_INVALID_CONTROL_VALUE;
@@ -486,14 +487,16 @@ short HpiCheckControlCache(
 					&aDesc[dwIndex].pData[dwOffset], 8);
 				nRemainingChars =
 					nStringLength - dwOffset - 8;
-				if (nRemainingChars < 0)
+				if (nRemainingChars < 0) {
 					nRemainingChars = 0;
+					phr->u.cu.chars8.szData[8 +
+						nRemainingChars] = 0;
+				}
 				phr->u.cu.chars8.dwRemainingChars =
 					nRemainingChars;
 			}
 		}
 		break;
-#endif
 	default:
 		found = 0;
 		break;
@@ -540,6 +543,8 @@ void HpiSyncControlCache(
 		break;
 	case HPI_CONTROL_MULTIPLEXER:
 		/* mux does not return its setting on Set command. */
+		if (phr->wError)
+			return;
 		if (phm->u.c.wAttribute == HPI_MULTIPLEXER_SOURCE) {
 			pC->u.x.wSourceNodeType = (u16)phm->u.c.dwParam1;
 			pC->u.x.wSourceNodeIndex = (u16)phm->u.c.dwParam2;
@@ -547,6 +552,8 @@ void HpiSyncControlCache(
 		break;
 	case HPI_CONTROL_CHANNEL_MODE:
 		/* mode does not return its setting on Set command. */
+		if (phr->wError)
+			return;
 		if (phm->u.c.wAttribute == HPI_CHANNEL_MODE_MODE)
 			pC->u.m.wMode = (u16)phm->u.c.dwParam1;
 		break;
@@ -557,14 +564,20 @@ void HpiSyncControlCache(
 		}
 		break;
 	case HPI_CONTROL_AESEBU_TRANSMITTER:
+		if (phr->wError)
+			return;
 		if (phm->u.c.wAttribute == HPI_AESEBUTX_FORMAT)
 			pC->u.aes3tx.dwFormat = phm->u.c.dwParam1;
 		break;
 	case HPI_CONTROL_AESEBU_RECEIVER:
+		if (phr->wError)
+			return;
 		if (phm->u.c.wAttribute == HPI_AESEBURX_FORMAT)
 			pC->u.aes3rx.dwSource = phm->u.c.dwParam1;
 		break;
 	case HPI_CONTROL_SAMPLECLOCK:
+		if (phr->wError)
+			return;
 		if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SOURCE)
 			pC->u.clk.wSource = (u16)phm->u.c.dwParam1;
 		else if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SOURCE_INDEX) {
-- 
1.5.4.3
