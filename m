From: linux@audioscience.com
Subject: [PATCH 6/7] Keep HPI buffer pointers in sync with ALSA
	after prewrite.
Date: Tue, 23 Mar 2010 21:14:26 +1300
Message-ID: <1269332067-25959-7-git-send-email-linux@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1269332067-25959-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi6205.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index a8a84b3..6db1c58 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -1051,26 +1051,18 @@ static void OutStreamWrite(
 	struct bus_master_interface *interface = phw->pInterfaceBuffer;
 	struct hpi_hostbuffer_status *status;
 	long dwSpaceAvailable;
+
 	if (!phw->OutStreamHostBufferSize[phm->wObjIndex]) {
-		/* there  is no BBM buffer */
+		/* there  is no BBM buffer, write via message */
 		HW_Message(pao, phm, phr);
 		return;
 	}
-	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
 
+	HPI_InitResponse(phr, phm->wObject, phm->wFunction, 0);
 	status = &interface->aOutStreamHostBufferStatus[phm->wObjIndex];
 
-/* Set this to 1 to force this OutStremWrite() call to write data to the */
-/* adapter's buffers for the first write following stream reset. */
-#define OLD_STYLE_PREWRITE (1)
-
-	/* check whether we need to send the format to the DSP */
 	if (phw->flagOStreamJustReset[phm->wObjIndex]) {
-#if OLD_STYLE_PREWRITE
-		int nPartialWrite = 0;
-		unsigned int nOriginalSize = 0;
-#endif
-
+		/* Format can only change after reset. Must tell DSP. */
 		u16 wFunction = phm->wFunction;
 		phw->flagOStreamJustReset[phm->wObjIndex] = 0;
 		phm->wFunction = HPI_OSTREAM_SET_FORMAT;
@@ -1078,11 +1070,18 @@ static void OutStreamWrite(
 		phm->wFunction = wFunction;
 		if (phr->wError)
 			return;
+	}
+#if 1
+	if (phw->flagOStreamJustReset[phm->wObjIndex]) {
+		/* First OutStremWrite() call following reset will write data to the
+		   adapter's buffers, reducing delay before stream can start
+		 */
+		int nPartialWrite = 0;
+		unsigned int nOriginalSize = 0;
 
-#if OLD_STYLE_PREWRITE
 		/* Send the first buffer to the DSP the old way. */
 		/* Limit size of first transfer - */
-		/* hopefully this will not not be triggered. */
+		/* expect that this will not usually be triggered. */
 		if (phm->u.d.u.Data.dwDataSize > HPI6205_SIZEOF_DATA) {
 			nPartialWrite = 1;
 			nOriginalSize = phm->u.d.u.Data.dwDataSize;
@@ -1096,6 +1095,8 @@ static void OutStreamWrite(
 		 * buffer update task reads data from the host BBM buffer)
 		 */
 		status->dwAuxiliaryDataAvailable = phm->u.d.u.Data.dwDataSize;
+		status->dwHostIndex += phm->u.d.u.Data.dwDataSize;
+		status->dwDSPIndex += phm->u.d.u.Data.dwDataSize;
 
 		/* if we did a full write, we can return from here. */
 		if (!nPartialWrite)
@@ -1106,8 +1107,8 @@ static void OutStreamWrite(
 		phm->u.d.u.Data.dwDataSize =
 			nOriginalSize - HPI6205_SIZEOF_DATA;
 		phm->u.d.u.Data.pbData += HPI6205_SIZEOF_DATA;
-#endif
 	}
+#endif
 
 	dwSpaceAvailable = OutStreamGetSpaceAvailable(status);
 	if (dwSpaceAvailable < (long)phm->u.d.u.Data.dwDataSize) {
-- 
1.7.0.rc0.8.ge3f67d
