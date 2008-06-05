From: linux@audioscience.com
Subject: [PATCH - ASIHPI 6/8] Version 3.10.00. Add new
 functions for HD radio tuner, and for firmware debug.
Date: Thu, 05 Jun 2008 16:06:59 +1200
Message-ID: <1212638821-2779-6-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
	<1212638821-2779-3-git-send-email-linux@audioscience.com>
	<1212638821-2779-4-git-send-email-linux@audioscience.com>
	<1212638821-2779-5-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD6410382E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:12 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:10 +1200 (NZST)
In-reply-to: <1212638821-2779-5-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <linux@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 1656941..a58bf71 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -41,12 +41,12 @@ i.e 3.05.02 is a development version
 #define HPI_VERSION_CONSTRUCTOR(maj, min, rel) \
 	((maj << 16) + (min << 8) + rel)
 
-#define HPI_VER_MAJOR(v) (v >> 16)
-#define HPI_VER_MINOR(v) ((v >> 8) & 0xFF)
-#define HPI_VER_RELEASE(v) (v & 0xFF)
+#define HPI_VER_MAJOR(v) (int)(v >> 16)
+#define HPI_VER_MINOR(v) (int)((v >> 8) & 0xFF)
+#define HPI_VER_RELEASE(v) (int)(v & 0xFF)
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 9, 15)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 10, 0)
 
 #ifdef _DOX_ONLY_
 /*****************************************************************************/
@@ -191,6 +191,8 @@ extern "C" {
 #define HPI_ADAPTER_ASI1722             0x1722
 /** ASI1731 - Quad TV tuner module */
 #define HPI_ADAPTER_ASI1731             0x1731
+/** ASI1741 - Quad HDRadio "pseudo" module */
+#define HPI_ADAPTER_ASI1741             0x1741
 /*ASI2214 - USB 2.0 1xanalog in, 4 x analog out, 1 x AES in/out */
 /*#define HPI_ADAPTER_ASI2214           0x2214  */
 
@@ -408,6 +410,8 @@ OBSOLETE - OEM 4 play PCM, MPEG*/
 #define HPI_ADAPTER_ASI8801             0x8801
 
 #define HPI_ADAPTER_FAMILY_ASI8900      0x8900
+/** 4 channel AM/FM HD-Radio */
+#define HPI_ADAPTER_ASI8914             0x8914
 /** OEM FM+RDS, 2 module tuner card */
 #define HPI_ADAPTER_ASI8920             0x8920
 /** 2 module tuner card */
@@ -471,7 +475,6 @@ The following table shows what combinations of mode and bitrate are possible:
 <td><p><b>Mono<br>Stereo @ 16,<br>22.050 and<br>24kHz*</b></p>
 <td><p><b>Mono<br>Stereo @ 32,<br>44.1 and<br>48kHz</b></p>
 
-<tr><td>8<td>X<td>X<td>_
 <tr><td>16<td>X<td>X<td>_
 <tr><td>24<td>X<td>X<td>_
 <tr><td>32<td>X<td>X<td>X
@@ -622,9 +625,10 @@ Audio samples from the device are sent out on the Cobranet network.*/
 #define HPI_CONTROL_COBRANET            21	/**< Cobranet control. */
 #define HPI_CONTROL_TONEDETECTOR        22	/**< Tone detector control. */
 #define HPI_CONTROL_SILENCEDETECTOR     23	/**< Silence detector control. */
+#define HPI_CONTROL_PAD                 24	/**< Tuner PAD control. */
 
 /*! Update this if you add a new control type. , AND hpidebug.h */
-#define HPI_CONTROL_LAST_INDEX                  23
+#define HPI_CONTROL_LAST_INDEX                  24
 
 /* WARNING types 32 or greater impact bit packing in all AX4 DSP code */
 /* WARNING types 256 or greater impact bit packing in all AX6 DSP code */
@@ -884,6 +888,9 @@ enum HPI_MIXER_STORE_COMMAND {
 /* This allows for 255 control types, 256 unique attributes each */
 #define HPI_CTL_ATTR(ctl, ai) (HPI_CONTROL_##ctl * 0x100 + ai)
 
+/* Get the sub-index of the attribute for a control type */
+#define HPI_CTL_ATTR_INDEX(i) (i&0xff)
+
 /* Original 0-based non-unique attributes, might become unique later */
 #define HPI_CTL_ATTR0(ctl, ai) (ai)
 
@@ -1009,6 +1016,42 @@ enum HPI_MIXER_STORE_COMMAND {
 #define HPI_TUNER_RDS                   HPI_CTL_ATTR0(TUNER, 9)
 /** Audio pre-emphasis. */
 #define HPI_TUNER_DEEMPHASIS            HPI_CTL_ATTR(TUNER, 10)
+/** HD-Radio tuner program control. */
+#define HPI_TUNER_PROGRAM               HPI_CTL_ATTR(TUNER, 11)
+/** HD-Radio tuner digital signal quality. */
+#define HPI_TUNER_HDRADIO_SIGNAL_QUALITY        HPI_CTL_ATTR(TUNER, 12)
+/** HD-Radio SDK firmware version. */
+#define HPI_TUNER_HDRADIO_SDK_VERSION   HPI_CTL_ATTR(TUNER, 13)
+/** HD-Radio DSP firmware version. */
+#define HPI_TUNER_HDRADIO_DSP_VERSION   HPI_CTL_ATTR(TUNER, 14)
+/** \} */
+
+/** \defgroup pads_attrs Tuner PADs control attributes
+\{
+*/
+/** The text string containing the station/channel combination. */
+#define HPI_PAD_CHANNEL_NAME            HPI_CTL_ATTR(PAD, 1)
+#define HPI_PAD_CHANNEL_NAME_LEN        16
+/** The text string containing the artist. */
+#define HPI_PAD_ARTIST                  HPI_CTL_ATTR(PAD, 2)
+#define HPI_PAD_ARTIST_LEN              64
+/** The text string containing the title. */
+#define HPI_PAD_TITLE                   HPI_CTL_ATTR(PAD, 3)
+#define HPI_PAD_TITLE_LEN               64
+/** The text string containing the comment. */
+#define HPI_PAD_COMMENT                 HPI_CTL_ATTR(PAD, 4)
+#define HPI_PAD_COMMENT_LEN             256
+/** The integer containing the PTY code. */
+#define HPI_PAD_PROGRAM_TYPE            HPI_CTL_ATTR(PAD, 5)
+/** The integer containing the program identification. */
+#define HPI_PAD_PROGRAM_ID              HPI_CTL_ATTR(PAD, 6)
+/** The integer containing whether traffic information is supported.
+Contains either 1 or 0. */
+#define HPI_PAD_TA_SUPPORT              HPI_CTL_ATTR(PAD, 7)
+/** The integer containing whether traffic announcement is in progress.
+Contains either 1 or 0. */
+#define HPI_PAD_TA_ACTIVE               HPI_CTL_ATTR(PAD, 8)
+
 /** \} */
 
 /** \defgroup tuner_bands Tuner bands
@@ -1040,13 +1083,21 @@ Used for HPI_Tuner_SetBand(),HPI_Tuner_GetBand()
 #define HPI_TUNER_LEVEL_AVERAGE         0
 #define HPI_TUNER_LEVEL_RAW             1
 
-/** Tuner video status */
+/** \defgroup tuner_status Tuner status fields
+
+These bitfield values are returned by a call to HPI_Tuner_GetStatus().
+Multiple fields are returned from a single call.
+\{
+*/
 #define HPI_TUNER_VIDEO_COLOR_PRESENT           0x0001	/**< Video color is present. */
 #define HPI_TUNER_VIDEO_IS_60HZ                 0x0020	/**< 60 Hz video detected. */
 #define HPI_TUNER_VIDEO_HORZ_SYNC_MISSING       0x0040	/**< Video HSYNC is missing. */
 #define HPI_TUNER_VIDEO_STATUS_VALID            0x0100	/**< Video status is valid. */
 #define HPI_TUNER_PLL_LOCKED                    0x1000	/**< The tuner's PLL is locked. */
 #define HPI_TUNER_FM_STEREO                     0x2000	/**< Tuner reports back FM stereo. */
+#define HPI_TUNER_DIGITAL                       0x0200	/**< Tuner reports digital programming. */
+#define HPI_TUNER_MULITPROGRAM                  0x0400	/**< Tuner reports multiple programs. */
+/** \} */
 /** \} */
 
 /* VOX control attributes */
@@ -1224,8 +1275,8 @@ enum HPI_FILTER_TYPE {
 
 #define HPI_ETHERNET_UDP_PORT (44600)	/*!< UDP messaging port */
 
-/** Base network time out is set to 2 seconds. */
-#define HPI_ETHERNET_TIMEOUT_MS      (2000)
+/** Base network time out is set to 100 milli-seconds. */
+#define HPI_ETHERNET_TIMEOUT_MS      (100)
 
 /** \defgroup tonedet_attr Tonedetector attributes
 \{
@@ -1705,6 +1756,14 @@ u16 HPI_AdapterSelfTest(
 	u16 wAdapterIndex
 );
 
+u16 HPI_AdapterDebugRead(
+	struct hpi_hsubsys *phSubSys,
+	u16 wAdapterIndex,
+	u32 dwDspAddress,
+	char *pBytes,
+	int *dwCountBytes
+);
+
 u16 HPI_AdapterSetProperty(
 	struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
@@ -2363,6 +2422,87 @@ u16 HPI_Tuner_GetDeemphasis(
 	u32 hControl,
 	u32 *pdwDeemphasis
 );
+u16 HPI_Tuner_SetProgram(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 dwProgram
+);
+u16 HPI_Tuner_GetProgram(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwProgram
+);
+u16 HPI_Tuner_GetHdRadioDspVersion(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszDspVersion,
+	const u32 dwStringSize
+);
+u16 HPI_Tuner_GetHdRadioSdkVersion(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszSdkVersion,
+	const u32 dwStringSize
+);
+
+u16 HPI_Tuner_GetHdRadioSignalQuality(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwQuality
+);
+
+/****************************/
+/* PADs control             */
+/****************************/
+
+u16 HPI_PAD_GetChannelName(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszData,
+	const u32 dwDataLength
+);
+
+u16 HPI_PAD_GetArtist(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszData,
+	const u32 dwDataLength
+);
+
+u16 HPI_PAD_GetTitle(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszData,
+	const u32 dwDataLength
+);
+
+u16 HPI_PAD_GetComment(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszData,
+	const u32 dwDataLength
+);
+
+u16 HPI_PAD_GetProgramType(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwPTY
+);
+
+u16 HPI_PAD_GetRdsPI(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwPI
+);
+
+u16 HPI_PAD_GetProgramTypeString(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	const u32 dwDataType,
+	const u32 nPTY,
+	char *pszData,
+	const u32 dwDataLength
+);
 
 /****************************/
 /* AES/EBU Receiver control */
@@ -2987,7 +3127,8 @@ u16 HPI_FormatCreate(
 #define HPI_ADAPTER_GET_PROPERTY        HPI_MAKE_INDEX(HPI_OBJ_ADAPTER, 15)
 #define HPI_ADAPTER_ENUM_PROPERTY       HPI_MAKE_INDEX(HPI_OBJ_ADAPTER, 16)
 #define HPI_ADAPTER_MODULE_INFO         HPI_MAKE_INDEX(HPI_OBJ_ADAPTER, 17)
-#define HPI_ADAPTER_FUNCTION_COUNT 17
+#define HPI_ADAPTER_DEBUG_READ          HPI_MAKE_INDEX(HPI_OBJ_ADAPTER, 18)
+#define HPI_ADAPTER_FUNCTION_COUNT 18
 /* OUTPUT STREAM */
 #define HPI_OSTREAM_OPEN                HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 1)
 #define HPI_OSTREAM_CLOSE               HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 2)
@@ -3135,7 +3276,7 @@ struct hpi_msg_format {
 };
 
 /**  Buffer+format structure.
-	 Must be kept 7 * 32 bits to match public struct hpi_data HPI_DATAstruct */
+	 Must be kept 7 * 32 bits to match public struct hpi_datastruct */
 struct hpi_msg_data {
 	struct hpi_msg_format Format;
 	u8 *pbData;
@@ -3145,7 +3286,7 @@ struct hpi_msg_data {
 	u32 dwDataSize;
 };
 
-/** struct hpi_data HPI_DATAstructure used up to 3.04 driver */
+/** struct hpi_datastructure used up to 3.04 driver */
 struct hpi_data_legacy32 {
 	struct hpi_format Format;
 	u32 pbData;
@@ -3153,7 +3294,7 @@ struct hpi_data_legacy32 {
 };
 
 #ifdef HPI64BIT
-/* Compatibility version of struct hpi_data HPI_DATA*/
+/* Compatibility version of struct hpi_data*/
 struct hpi_data_compat32 {
 	struct hpi_msg_format Format;
 	u32 pbData;
@@ -3218,6 +3359,10 @@ union hpi_adapterx_msg {
 	struct {
 		u16 index;
 	} module_info;
+	struct {
+		u32 dwDspAddress;
+		u32 dwCountBytes;
+	} debug_read;
 };
 
 struct hpi_adapter_res {
@@ -3334,7 +3479,7 @@ union hpi_mixerx_msg {
 
 union hpi_mixerx_res {
 	struct {
-		u32 dwBytesReturned;	/* number of items returned */
+		u32 dwBytesReturned;	/* size of items returned */
 		u32 pData;	/* pointer to data array */
 		u16 wMoreToDo;	/* indicates if there is more to do */
 	} gcabi;
@@ -3360,6 +3505,7 @@ struct hpi_control_union_msg {
 			u32 dwGain;
 			u32 dwBand;
 			u32 dwDeemphasis;
+			u32 dwProgram;
 			struct {
 				u32 dwMode;
 				u32 dwValue;
@@ -3394,6 +3540,10 @@ union hpi_control_union_res {
 			u32 dwBLER;
 		} rds;
 	} tuner;
+	struct {
+		char szData[8];
+		u32 dwRemainingChars;
+	} chars8;
 };
 
 /* HPI_CONTROLX_STRUCTURES */
@@ -3419,6 +3569,17 @@ struct hpi_controlx_msg_cobranet_bigdata {
 #endif
 };
 
+/** Used for PADS control reading of string fields.
+*/
+struct hpi_controlx_msg_pad_data {
+	u32 dwField;
+	u32 dwByteCount;
+	u8 *pbData;
+#ifndef HPI64BIT
+	u32 dwPadding;
+#endif
+};
+
 /** Used for generic data
 */
 
@@ -3432,6 +3593,7 @@ struct hpi_controlx_msg {
 		struct hpi_controlx_msg_cobranet_data cobranet_data;
 		struct hpi_controlx_msg_cobranet_bigdata cobranet_bigdata;
 		struct hpi_controlx_msg_generic generic;
+		struct hpi_controlx_msg_pad_data pad_data;
 		/* nothing extra to send for status read */
 	} u;
 	u16 wControlIndex;
@@ -3657,6 +3819,7 @@ struct hpi_response {
 		struct hpi_clock_res t;	/* dsp time */
 		struct hpi_profile_res p;
 		struct hpi_async_res as;
+		u8 bytes[52];
 	} u;
 };
 
@@ -3696,11 +3859,17 @@ struct hpi_control_defn {
 Used for efficient transfer of the control state
 between DSP and host or across a network
 */
-struct hpi_control_cache_single {
+struct hpi_control_cache_info {
 	/** one of HPI_CONTROL_* */
-	u16 ControlType;
+	u8 ControlType;
+	/** The total size of cached information in 32-bit words. */
+	u8 nSizeIn32bitWords;
 	/** The original index of the control on the DSP */
 	u16 ControlIndex;
+};
+
+struct hpi_control_cache_single {
+	struct hpi_control_cache_info i;
 	union {
 		struct {	/* volume */
 			u16 anLog[2];
@@ -3750,6 +3919,20 @@ struct hpi_control_cache_single {
 		} g;
 	} u;
 };
+
+struct hpi_control_cache_pad {
+	struct hpi_control_cache_info i;
+	u32 dwFieldValidFlags;
+	u8 cChannel[8];
+	u8 cArtist[40];
+	u8 cTitle[40];
+	u8 cComment[200];
+	u32 dwPTY;
+	u32 dwPI;
+	u32 dwTrafficSupported;
+	u32 dwTrafficAnouncement;
+};
+
 /*/////////////////////////////////////////////////////////////////////////// */
 /* declarations for 2^N sized FIFO buffer (internal to HPI<->DSP interaction) */
 struct hpi_fifo_buffer {
diff --git a/pci/asihpi/hpidebug.h b/pci/asihpi/hpidebug.h
index b8b6f61..d99a685 100644
--- a/pci/asihpi/hpidebug.h
+++ b/pci/asihpi/hpidebug.h
@@ -170,10 +170,11 @@ void hpi_debug_data(
   "HPI_ADAPTER_SET_PROPERTY",    \
   "HPI_ADAPTER_GET_PROPERTY",    \
   "HPI_ADAPTER_ENUM_PROPERTY",    \
-  "HPI_ADAPTER_MODULE_INFO"    \
+  "HPI_ADAPTER_MODULE_INFO",    \
+  "HPI_ADAPTER_DEBUG_READ"    \
 }
 
-function_count_check(HPI_ADAPTER, 17);
+function_count_check(HPI_ADAPTER, 18);
 
 #define HPI_OSTREAM_STRINGS     \
 {                               \
@@ -328,9 +329,10 @@ function_count_check(HPI_ASYNCEVENT, 6);
 	"HPI_CONTROL_COBRANET", \
 	"HPI_CONTROL_TONE_DETECT", \
 	"HPI_CONTROL_SILENCE_DETECT" \
+	"HPI_CONTROL_PAD" \
 }
 
-compile_time_assert((HPI_CONTROL_LAST_INDEX + 1) == (24),
+compile_time_assert((HPI_CONTROL_LAST_INDEX + 1) == (25),
 	controltype_strings_dont_match_defs);
 
 #define HPI_SOURCENODE_STRINGS \
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index ef61d18..6c33a80 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -606,6 +606,35 @@ u16 HPI_AdapterSelfTest(
 	return (hr.wError);
 }
 
+u16 HPI_AdapterDebugRead(
+	struct hpi_hsubsys *phSubSys,
+	u16 wAdapterIndex,
+	u32 dwDspAddress,
+	char *pBuffer,
+	int *dwCountBytes
+)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+	HPI_InitMessage(&hm, HPI_OBJ_ADAPTER, HPI_ADAPTER_DEBUG_READ);
+	hm.wAdapterIndex = wAdapterIndex;
+	hm.u.ax.debug_read.dwDspAddress = dwDspAddress;
+
+	if (*dwCountBytes > sizeof(hr.u.bytes))
+		*dwCountBytes = sizeof(hr.u.bytes);
+
+	hm.u.ax.debug_read.dwCountBytes = *dwCountBytes;
+
+	HPI_Message(&hm, &hr);
+
+	if (!hr.wError) {
+		*dwCountBytes = hr.wSize - 12;
+		memcpy(pBuffer, &hr.u.bytes, *dwCountBytes);
+	} else
+		*dwCountBytes = 0;
+	return (hr.wError);
+}
+
 u16 HPI_AdapterSetProperty(
 	struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
@@ -1692,6 +1721,61 @@ u16 HPI_ControlQuery(
 	return (hr.wError);
 }
 
+static u16 HPI_Control_GetString(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hControlHandle,
+	const u16 wAttribute,
+	char *pszString,
+	const u32 wStringLength
+)
+{
+	unsigned int subStringIndex = 0, j = 0;
+	char c = 0;
+	unsigned int n = 0;
+	u16 wHE = 0;
+
+	if ((wStringLength < 1) || (wStringLength > 256))
+		return HPI_ERROR_INVALID_CONTROL_VALUE;
+	for (subStringIndex = 0; subStringIndex < wStringLength;
+		subStringIndex += 8) {
+		struct hpi_message hm;
+		struct hpi_response hr;
+
+		HPI_InitMessage(&hm, HPI_OBJ_CONTROL, HPI_CONTROL_GET_STATE);
+		u32TOINDEXES(hControlHandle, &hm.wAdapterIndex,
+			&hm.u.c.wControlIndex);
+		hm.u.c.wAttribute = wAttribute;
+		hm.u.c.dwParam1 = subStringIndex;
+		hm.u.c.dwParam2 = 0;
+		HPI_Message(&hm, &hr);
+
+		if (subStringIndex == 0
+			&& (hr.u.cu.chars8.dwRemainingChars + 8) >
+			wStringLength)
+			return HPI_ERROR_INVALID_CONTROL_VALUE;
+
+		if (hr.wError) {
+			wHE = hr.wError;
+			break;
+		}
+		for (j = 0; j < 8; j++) {
+			c = hr.u.cu.chars8.szData[j];
+			pszString[subStringIndex + j] = c;
+			n++;
+			if (n >= wStringLength) {
+				pszString[wStringLength - 1] = 0;
+				wHE = HPI_ERROR_INVALID_CONTROL_VALUE;
+				break;
+			}
+			if (c == 0)
+				break;
+		}
+		if (c == 0)
+			break;
+	}
+	return wHE;
+}
+
 #if 0
 
 u16 HPI_Tuner_QueryFrequency(
@@ -2976,6 +3060,50 @@ u16 HPI_Tuner_GetDeemphasis(
 		pdwDeemphasis);
 }
 
+u16 HPI_Tuner_SetProgram(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 dwProgram
+)
+{
+	return HPI_ControlParamSet(phSubSys, hControl, HPI_TUNER_PROGRAM,
+		dwProgram, 0);
+}
+
+u16 HPI_Tuner_GetProgram(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwProgram
+)
+{
+	return HPI_ControlParam1Get(phSubSys, hControl, HPI_TUNER_PROGRAM,
+		pdwProgram);
+}
+
+u16 HPI_Tuner_GetHdRadioDspVersion(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszDspVersion,
+	const u32 dwStringSize
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl,
+		HPI_TUNER_HDRADIO_DSP_VERSION, pszDspVersion, dwStringSize);
+}
+
+u16 HPI_Tuner_GetHdRadioSdkVersion(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszSdkVersion,
+	const u32 dwStringSize
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl,
+		HPI_TUNER_HDRADIO_SDK_VERSION, pszSdkVersion, dwStringSize);
+}
+
 u16 HPI_Tuner_GetStatus(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3022,6 +3150,16 @@ u16 HPI_Tuner_GetMode(
 		nMode, 0, pnValue, NULL);
 }
 
+u16 HPI_Tuner_GetHdRadioSignalQuality(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwQuality
+)
+{
+	return HPI_ControlParamGet(phSubSys, hControl,
+		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, 0, 0, pdwQuality, NULL);
+}
+
 u16 HPI_Tuner_GetRDS(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3042,6 +3180,82 @@ u16 HPI_Tuner_GetRDS(
 	return (hr.wError);
 }
 
+#ifdef _DOX_ONLY_
+u16 HPI_Tuner_GetHdRadioSignalQuality(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwSignalQuality
+)
+{
+	return HPI_ControlParamGet(phSubSys, hControl,
+		HPI_TUNER_HDRADIO_SIGNAL_QUALITY, 0, 0, pdwSignalQuality, 0);
+}
+#endif
+
+u16 HPI_PAD_GetChannelName(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszString,
+	const u32 dwDataLength
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl, HPI_PAD_CHANNEL_NAME, pszString, dwDataLength);
+}
+
+u16 HPI_PAD_GetArtist(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszString,
+	const u32 dwDataLength
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl, HPI_PAD_ARTIST, pszString, dwDataLength);
+}
+
+u16 HPI_PAD_GetTitle(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszString,
+	const u32 dwDataLength
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl, HPI_PAD_TITLE, pszString, dwDataLength);
+}
+
+u16 HPI_PAD_GetComment(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	char *pszString,
+	const u32 dwDataLength
+)
+{
+	return HPI_Control_GetString(phSubSys,
+		hControl, HPI_PAD_COMMENT, pszString, dwDataLength);
+}
+
+u16 HPI_PAD_GetProgramType(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwPTY
+)
+{
+	return HPI_ControlParamGet(phSubSys, hControl, HPI_PAD_PROGRAM_TYPE,
+		0, 0, pdwPTY, NULL);
+}
+
+u16 HPI_PAD_GetRdsPI(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwPI
+)
+{
+	return HPI_ControlParamGet(phSubSys, hControl, HPI_PAD_PROGRAM_ID,
+		0, 0, pdwPI, NULL);
+}
+
 u16 HPI_VolumeSetGain(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
-- 
1.5.4.3
