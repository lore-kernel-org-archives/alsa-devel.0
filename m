From: linux@audioscience.com
Subject: [PATCH 2/5] Add hd radio blend functions. HPI version
	inc to 4.03.25
Date: Thu, 27 May 2010 17:53:52 +1200
Message-ID: <1274939635-1370-2-git-send-email-linux@audioscience.com>
References: <1274939635-1370-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1274939635-1370-1-git-send-email-linux@audioscience.com>
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
 sound/pci/asihpi/hpi.h          |    8 +++++++-
 sound/pci/asihpi/hpi_internal.h |    5 +++++
 sound/pci/asihpi/hpifunc.c      |   17 +++++++++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 99400de..0173bbe 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -50,7 +50,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 18)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 25)
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
@@ -1632,6 +1632,12 @@ u16 hpi_tuner_get_hd_radio_sdk_version(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_tuner_get_hd_radio_signal_quality(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *pquality);
 
+u16 hpi_tuner_get_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 *pblend);
+
+u16 hpi_tuner_set_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, const u32 blend);
+
 /****************************/
 /* PADs control             */
 /****************************/
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index f1cd6f1..fdd0ce0 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -232,6 +232,8 @@ enum HPI_BUSES {
 #define HPI_TUNER_HDRADIO_SDK_VERSION   HPI_CTL_ATTR(TUNER, 13)
 /** HD Radio DSP firmware version. */
 #define HPI_TUNER_HDRADIO_DSP_VERSION   HPI_CTL_ATTR(TUNER, 14)
+/** HD Radio signal blend (force analog, or automatic). */
+#define HPI_TUNER_HDRADIO_BLEND         HPI_CTL_ATTR(TUNER, 15)
 
 /** \} */
 
@@ -478,8 +480,10 @@ Threshold is a -ve number in units of dB/100,
 
 /** First 2 hex digits define the adapter family */
 #define HPI_ADAPTER_FAMILY_MASK         0xff00
+#define HPI_MODULE_FAMILY_MASK          0xfff0
 
 #define HPI_ADAPTER_FAMILY_ASI(f)   (f & HPI_ADAPTER_FAMILY_MASK)
+#define HPI_MODULE_FAMILY_ASI(f)   (f & HPI_MODULE_FAMILY_MASK)
 #define HPI_ADAPTER_ASI(f)   (f)
 
 /******************************************* message types */
@@ -970,6 +974,7 @@ struct hpi_control_union_msg {
 				u32 mode;
 				u32 value;
 			} mode;
+			u32 blend;
 		} tuner;
 	} u;
 };
diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index eda26b3..298eef3 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -2946,6 +2946,20 @@ u16 hpi_tuner_get_hd_radio_signal_quality(const struct hpi_hsubsys *ph_subsys,
 		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, 0, 0, pquality, NULL);
 }
 
+u16 hpi_tuner_get_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 *pblend)
+{
+	return hpi_control_param_get(ph_subsys, h_control,
+		HPI_TUNER_HDRADIO_BLEND, 0, 0, pblend, NULL);
+}
+
+u16 hpi_tuner_set_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, const u32 blend)
+{
+	return hpi_control_param_set(ph_subsys, h_control,
+		HPI_TUNER_HDRADIO_BLEND, blend, 0);
+}
+
 u16 hpi_tuner_getRDS(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	char *p_data)
 {
@@ -3266,8 +3280,7 @@ u16 hpi_entity_find_next(struct hpi_entity *container_entity,
 
 void hpi_entity_free(struct hpi_entity *entity)
 {
-	if (entity != NULL)
-		kfree(entity);
+	kfree(entity);
 }
 
 static u16 hpi_entity_alloc_and_copy(struct hpi_entity *src,
-- 
1.7.0.4
