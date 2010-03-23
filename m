From: linux@audioscience.com
Subject: [PATCH 7/7] Support mic control caching. Move an enum
 out of public api.
Date: Tue, 23 Mar 2010 21:14:27 +1300
Message-ID: <1269332067-25959-8-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi.h          |    8 +-------
 pci/asihpi/hpi_internal.h |   11 +++++++++++
 pci/asihpi/hpicmn.c       |   10 ++++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 71ddd61..b89a557 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -49,7 +49,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 10)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 13)
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
@@ -178,12 +178,6 @@ The range is +1.0 to -1.0, which corresponds to digital fullscale.
 	HPI_FORMAT_UNDEFINED = 0xffff
 };
 
-/******************************************* bus types */
-enum HPI_BUSES {
-	HPI_BUS_ISAPNP = 1,
-	HPI_BUS_PCI = 2,
-	HPI_BUS_USB = 3
-};
 /******************************************* in/out Stream states */
 /*******************************************/
 /** Stream States
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 77b85e4..6ea091f 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -174,6 +174,14 @@ struct hpi_entity {
 #pragma warning(pop)
 #endif
 
+/******************************************* bus types */
+enum HPI_BUSES {
+	HPI_BUS_ISAPNP = 1,
+	HPI_BUS_PCI = 2,
+	HPI_BUS_USB = 3,
+	HPI_BUS_NET = 4
+};
+
 /******************************************* CONTROL ATTRIBUTES ****/
 /* (in order of control type ID */
 
@@ -1583,6 +1591,9 @@ struct hpi_control_cache_single {
 			u16 wSourceIndex;
 			u32 dwSampleRate;
 		} clk;
+		struct {	/* microphone control */
+			u16 wState;
+		} phantom_power;
 		struct {	/* generic control */
 			u32 dw1;
 			u32 dw2;
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 4d4a796..012fd0f 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -414,6 +414,12 @@ short HpiCheckControlCache(
 		} else
 			found = 0;
 		break;
+	case HPI_CONTROL_MICROPHONE:
+		if (phm->u.c.wAttribute == HPI_MICROPHONE_PHANTOM_POWER) {
+			phr->u.c.dwParam1 = pC->u.phantom_power.wState;
+		} else
+			found = 0;
+		break;
 	case HPI_CONTROL_SAMPLECLOCK:
 		if (phm->u.c.wAttribute == HPI_SAMPLECLOCK_SOURCE)
 			phr->u.c.dwParam1 = pC->u.clk.wSource;
@@ -562,6 +568,10 @@ void HpiSyncControlCache(
 			pC->u.v.anLog[1] = phr->u.c.anLogValue[1];
 		}
 		break;
+	case HPI_CONTROL_MICROPHONE:
+		if (phm->u.c.wAttribute == HPI_MICROPHONE_PHANTOM_POWER)
+			pC->u.phantom_power.wState = (u16)phm->u.c.dwParam1;
+		break;
 	case HPI_CONTROL_AESEBU_TRANSMITTER:
 		if (phr->wError)
 			return;
-- 
1.7.0.rc0.8.ge3f67d
