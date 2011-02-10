From: linux@audioscience.com
Subject: [PATCH 22/28] Use consistent err return variable,
 change some bad variable names.
Date: Thu, 10 Feb 2011 17:26:15 +1300
Message-ID: <1297311981-30448-23-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpifunc.c |  143 ++++++++++++++++++++++++++------------------------
 1 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 3aa1f09..c38fc94 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -310,7 +310,7 @@ u16 hpi_adapter_enumerate_property(u16 adapter_index, u16 index,
 u16 hpi_format_create(struct hpi_format *p_format, u16 channels, u16 format,
 	u32 sample_rate, u32 bit_rate, u32 attributes)
 {
-	u16 error = 0;
+	u16 err = 0;
 	struct hpi_msg_format fmt;
 
 	switch (channels) {
@@ -322,8 +322,8 @@ u16 hpi_format_create(struct hpi_format *p_format, u16 channels, u16 format,
 	case 16:
 		break;
 	default:
-		error = HPI_ERROR_INVALID_CHANNELS;
-		return error;
+		err = HPI_ERROR_INVALID_CHANNELS;
+		return err;
 	}
 	fmt.channels = channels;
 
@@ -346,17 +346,17 @@ u16 hpi_format_create(struct hpi_format *p_format, u16 channels, u16 format,
 	case HPI_FORMAT_OEM2:
 		break;
 	default:
-		error = HPI_ERROR_INVALID_FORMAT;
-		return error;
+		err = HPI_ERROR_INVALID_FORMAT;
+		return err;
 	}
 	fmt.format = format;
 
 	if (sample_rate < 8000L) {
-		error = HPI_ERROR_INCOMPATIBLE_SAMPLERATE;
+		err = HPI_ERROR_INCOMPATIBLE_SAMPLERATE;
 		sample_rate = 8000L;
 	}
 	if (sample_rate > 200000L) {
-		error = HPI_ERROR_INCOMPATIBLE_SAMPLERATE;
+		err = HPI_ERROR_INCOMPATIBLE_SAMPLERATE;
 		sample_rate = 200000L;
 	}
 	fmt.sample_rate = sample_rate;
@@ -387,10 +387,10 @@ u16 hpi_format_create(struct hpi_format *p_format, u16 channels, u16 format,
 		if ((channels == 1)
 			&& (attributes != HPI_MPEG_MODE_DEFAULT)) {
 			attributes = HPI_MPEG_MODE_DEFAULT;
-			error = HPI_ERROR_INVALID_FORMAT;
+			err = HPI_ERROR_INVALID_FORMAT;
 		} else if (attributes > HPI_MPEG_MODE_DUALCHANNEL) {
 			attributes = HPI_MPEG_MODE_DEFAULT;
-			error = HPI_ERROR_INVALID_FORMAT;
+			err = HPI_ERROR_INVALID_FORMAT;
 		}
 		fmt.attributes = attributes;
 		break;
@@ -399,7 +399,7 @@ u16 hpi_format_create(struct hpi_format *p_format, u16 channels, u16 format,
 	}
 
 	hpi_msg_to_format(p_format, &fmt);
-	return error;
+	return err;
 }
 
 u16 hpi_stream_estimate_buffer_size(struct hpi_format *p_format,
@@ -1567,13 +1567,13 @@ u16 hpi_aesebu_receiver_get_channel_status(u32 h_control, u16 index,
 u16 hpi_aesebu_receiver_get_error_status(u32 h_control, u16 *pw_error_data)
 {
 	u32 error_data = 0;
-	u16 error = 0;
+	u16 err = 0;
 
-	error = hpi_control_param1_get(h_control, HPI_AESEBURX_ERRORSTATUS,
+	err = hpi_control_param1_get(h_control, HPI_AESEBURX_ERRORSTATUS,
 		&error_data);
 	if (pw_error_data)
 		*pw_error_data = (u16)error_data;
-	return error;
+	return err;
 }
 
 u16 hpi_aesebu_transmitter_set_sample_rate(u32 h_control, u32 sample_rate)
@@ -1680,11 +1680,11 @@ u16 hpi_channel_mode_set(u32 h_control, u16 mode)
 u16 hpi_channel_mode_get(u32 h_control, u16 *mode)
 {
 	u32 mode32 = 0;
-	u16 error = hpi_control_param1_get(h_control,
+	u16 err = hpi_control_param1_get(h_control,
 		HPI_CHANNEL_MODE_MODE, &mode32);
 	if (mode)
 		*mode = (u16)mode32;
-	return error;
+	return err;
 }
 
 u16 hpi_cobranet_hmi_write(u32 h_control, u32 hmi_address, u32 byte_count,
@@ -1785,9 +1785,9 @@ u16 hpi_cobranet_get_ip_address(u32 h_control, u32 *pdw_ip_address)
 {
 	u32 byte_count;
 	u32 iP;
-	u16 error;
+	u16 err;
 
-	error = hpi_cobranet_hmi_read(h_control,
+	err = hpi_cobranet_hmi_read(h_control,
 		HPI_COBRANET_HMI_cobra_ip_mon_currentIP, 4, &byte_count,
 		(u8 *)&iP);
 
@@ -1795,26 +1795,26 @@ u16 hpi_cobranet_get_ip_address(u32 h_control, u32 *pdw_ip_address)
 		((iP & 0xff000000) >> 8) | ((iP & 0x00ff0000) << 8) | ((iP &
 			0x0000ff00) >> 8) | ((iP & 0x000000ff) << 8);
 
-	if (error)
+	if (err)
 		*pdw_ip_address = 0;
 
-	return error;
+	return err;
 
 }
 
 u16 hpi_cobranet_set_ip_address(u32 h_control, u32 dw_ip_address)
 {
 	u32 iP;
-	u16 error;
+	u16 err;
 
 	iP = ((dw_ip_address & 0xff000000) >> 8) | ((dw_ip_address &
 			0x00ff0000) << 8) | ((dw_ip_address & 0x0000ff00) >>
 		8) | ((dw_ip_address & 0x000000ff) << 8);
 
-	error = hpi_cobranet_hmi_write(h_control,
+	err = hpi_cobranet_hmi_write(h_control,
 		HPI_COBRANET_HMI_cobra_ip_mon_currentIP, 4, (u8 *)&iP);
 
-	return error;
+	return err;
 
 }
 
@@ -1822,8 +1822,8 @@ u16 hpi_cobranet_get_static_ip_address(u32 h_control, u32 *pdw_ip_address)
 {
 	u32 byte_count;
 	u32 iP;
-	u16 error;
-	error = hpi_cobranet_hmi_read(h_control,
+	u16 err;
+	err = hpi_cobranet_hmi_read(h_control,
 		HPI_COBRANET_HMI_cobra_ip_mon_staticIP, 4, &byte_count,
 		(u8 *)&iP);
 
@@ -1831,55 +1831,62 @@ u16 hpi_cobranet_get_static_ip_address(u32 h_control, u32 *pdw_ip_address)
 		((iP & 0xff000000) >> 8) | ((iP & 0x00ff0000) << 8) | ((iP &
 			0x0000ff00) >> 8) | ((iP & 0x000000ff) << 8);
 
-	if (error)
+	if (err)
 		*pdw_ip_address = 0;
 
-	return error;
+	return err;
 
 }
 
 u16 hpi_cobranet_set_static_ip_address(u32 h_control, u32 dw_ip_address)
 {
 	u32 iP;
-	u16 error;
+	u16 err;
 
 	iP = ((dw_ip_address & 0xff000000) >> 8) | ((dw_ip_address &
 			0x00ff0000) << 8) | ((dw_ip_address & 0x0000ff00) >>
 		8) | ((dw_ip_address & 0x000000ff) << 8);
 
-	error = hpi_cobranet_hmi_write(h_control,
+	err = hpi_cobranet_hmi_write(h_control,
 		HPI_COBRANET_HMI_cobra_ip_mon_staticIP, 4, (u8 *)&iP);
 
-	return error;
+	return err;
 
 }
 
-u16 hpi_cobranet_get_macaddress(u32 h_control, u32 *pmAC_MS_bs,
-	u32 *pmAC_LS_bs)
+u16 hpi_cobranet_get_macaddress(u32 h_control, u32 *p_mac_msbs,
+	u32 *p_mac_lsbs)
 {
 	u32 byte_count;
-	u16 error;
-	u32 mAC;
+	u16 err;
+	u32 mac;
 
-	error = hpi_cobranet_hmi_read(h_control,
+	err = hpi_cobranet_hmi_read(h_control,
 		HPI_COBRANET_HMI_cobra_if_phy_address, 4, &byte_count,
-		(u8 *)&mAC);
-	*pmAC_MS_bs =
-		((mAC & 0xff000000) >> 8) | ((mAC & 0x00ff0000) << 8) | ((mAC
-			& 0x0000ff00) >> 8) | ((mAC & 0x000000ff) << 8);
-	error += hpi_cobranet_hmi_read(h_control,
-		HPI_COBRANET_HMI_cobra_if_phy_address + 1, 4, &byte_count,
-		(u8 *)&mAC);
-	*pmAC_LS_bs =
-		((mAC & 0xff000000) >> 8) | ((mAC & 0x00ff0000) << 8) | ((mAC
-			& 0x0000ff00) >> 8) | ((mAC & 0x000000ff) << 8);
-
-	if (error) {
-		*pmAC_MS_bs = 0;
-		*pmAC_LS_bs = 0;
+		(u8 *)&mac);
+
+	if (!err) {
+		*p_mac_msbs =
+			((mac & 0xff000000) >> 8) | ((mac & 0x00ff0000) << 8)
+			| ((mac & 0x0000ff00) >> 8) | ((mac & 0x000000ff) <<
+			8);
+
+		err = hpi_cobranet_hmi_read(h_control,
+			HPI_COBRANET_HMI_cobra_if_phy_address + 1, 4,
+			&byte_count, (u8 *)&mac);
 	}
 
-	return error;
+	if (!err) {
+		*p_mac_lsbs =
+			((mac & 0xff000000) >> 8) | ((mac & 0x00ff0000) << 8)
+			| ((mac & 0x0000ff00) >> 8) | ((mac & 0x000000ff) <<
+			8);
+	} else {
+		*p_mac_msbs = 0;
+		*p_mac_lsbs = 0;
+	}
+
+	return err;
 }
 
 u16 hpi_compander_set_enable(u32 h_control, u32 enable)
@@ -2158,14 +2165,14 @@ u16 hpi_multiplexer_get_source(u32 h_control, u16 *source_node_type,
 	u16 *source_node_index)
 {
 	u32 node, index;
-	u16 error = hpi_control_param2_get(h_control,
+	u16 err = hpi_control_param2_get(h_control,
 		HPI_MULTIPLEXER_SOURCE, &node,
 		&index);
 	if (source_node_type)
 		*source_node_type = (u16)node;
 	if (source_node_index)
 		*source_node_index = (u16)index;
-	return error;
+	return err;
 }
 
 u16 hpi_multiplexer_query_source(u32 h_control, u16 index,
@@ -2304,14 +2311,14 @@ u16 hpi_sample_clock_set_source(u32 h_control, u16 source)
 
 u16 hpi_sample_clock_get_source(u32 h_control, u16 *pw_source)
 {
-	u16 error = 0;
+	u16 err = 0;
 	u32 source = 0;
-	error = hpi_control_param1_get(h_control, HPI_SAMPLECLOCK_SOURCE,
+	err = hpi_control_param1_get(h_control, HPI_SAMPLECLOCK_SOURCE,
 		&source);
-	if (!error)
+	if (!err)
 		if (pw_source)
 			*pw_source = (u16)source;
-	return error;
+	return err;
 }
 
 u16 hpi_sample_clock_query_source_index(const u32 h_clock, const u32 index,
@@ -2334,14 +2341,14 @@ u16 hpi_sample_clock_set_source_index(u32 h_control, u16 source_index)
 
 u16 hpi_sample_clock_get_source_index(u32 h_control, u16 *pw_source_index)
 {
-	u16 error = 0;
+	u16 err = 0;
 	u32 source_index = 0;
-	error = hpi_control_param1_get(h_control,
-		HPI_SAMPLECLOCK_SOURCE_INDEX, &source_index);
-	if (!error)
+	err = hpi_control_param1_get(h_control, HPI_SAMPLECLOCK_SOURCE_INDEX,
+		&source_index);
+	if (!err)
 		if (pw_source_index)
 			*pw_source_index = (u16)source_index;
-	return error;
+	return err;
 }
 
 u16 hpi_sample_clock_query_local_rate(const u32 h_clock, const u32 index,
@@ -2362,26 +2369,26 @@ u16 hpi_sample_clock_set_local_rate(u32 h_control, u32 sample_rate)
 
 u16 hpi_sample_clock_get_local_rate(u32 h_control, u32 *psample_rate)
 {
-	u16 error = 0;
+	u16 err = 0;
 	u32 sample_rate = 0;
-	error = hpi_control_param1_get(h_control,
+	err = hpi_control_param1_get(h_control,
 		HPI_SAMPLECLOCK_LOCAL_SAMPLERATE, &sample_rate);
-	if (!error)
+	if (!err)
 		if (psample_rate)
 			*psample_rate = sample_rate;
-	return error;
+	return err;
 }
 
 u16 hpi_sample_clock_get_sample_rate(u32 h_control, u32 *psample_rate)
 {
-	u16 error = 0;
+	u16 err = 0;
 	u32 sample_rate = 0;
-	error = hpi_control_param1_get(h_control, HPI_SAMPLECLOCK_SAMPLERATE,
+	err = hpi_control_param1_get(h_control, HPI_SAMPLECLOCK_SAMPLERATE,
 		&sample_rate);
-	if (!error)
+	if (!err)
 		if (psample_rate)
 			*psample_rate = sample_rate;
-	return error;
+	return err;
 }
 
 u16 hpi_sample_clock_set_auto(u32 h_control, u32 enable)
-- 
1.7.0.4
