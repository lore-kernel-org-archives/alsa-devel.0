From: linux@audioscience.com
Subject: [PATCH 3/7] Reinit response size for every
 msg/response transaction. Minor fix const ptr
Date: Tue, 23 Mar 2010 21:14:23 +1300
Message-ID: <1269332067-25959-4-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpimsgx.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/pci/asihpi/hpimsgx.c b/pci/asihpi/hpimsgx.c
index 231ae6c..c7ddbcf 100644
--- a/pci/asihpi/hpimsgx.c
+++ b/pci/asihpi/hpimsgx.c
@@ -35,7 +35,7 @@ static struct hpios_spinlock msgxLock;
 static HPI_HandlerFunc *hpi_entry_points[HPI_MAX_ADAPTERS];
 
 static HPI_HandlerFunc *HPI_LookupEntryPointFunction(
-	struct hpi_pci *PciInfo
+	const struct hpi_pci *PciInfo
 )
 {
 
@@ -555,8 +555,10 @@ static void InStreamOpen(
 		HpiOs_Msgxlock_UnLock(&msgxLock);
 
 		/* issue a reset */
-		memcpy(&hm, phm, sizeof(hm));
-		hm.wFunction = HPI_ISTREAM_RESET;
+		HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_ISTREAM,
+			HPI_ISTREAM_RESET);
+		hm.wAdapterIndex = phm->wAdapterIndex;
+		hm.wObjIndex = phm->wObjIndex;
 		HW_EntryPoint(&hm, &hr);
 
 		HpiOs_Msgxlock_Lock(&msgxLock);
@@ -600,8 +602,10 @@ static void InStreamClose(
 			NULL;
 		HpiOs_Msgxlock_UnLock(&msgxLock);
 		/* issue a reset */
-		memcpy(&hm, phm, sizeof(hm));
-		hm.wFunction = HPI_ISTREAM_RESET;
+		HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_ISTREAM,
+			HPI_ISTREAM_RESET);
+		hm.wAdapterIndex = phm->wAdapterIndex;
+		hm.wObjIndex = phm->wObjIndex;
 		HW_EntryPoint(&hm, &hr);
 		HpiOs_Msgxlock_Lock(&msgxLock);
 		if (hr.wError) {
@@ -654,8 +658,10 @@ static void OutStreamOpen(
 		HpiOs_Msgxlock_UnLock(&msgxLock);
 
 		/* issue a reset */
-		memcpy(&hm, phm, sizeof(hm));
-		hm.wFunction = HPI_OSTREAM_RESET;
+		HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM,
+			HPI_OSTREAM_RESET);
+		hm.wAdapterIndex = phm->wAdapterIndex;
+		hm.wObjIndex = phm->wObjIndex;
 		HW_EntryPoint(&hm, &hr);
 
 		HpiOs_Msgxlock_Lock(&msgxLock);
@@ -700,8 +706,10 @@ static void OutStreamClose(
 			NULL;
 		HpiOs_Msgxlock_UnLock(&msgxLock);
 		/* issue a reset */
-		memcpy(&hm, phm, sizeof(hm));
-		hm.wFunction = HPI_OSTREAM_RESET;
+		HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM,
+			HPI_OSTREAM_RESET);
+		hm.wAdapterIndex = phm->wAdapterIndex;
+		hm.wObjIndex = phm->wObjIndex;
 		HW_EntryPoint(&hm, &hr);
 		HpiOs_Msgxlock_Lock(&msgxLock);
 		if (hr.wError) {
-- 
1.7.0.rc0.8.ge3f67d
