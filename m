From: linux@audioscience.com
Subject: [PATCH 18/28] Add volume mute control.
Date: Thu, 10 Feb 2011 17:26:11 +1300
Message-ID: <1297311981-30448-19-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi.h          |    9 +++++++++
 pci/asihpi/hpi_internal.h |   17 ++++++++++++++++-
 pci/asihpi/hpicmn.c       |   20 +++++++++++++++++++-
 pci/asihpi/hpifunc.c      |   10 ++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index bef90d4..5ac978d 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -645,6 +645,11 @@ enum HPI_SWITCH_STATES {
 */
 #define HPI_GAIN_OFF                    (-100 * HPI_UNITS_PER_dB)
 
+/** channel mask specifying all channels
+\ingroup volume
+*/
+#define HPI_BITMASK_ALL_CHANNELS        (0xFFFFFFFF)
+
 /** value returned for no signal
 \ingroup meter
 */
@@ -1312,6 +1317,10 @@ u16 hpi_volume_get_gain(u32 h_control,
 	short an_gain0_01dB_out[HPI_MAX_CHANNELS]
 	);
 
+u16 hpi_volume_set_mute(u32 h_control, u32 mute);
+
+u16 hpi_volume_get_mute(u32 h_control, u32 *mute);
+
 #define hpi_volume_get_range hpi_volume_query_range
 u16 hpi_volume_query_range(u32 h_control, short *min_gain_01dB,
 	short *max_gain_01dB, short *step_gain_01dB);
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 10de7e0..9908160 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -114,6 +114,18 @@ enum HPI_SUBSYS_OPTIONS {
 	HPI_SUBSYS_OPT_NET_ADAPTER_ADDRESS_ADD = 262
 };
 
+/** Volume flags
+*/
+enum HPI_VOLUME_FLAGS {
+	/** Set if the volume control is muted */
+	HPI_VOLUME_FLAG_MUTED = (1 << 0),
+	/** Set if the volume control has a mute function */
+	HPI_VOLUME_FLAG_HAS_MUTE = (1 << 1),
+	/** Set if volume control can do autofading */
+	HPI_VOLUME_FLAG_HAS_AUTOFADE = (1 << 2)
+		/* Note Flags >= (1<<8) are for DSP internal use only */
+};
+
 /******************************************* CONTROL ATTRIBUTES ****/
 /* (in order of control type ID */
 
@@ -139,6 +151,8 @@ enum HPI_CONTROL_ATTRIBUTES {
 
 	HPI_VOLUME_GAIN = HPI_CTL_ATTR(VOLUME, 1),
 	HPI_VOLUME_AUTOFADE = HPI_CTL_ATTR(VOLUME, 2),
+	HPI_VOLUME_MUTE = HPI_CTL_ATTR(VOLUME, 3),
+	HPI_VOLUME_GAIN_AND_FLAGS = HPI_CTL_ATTR(VOLUME, 4),
 	HPI_VOLUME_NUM_CHANNELS = HPI_CTL_ATTR(VOLUME, 6),
 	HPI_VOLUME_RANGE = HPI_CTL_ATTR(VOLUME, 10),
 
@@ -1389,7 +1403,8 @@ struct hpi_control_cache_info {
 struct hpi_control_cache_vol {
 	struct hpi_control_cache_info i;
 	short an_log[2];
-	char temp_padding[4];
+	unsigned short flags;
+	char padding[2];
 };
 
 struct hpi_control_cache_meter {
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index e0a08f6..4b3f476 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -347,8 +347,21 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 		if (phm->u.c.attribute == HPI_VOLUME_GAIN) {
 			phr->u.c.an_log_value[0] = pC->u.vol.an_log[0];
 			phr->u.c.an_log_value[1] = pC->u.vol.an_log[1];
-		} else
+		} else if (phm->u.c.attribute == HPI_VOLUME_MUTE) {
+			if (pC->u.vol.flags & HPI_VOLUME_FLAG_HAS_MUTE) {
+				if (pC->u.vol.flags & HPI_VOLUME_FLAG_MUTED)
+					phr->u.c.param1 =
+						HPI_BITMASK_ALL_CHANNELS;
+				else
+					phr->u.c.param1 = 0;
+			} else {
+				phr->error =
+					HPI_ERROR_INVALID_CONTROL_ATTRIBUTE;
+				phr->u.c.param1 = 0;
+			}
+		} else {
 			found = 0;
+		}
 		break;
 	case HPI_CONTROL_MULTIPLEXER:
 		if (phm->u.c.attribute == HPI_MULTIPLEXER_SOURCE) {
@@ -544,6 +557,11 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
 		if (phm->u.c.attribute == HPI_VOLUME_GAIN) {
 			pC->u.vol.an_log[0] = phr->u.c.an_log_value[0];
 			pC->u.vol.an_log[1] = phr->u.c.an_log_value[1];
+		} else if (phm->u.c.attribute == HPI_VOLUME_MUTE) {
+			if (phm->u.c.param1)
+				pC->u.vol.flags |= HPI_VOLUME_FLAG_MUTED;
+			else
+				pC->u.vol.flags &= ~HPI_VOLUME_FLAG_MUTED;
 		}
 		break;
 	case HPI_CONTROL_MULTIPLEXER:
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 53924e4..b79eba1 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -2888,6 +2888,16 @@ u16 hpi_volume_get_gain(u32 h_control, short an_log_gain[HPI_MAX_CHANNELS]
 		&an_log_gain[0], &an_log_gain[1]);
 }
 
+u16 hpi_volume_set_mute(u32 h_control, u32 mute)
+{
+	return hpi_control_param_set(h_control, HPI_VOLUME_MUTE, mute, 0);
+}
+
+u16 hpi_volume_get_mute(u32 h_control, u32 *mute)
+{
+	return hpi_control_param1_get(h_control, HPI_VOLUME_MUTE, mute);
+}
+
 u16 hpi_volume_query_range(u32 h_control, short *min_gain_01dB,
 	short *max_gain_01dB, short *step_gain_01dB)
 {
-- 
1.7.0.4
