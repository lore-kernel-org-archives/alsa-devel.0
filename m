From: linux@audioscience.com
Subject: [PATCH 4/6] Add compander. Factor out some common code
 for stereo log value reading. Make some more entity functions static.
Date: Fri, 02 Jul 2010 11:23:33 +1200
Message-ID: <1278026615-16153-5-git-send-email-linux@audioscience.com>
References: <1278026615-16153-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1278026615-16153-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi_internal.h |   30 +++--
 pci/asihpi/hpifunc.c      |  324 +++++++++++++++++++++++++++------------------
 2 files changed, 211 insertions(+), 143 deletions(-)

diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index fdd0ce0..7ae7a1d 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -142,12 +142,15 @@ enum HPI_BUSES {
 /******************************************* CONTROL ATTRIBUTES ****/
 /* (in order of control type ID */
 
-	/* This allows for 255 control types, 256 unique attributes each */
+/* This allows for 255 control types, 256 unique attributes each */
 #define HPI_CTL_ATTR(ctl, ai) (HPI_CONTROL_##ctl * 0x100 + ai)
 
 /* Get the sub-index of the attribute for a control type */
 #define HPI_CTL_ATTR_INDEX(i) (i&0xff)
 
+/* Extract the control from the control attribute */
+#define HPI_CTL_ATTR_CONTROL(i) (i>>8)
+
 /* Generic control attributes.  */
 
 /** Enable a control.
@@ -311,8 +314,7 @@ Used for HPI_ChannelModeSet/Get()
 /* Microphone control attributes */
 #define HPI_MICROPHONE_PHANTOM_POWER HPI_CTL_ATTR(MICROPHONE, 1)
 
-/** Equalizer control attributes
-*/
+/** Equalizer control attributes */
 /** Used to get number of filters in an EQ. (Can't set) */
 #define HPI_EQUALIZER_NUM_FILTERS HPI_CTL_ATTR(EQUALIZER, 1)
 /** Set/get the filter by type, freq, Q, gain */
@@ -320,13 +322,15 @@ Used for HPI_ChannelModeSet/Get()
 /** Get the biquad coefficients */
 #define HPI_EQUALIZER_COEFFICIENTS HPI_CTL_ATTR(EQUALIZER, 3)
 
-#define HPI_COMPANDER_PARAMS HPI_CTL_ATTR(COMPANDER, 1)
+/* Note compander also uses HPI_GENERIC_ENABLE */
+#define HPI_COMPANDER_PARAMS     HPI_CTL_ATTR(COMPANDER, 1)
+#define HPI_COMPANDER_MAKEUPGAIN HPI_CTL_ATTR(COMPANDER, 2)
+#define HPI_COMPANDER_THRESHOLD  HPI_CTL_ATTR(COMPANDER, 3)
+#define HPI_COMPANDER_RATIO      HPI_CTL_ATTR(COMPANDER, 4)
+#define HPI_COMPANDER_ATTACK     HPI_CTL_ATTR(COMPANDER, 5)
+#define HPI_COMPANDER_DECAY      HPI_CTL_ATTR(COMPANDER, 6)
 
-/* Cobranet control attributes.
-   MUST be distinct from all other control attributes.
-   This is so that host side processing can easily identify a Cobranet control
-   and apply additional host side operations (like copying data) as required.
-*/
+/* Cobranet control attributes. */
 #define HPI_COBRANET_SET         HPI_CTL_ATTR(COBRANET, 1)
 #define HPI_COBRANET_GET         HPI_CTL_ATTR(COBRANET, 2)
 #define HPI_COBRANET_SET_DATA    HPI_CTL_ATTR(COBRANET, 3)
@@ -1512,11 +1516,11 @@ struct hpi_control_cache_single {
 	struct hpi_control_cache_info i;
 	union {
 		struct {	/* volume */
-			u16 an_log[2];
+			short an_log[2];
 		} v;
 		struct {	/* peak meter */
-			u16 an_log_peak[2];
-			u16 an_logRMS[2];
+			short an_log_peak[2];
+			short an_logRMS[2];
 		} p;
 		struct {	/* channel mode */
 			u16 mode;
@@ -1526,7 +1530,7 @@ struct hpi_control_cache_single {
 			u16 source_node_index;
 		} x;
 		struct {	/* level/trim */
-			u16 an_log[2];
+			short an_log[2];
 		} l;
 		struct {	/* tuner - partial caching.
 				   some attributes go to the DSP. */
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 298eef3..9c6958a 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -96,8 +96,7 @@ void hpi_stream_response_to_legacy(struct hpi_stream_res *pSR)
 
 static struct hpi_hsubsys gh_subsys;
 
-struct hpi_hsubsys *hpi_subsys_create(void
-	)
+struct hpi_hsubsys *hpi_subsys_create(void)
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
@@ -302,6 +301,7 @@ u16 hpi_adapter_set_mode_ex(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
 		HPI_ADAPTER_SET_MODE);
 	hm.adapter_index = adapter_index;
@@ -510,7 +510,7 @@ u16 hpi_adapter_debug_read(const struct hpi_hsubsys *ph_subsys,
 	hm.adapter_index = adapter_index;
 	hm.u.ax.debug_read.dsp_address = dsp_address;
 
-	if (*count_bytes > sizeof(hr.u.bytes))
+	if (*count_bytes > (int)sizeof(hr.u.bytes))
 		*count_bytes = sizeof(hr.u.bytes);
 
 	hm.u.ax.debug_read.count_bytes = *count_bytes;
@@ -976,6 +976,7 @@ u16 hpi_outstream_ancillary_read(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_OSTREAM,
 		HPI_OSTREAM_ANC_READ);
 	u32TOINDEXES(h_outstream, &hm.adapter_index, &hm.obj_index);
@@ -1581,6 +1582,7 @@ u16 hpi_control_param_set(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -1591,6 +1593,22 @@ u16 hpi_control_param_set(const struct hpi_hsubsys *ph_subsys,
 	return hr.error;
 }
 
+static u16 hpi_control_log_set2(u32 h_control, u16 attrib, short sv0,
+	short sv1)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
+		HPI_CONTROL_SET_STATE);
+	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
+	hm.u.c.attribute = attrib;
+	hm.u.c.an_log_value[0] = sv0;
+	hm.u.c.an_log_value[1] = sv1;
+	hpi_send_recv(&hm, &hr);
+	return hr.error;
+}
+
 static
 u16 hpi_control_param_get(const struct hpi_hsubsys *ph_subsys,
 	const u32 h_control, const u16 attrib, u32 param1, u32 param2,
@@ -1598,6 +1616,7 @@ u16 hpi_control_param_get(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -1605,8 +1624,8 @@ u16 hpi_control_param_get(const struct hpi_hsubsys *ph_subsys,
 	hm.u.c.param1 = param1;
 	hm.u.c.param2 = param2;
 	hpi_send_recv(&hm, &hr);
-	if (pparam1)
-		*pparam1 = hr.u.c.param1;
+
+	*pparam1 = hr.u.c.param1;
 	if (pparam2)
 		*pparam2 = hr.u.c.param2;
 
@@ -1617,10 +1636,23 @@ u16 hpi_control_param_get(const struct hpi_hsubsys *ph_subsys,
 		hpi_control_param_get(s, h, a, 0, 0, p1, NULL)
 #define hpi_control_param2_get(s, h, a, p1, p2) \
 		hpi_control_param_get(s, h, a, 0, 0, p1, p2)
-#define hpi_control_ex_param1_get(s, h, a, p1) \
-		hpi_control_ex_param_get(s, h, a, 0, 0, p1, NULL)
-#define hpi_control_ex_param2_get(s, h, a, p1, p2) \
-		hpi_control_ex_param_get(s, h, a, 0, 0, p1, p2)
+
+static u16 hpi_control_log_get2(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u16 attrib, short *sv0, short *sv1)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
+		HPI_CONTROL_GET_STATE);
+	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
+	hm.u.c.attribute = attrib;
+
+	hpi_send_recv(&hm, &hr);
+	*sv0 = hr.u.c.an_log_value[0];
+	if (sv1)
+		*sv1 = hr.u.c.an_log_value[1];
+	return hr.error;
+}
 
 static
 u16 hpi_control_query(const struct hpi_hsubsys *ph_subsys,
@@ -1629,6 +1661,7 @@ u16 hpi_control_query(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_INFO);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -1643,9 +1676,8 @@ u16 hpi_control_query(const struct hpi_hsubsys *ph_subsys,
 	return hr.error;
 }
 
-static u16 hpi_control_get_string(const struct hpi_hsubsys *ph_subsys,
-	const u32 h_control, const u16 attribute, char *psz_string,
-	const u32 string_length)
+static u16 hpi_control_get_string(const u32 h_control, const u16 attribute,
+	char *psz_string, const u32 string_length)
 {
 	unsigned int sub_string_index = 0, j = 0;
 	char c = 0;
@@ -1916,6 +1948,7 @@ u16 hpi_cobranet_hmi_write(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROLEX,
 		HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -1941,6 +1974,7 @@ u16 hpi_cobranet_hmi_read(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROLEX,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -1980,6 +2014,7 @@ u16 hpi_cobranet_hmi_get_status(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROLEX,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2006,6 +2041,7 @@ u16 hpi_cobranet_getI_paddress(const struct hpi_hsubsys *ph_subsys,
 	u32 byte_count;
 	u32 iP;
 	u16 error;
+
 	error = hpi_cobranet_hmi_read(ph_subsys, h_control,
 		HPI_COBRANET_HMI_cobra_ip_mon_currentIP, 4, &byte_count,
 		(u8 *)&iP);
@@ -2082,6 +2118,7 @@ u16 hpi_cobranet_getMA_caddress(const struct hpi_hsubsys *ph_subsys,
 	u32 byte_count;
 	u16 error;
 	u32 mAC;
+
 	error = hpi_cobranet_hmi_read(ph_subsys, h_control,
 		HPI_COBRANET_HMI_cobra_if_phy_address, 4, &byte_count,
 		(u8 *)&mAC);
@@ -2103,53 +2140,111 @@ u16 hpi_cobranet_getMA_caddress(const struct hpi_hsubsys *ph_subsys,
 	return error;
 }
 
-u16 hpi_compander_set(const struct hpi_hsubsys *ph_subsys, u32 h_control,
-	u16 attack, u16 decay, short ratio100, short threshold0_01dB,
-	short makeup_gain0_01dB)
+u16 hpi_compander_set_enable(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 enable)
+{
+	return hpi_control_param_set(ph_subsys, h_control, HPI_GENERIC_ENABLE,
+		enable, 0);
+}
+
+u16 hpi_compander_get_enable(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 *enable)
+{
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_GENERIC_ENABLE, enable);
+}
+
+u16 hpi_compander_set_makeup_gain(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, short makeup_gain0_01dB)
+{
+	return hpi_control_log_set2(h_control, HPI_COMPANDER_MAKEUPGAIN,
+		makeup_gain0_01dB, 0);
+}
+
+u16 hpi_compander_get_makeup_gain(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, short *makeup_gain0_01dB)
+{
+	return hpi_control_log_get2(ph_subsys, h_control,
+		HPI_COMPANDER_MAKEUPGAIN, makeup_gain0_01dB, NULL);
+}
+
+u16 hpi_compander_set_attack_time_constant(const struct hpi_hsubsys
+	*ph_subsys, u32 h_control, unsigned int index, u32 attack)
+{
+	return hpi_control_param_set(ph_subsys, h_control,
+		HPI_COMPANDER_ATTACK, attack, index);
+}
+
+u16 hpi_compander_get_attack_time_constant(const struct hpi_hsubsys
+	*ph_subsys, u32 h_control, unsigned int index, u32 *attack)
+{
+	return hpi_control_param_get(ph_subsys, h_control,
+		HPI_COMPANDER_ATTACK, 0, index, attack, &index);
+}
+
+u16 hpi_compander_set_decay_time_constant(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, unsigned int index, u32 decay)
+{
+	return hpi_control_param_set(ph_subsys, h_control,
+		HPI_COMPANDER_DECAY, decay, index);
+}
+
+u16 hpi_compander_get_decay_time_constant(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, unsigned int index, u32 *decay)
+{
+	return hpi_control_param_get(ph_subsys, h_control,
+		HPI_COMPANDER_DECAY, 0, index, decay, &index);
+
+}
+
+u16 hpi_compander_set_threshold(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, unsigned int index, short threshold0_01dB)
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-
-	hm.u.c.param1 = attack + ((u32)ratio100 << 16);
-	hm.u.c.param2 = (decay & 0xFFFFL);
+	hm.u.c.attribute = HPI_COMPANDER_THRESHOLD;
+	hm.u.c.param2 = index;
 	hm.u.c.an_log_value[0] = threshold0_01dB;
-	hm.u.c.an_log_value[1] = makeup_gain0_01dB;
-	hm.u.c.attribute = HPI_COMPANDER_PARAMS;
 
 	hpi_send_recv(&hm, &hr);
 
 	return hr.error;
 }
 
-u16 hpi_compander_get(const struct hpi_hsubsys *ph_subsys, u32 h_control,
-	u16 *pw_attack, u16 *pw_decay, short *pw_ratio100,
-	short *pn_threshold0_01dB, short *pn_makeup_gain0_01dB)
+u16 hpi_compander_get_threshold(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, unsigned int index, short *threshold0_01dB)
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-	hm.u.c.attribute = HPI_COMPANDER_PARAMS;
+	hm.u.c.attribute = HPI_COMPANDER_THRESHOLD;
+	hm.u.c.param2 = index;
 
 	hpi_send_recv(&hm, &hr);
+	*threshold0_01dB = hr.u.c.an_log_value[0];
 
-	if (pw_attack)
-		*pw_attack = (short)(hr.u.c.param1 & 0xFFFF);
-	if (pw_decay)
-		*pw_decay = (short)(hr.u.c.param2 & 0xFFFF);
-	if (pw_ratio100)
-		*pw_ratio100 = (short)(hr.u.c.param1 >> 16);
+	return hr.error;
+}
 
-	if (pn_threshold0_01dB)
-		*pn_threshold0_01dB = hr.u.c.an_log_value[0];
-	if (pn_makeup_gain0_01dB)
-		*pn_makeup_gain0_01dB = hr.u.c.an_log_value[1];
+u16 hpi_compander_set_ratio(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 index, u32 ratio100)
+{
+	return hpi_control_param_set(ph_subsys, h_control,
+		HPI_COMPANDER_RATIO, ratio100, index);
+}
 
-	return hr.error;
+u16 hpi_compander_get_ratio(const struct hpi_hsubsys *ph_subsys,
+	u32 h_control, u32 index, u32 *ratio100)
+{
+	return hpi_control_param_get(ph_subsys, h_control,
+		HPI_COMPANDER_RATIO, 0, index, ratio100, &index);
 }
 
 u16 hpi_level_query_range(const struct hpi_hsubsys *ph_subsys, u32 h_control,
@@ -2157,6 +2252,7 @@ u16 hpi_level_query_range(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2181,37 +2277,16 @@ u16 hpi_level_set_gain(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	short an_gain0_01dB[HPI_MAX_CHANNELS]
 	)
 {
-	struct hpi_message hm;
-	struct hpi_response hr;
-
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
-		HPI_CONTROL_SET_STATE);
-	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-	memcpy(hm.u.c.an_log_value, an_gain0_01dB,
-		sizeof(short) * HPI_MAX_CHANNELS);
-	hm.u.c.attribute = HPI_LEVEL_GAIN;
-
-	hpi_send_recv(&hm, &hr);
-
-	return hr.error;
+	return hpi_control_log_set2(h_control, HPI_LEVEL_GAIN,
+		an_gain0_01dB[0], an_gain0_01dB[1]);
 }
 
 u16 hpi_level_get_gain(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	short an_gain0_01dB[HPI_MAX_CHANNELS]
 	)
 {
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
-		HPI_CONTROL_GET_STATE);
-	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-	hm.u.c.attribute = HPI_LEVEL_GAIN;
-
-	hpi_send_recv(&hm, &hr);
-
-	memcpy(an_gain0_01dB, hr.u.c.an_log_value,
-		sizeof(short) * HPI_MAX_CHANNELS);
-	return hr.error;
+	return hpi_control_log_get2(ph_subsys, h_control, HPI_LEVEL_GAIN,
+		&an_gain0_01dB[0], &an_gain0_01dB[1]);
 }
 
 u16 hpi_meter_query_channels(const struct hpi_hsubsys *ph_subsys,
@@ -2413,6 +2488,7 @@ u16 hpi_parametricEQ__get_band(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2439,6 +2515,7 @@ u16 hpi_parametricEQ__set_band(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2460,6 +2537,7 @@ u16 hpi_parametricEQ__get_coeffs(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2623,8 +2701,8 @@ u16 hpi_tone_detector_get_frequency(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_tone_detector_get_state(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *state)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_TONEDETECTOR_STATE, 0, 0, (u32 *)state, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_TONEDETECTOR_STATE, state);
 }
 
 u16 hpi_tone_detector_set_enable(const struct hpi_hsubsys *ph_subsys,
@@ -2637,8 +2715,8 @@ u16 hpi_tone_detector_set_enable(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_tone_detector_get_enable(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *enable)
 {
-	return hpi_control_param_get(ph_subsys, h_control, HPI_GENERIC_ENABLE,
-		0, 0, (u32 *)enable, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_GENERIC_ENABLE, enable);
 }
 
 u16 hpi_tone_detector_set_event_enable(const struct hpi_hsubsys *ph_subsys,
@@ -2651,8 +2729,8 @@ u16 hpi_tone_detector_set_event_enable(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_tone_detector_get_event_enable(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *event_enable)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_GENERIC_EVENT_ENABLE, 0, 0, (u32 *)event_enable, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_GENERIC_EVENT_ENABLE, event_enable);
 }
 
 u16 hpi_tone_detector_set_threshold(const struct hpi_hsubsys *ph_subsys,
@@ -2665,15 +2743,15 @@ u16 hpi_tone_detector_set_threshold(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_tone_detector_get_threshold(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, int *threshold)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_TONEDETECTOR_THRESHOLD, 0, 0, (u32 *)threshold, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_TONEDETECTOR_THRESHOLD, (u32 *)threshold);
 }
 
 u16 hpi_silence_detector_get_state(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *state)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_SILENCEDETECTOR_STATE, 0, 0, (u32 *)state, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_SILENCEDETECTOR_STATE, state);
 }
 
 u16 hpi_silence_detector_set_enable(const struct hpi_hsubsys *ph_subsys,
@@ -2686,50 +2764,50 @@ u16 hpi_silence_detector_set_enable(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_silence_detector_get_enable(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *enable)
 {
-	return hpi_control_param_get(ph_subsys, h_control, HPI_GENERIC_ENABLE,
-		0, 0, (u32 *)enable, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_GENERIC_ENABLE, enable);
 }
 
 u16 hpi_silence_detector_set_event_enable(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 event_enable)
 {
 	return hpi_control_param_set(ph_subsys, h_control,
-		HPI_GENERIC_EVENT_ENABLE, (u32)event_enable, 0);
+		HPI_GENERIC_EVENT_ENABLE, event_enable, 0);
 }
 
 u16 hpi_silence_detector_get_event_enable(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *event_enable)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_GENERIC_EVENT_ENABLE, 0, 0, (u32 *)event_enable, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_GENERIC_EVENT_ENABLE, event_enable);
 }
 
 u16 hpi_silence_detector_set_delay(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 delay)
 {
 	return hpi_control_param_set(ph_subsys, h_control,
-		HPI_SILENCEDETECTOR_DELAY, (u32)delay, 0);
+		HPI_SILENCEDETECTOR_DELAY, delay, 0);
 }
 
 u16 hpi_silence_detector_get_delay(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *delay)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_SILENCEDETECTOR_DELAY, 0, 0, (u32 *)delay, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_SILENCEDETECTOR_DELAY, delay);
 }
 
 u16 hpi_silence_detector_set_threshold(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, int threshold)
 {
 	return hpi_control_param_set(ph_subsys, h_control,
-		HPI_SILENCEDETECTOR_THRESHOLD, (u32)threshold, 0);
+		HPI_SILENCEDETECTOR_THRESHOLD, threshold, 0);
 }
 
 u16 hpi_silence_detector_get_threshold(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, int *threshold)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_SILENCEDETECTOR_THRESHOLD, 0, 0, (u32 *)threshold, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_SILENCEDETECTOR_THRESHOLD, (u32 *)threshold);
 }
 
 u16 hpi_tuner_query_band(const struct hpi_hsubsys *ph_subsys,
@@ -2822,6 +2900,7 @@ u16 hpi_tuner_getRF_level(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2838,6 +2917,7 @@ u16 hpi_tuner_get_rawRF_level(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2894,14 +2974,14 @@ u16 hpi_tuner_get_program(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 u16 hpi_tuner_get_hd_radio_dsp_version(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, char *psz_dsp_version, const u32 string_size)
 {
-	return hpi_control_get_string(ph_subsys, h_control,
+	return hpi_control_get_string(h_control,
 		HPI_TUNER_HDRADIO_DSP_VERSION, psz_dsp_version, string_size);
 }
 
 u16 hpi_tuner_get_hd_radio_sdk_version(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, char *psz_sdk_version, const u32 string_size)
 {
-	return hpi_control_get_string(ph_subsys, h_control,
+	return hpi_control_get_string(h_control,
 		HPI_TUNER_HDRADIO_SDK_VERSION, psz_sdk_version, string_size);
 }
 
@@ -2942,15 +3022,15 @@ u16 hpi_tuner_get_mode(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 u16 hpi_tuner_get_hd_radio_signal_quality(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *pquality)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, 0, 0, pquality, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, pquality);
 }
 
 u16 hpi_tuner_get_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *pblend)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_TUNER_HDRADIO_BLEND, 0, 0, pblend, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_TUNER_HDRADIO_BLEND, pblend);
 }
 
 u16 hpi_tuner_set_hd_radio_signal_blend(const struct hpi_hsubsys *ph_subsys,
@@ -2965,6 +3045,7 @@ u16 hpi_tuner_getRDS(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -2981,43 +3062,43 @@ u16 hpi_tuner_getRDS(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 u16 HPI_PAD__get_channel_name(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, char *psz_string, const u32 data_length)
 {
-	return hpi_control_get_string(ph_subsys, h_control,
-		HPI_PAD_CHANNEL_NAME, psz_string, data_length);
+	return hpi_control_get_string(h_control, HPI_PAD_CHANNEL_NAME,
+		psz_string, data_length);
 }
 
 u16 HPI_PAD__get_artist(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	char *psz_string, const u32 data_length)
 {
-	return hpi_control_get_string(ph_subsys, h_control, HPI_PAD_ARTIST,
-		psz_string, data_length);
+	return hpi_control_get_string(h_control, HPI_PAD_ARTIST, psz_string,
+		data_length);
 }
 
 u16 HPI_PAD__get_title(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	char *psz_string, const u32 data_length)
 {
-	return hpi_control_get_string(ph_subsys, h_control, HPI_PAD_TITLE,
-		psz_string, data_length);
+	return hpi_control_get_string(h_control, HPI_PAD_TITLE, psz_string,
+		data_length);
 }
 
 u16 HPI_PAD__get_comment(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	char *psz_string, const u32 data_length)
 {
-	return hpi_control_get_string(ph_subsys, h_control, HPI_PAD_COMMENT,
-		psz_string, data_length);
+	return hpi_control_get_string(h_control, HPI_PAD_COMMENT, psz_string,
+		data_length);
 }
 
 u16 HPI_PAD__get_program_type(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 *ppTY)
 {
-	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_PAD_PROGRAM_TYPE, 0, 0, ppTY, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_PAD_PROGRAM_TYPE, ppTY);
 }
 
 u16 HPI_PAD__get_rdsPI(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	u32 *ppI)
 {
-	return hpi_control_param_get(ph_subsys, h_control, HPI_PAD_PROGRAM_ID,
-		0, 0, ppI, NULL);
+	return hpi_control_param1_get(ph_subsys, h_control,
+		HPI_PAD_PROGRAM_ID, ppI);
 }
 
 u16 hpi_volume_query_channels(const struct hpi_hsubsys *ph_subsys,
@@ -3031,36 +3112,16 @@ u16 hpi_volume_set_gain(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	short an_log_gain[HPI_MAX_CHANNELS]
 	)
 {
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
-		HPI_CONTROL_SET_STATE);
-	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-	memcpy(hm.u.c.an_log_value, an_log_gain,
-		sizeof(short) * HPI_MAX_CHANNELS);
-	hm.u.c.attribute = HPI_VOLUME_GAIN;
-
-	hpi_send_recv(&hm, &hr);
-
-	return hr.error;
+	return hpi_control_log_set2(h_control, HPI_VOLUME_GAIN,
+		an_log_gain[0], an_log_gain[1]);
 }
 
 u16 hpi_volume_get_gain(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 	short an_log_gain[HPI_MAX_CHANNELS]
 	)
 {
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
-		HPI_CONTROL_GET_STATE);
-	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
-	hm.u.c.attribute = HPI_VOLUME_GAIN;
-
-	hpi_send_recv(&hm, &hr);
-
-	memcpy(an_log_gain, hr.u.c.an_log_value,
-		sizeof(short) * HPI_MAX_CHANNELS);
-	return hr.error;
+	return hpi_control_log_get2(ph_subsys, h_control, HPI_VOLUME_GAIN,
+		&an_log_gain[0], &an_log_gain[1]);
 }
 
 u16 hpi_volume_query_range(const struct hpi_hsubsys *ph_subsys, u32 h_control,
@@ -3068,6 +3129,7 @@ u16 hpi_volume_query_range(const struct hpi_hsubsys *ph_subsys, u32 h_control,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_GET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -3094,6 +3156,7 @@ u16 hpi_volume_auto_fade_profile(const struct hpi_hsubsys *ph_subsys,
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_CONTROL,
 		HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(h_control, &hm.adapter_index, &hm.obj_index);
@@ -3170,43 +3233,43 @@ static size_t entity_type_to_size[LAST_ENTITY_TYPE] = {
 	6 * sizeof(char),
 };
 
-inline size_t hpi_entity_size(struct hpi_entity *entity_ptr)
+static inline size_t hpi_entity_size(struct hpi_entity *entity_ptr)
 {
 	return entity_ptr->header.size;
 }
 
-inline size_t hpi_entity_header_size(struct hpi_entity *entity_ptr)
+static inline size_t hpi_entity_header_size(struct hpi_entity *entity_ptr)
 {
 	return sizeof(entity_ptr->header);
 }
 
-inline size_t hpi_entity_value_size(struct hpi_entity *entity_ptr)
+static inline size_t hpi_entity_value_size(struct hpi_entity *entity_ptr)
 {
 	return hpi_entity_size(entity_ptr) -
 		hpi_entity_header_size(entity_ptr);
 }
 
-inline size_t hpi_entity_item_count(struct hpi_entity *entity_ptr)
+static inline size_t hpi_entity_item_count(struct hpi_entity *entity_ptr)
 {
 	return hpi_entity_value_size(entity_ptr) /
 		entity_type_to_size[entity_ptr->header.type];
 }
 
-inline struct hpi_entity *hpi_entity_ptr_to_next(struct hpi_entity
+static inline struct hpi_entity *hpi_entity_ptr_to_next(struct hpi_entity
 	*entity_ptr)
 {
 	return (void *)(((uint8_t *) entity_ptr) +
 		hpi_entity_size(entity_ptr));
 }
 
-inline u16 hpi_entity_check_type(const enum e_entity_type t)
+static inline u16 hpi_entity_check_type(const enum e_entity_type t)
 {
 	if (t >= 0 && t < STR_TYPE_FIELD_MAX)
 		return 0;
 	return HPI_ERROR_ENTITY_TYPE_INVALID;
 }
 
-inline u16 hpi_entity_check_role(const enum e_entity_role r)
+static inline u16 hpi_entity_check_role(const enum e_entity_role r)
 {
 	if (r >= 0 && r < STR_ROLE_FIELD_MAX)
 		return 0;
@@ -3624,6 +3687,7 @@ u16 hpi_async_event_wait(const struct hpi_hsubsys *ph_subsys, u32 h_async,
 	u16 maximum_events, struct hpi_async_event *p_events,
 	u16 *pw_number_returned)
 {
+
 	return 0;
 }
 
-- 
1.7.0.4
