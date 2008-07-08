From: linux@audioscience.com
Subject: [PATCH - asihpi 4/4] HPI v3.10.03. Formatting tweaks.
Date: Wed, 09 Jul 2008 11:10:41 +1200
Message-ID: <1215558641-19514-4-git-send-email-linux@audioscience.com>
References: <1215558641-19514-1-git-send-email-linux@audioscience.com>
	<1215558641-19514-2-git-send-email-linux@audioscience.com>
	<1215558641-19514-3-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1215558641-19514-3-git-send-email-linux@audioscience.com>
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

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 06953bc..4f52d09 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -46,7 +46,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 10, 1)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 10, 3)
 
 #ifdef _DOX_ONLY_
 /*****************************************************************************/
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index af83a2e..4594a26 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -283,8 +283,8 @@ short HpiCheckBufferMapping(
 }
 
 /** CheckControlCache checks the cache and fills the struct hpi_response
-* accordingly. It returns one if a cache hit occurred, zero otherwise.
-*/
+ * accordingly. It returns one if a cache hit occurred, zero otherwise.
+ */
 short HpiCheckControlCache(
 	struct hpi_control_cache *pCache,
 	struct hpi_message *phm,
@@ -304,8 +304,8 @@ short HpiCheckControlCache(
 		sizeof(struct hpi_control_res);
 	phr->wError = 0;
 
-	/* pC is the default cached control strucure. May be cast to
-	   something else in the following switch statement.
+	/* pC is the default cached control strucure.
+	   May be cast to something else in the following switch statement.
 	 */
 	pC = (struct hpi_control_cache_single *)pI;
 
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 6c33a80..89e8143 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -1696,7 +1696,6 @@ u16 HPI_ControlParamGet(
 		HPI_ControlExParamGet(s, h, a, 0, 0, p1, NULL)
 #define HPI_ControlExParam2Get(s, h, a, p1, p2) \
 		HPI_ControlExParamGet(s, h, a, 0, 0, p1, p2)
-
 u16 HPI_ControlQuery(
 	const struct hpi_hsubsys *phSubSys,
 	const u32 hControl,
@@ -3180,18 +3179,6 @@ u16 HPI_Tuner_GetRDS(
 	return (hr.wError);
 }
 
-#ifdef _DOX_ONLY_
-u16 HPI_Tuner_GetHdRadioSignalQuality(
-	struct hpi_hsubsys *phSubSys,
-	u32 hControl,
-	u32 *pdwSignalQuality
-)
-{
-	return HPI_ControlParamGet(phSubSys, hControl,
-		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, 0, 0, pdwSignalQuality, 0);
-}
-#endif
-
 u16 HPI_PAD_GetChannelName(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
-- 
1.5.4.3
