From: linux@audioscience.com
Subject: [PATCH - asihpi 1/4] V3.10.1. Add hpi_RDS enum.
Date: Wed, 09 Jul 2008 11:10:38 +1200
Message-ID: <1215558641-19514-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
index a58bf71..06953bc 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -41,12 +41,12 @@ i.e 3.05.02 is a development version
 #define HPI_VERSION_CONSTRUCTOR(maj, min, rel) \
 	((maj << 16) + (min << 8) + rel)
 
-#define HPI_VER_MAJOR(v) (int)(v >> 16)
-#define HPI_VER_MINOR(v) (int)((v >> 8) & 0xFF)
-#define HPI_VER_RELEASE(v) (int)(v & 0xFF)
+#define HPI_VER_MAJOR(v) ((int)(v >> 16))
+#define HPI_VER_MINOR(v) ((int)((v >> 8) & 0xFF))
+#define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 10, 0)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 10, 1)
 
 #ifdef _DOX_ONLY_
 /*****************************************************************************/
@@ -1052,6 +1052,13 @@ Contains either 1 or 0. */
 Contains either 1 or 0. */
 #define HPI_PAD_TA_ACTIVE               HPI_CTL_ATTR(PAD, 8)
 
+/** Data types for PTY string translation.
+  */
+enum eHPI_RDS_type {
+	HPI_RDS_DATATYPE_RDS = 0,	/**< RDS bitstream. */
+	HPI_RDS_DATATYPE_RDBS = 1,	/**< RDBS bitstream. */
+	HPI_RDS_DATATYPE_FUTURE = 2	/**< Future bitstream. */
+};
 /** \} */
 
 /** \defgroup tuner_bands Tuner bands
-- 
1.5.4.3
