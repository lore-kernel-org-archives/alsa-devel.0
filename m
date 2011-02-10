From: linux@audioscience.com
Subject: [PATCH 04/28] HPI 4.05.14
Date: Thu, 10 Feb 2011 17:25:57 +1300
Message-ID: <1297311981-30448-5-git-send-email-linux@audioscience.com>
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

All enum values numeric for easier finding, particularly error codes.
Remove many unused declarations.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h |  262 +++++++-----------------------------------------------
 1 files changed, 33 insertions(+), 229 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 23399d0..4fb42c6 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -50,8 +50,8 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 4, 1)
-#define HPI_VER_STRING "4.04.01"
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 14)
+#define HPI_VER_STRING "4.05.14"
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
@@ -64,6 +64,7 @@ i.e 3.05.02 is a development version
 /********       HPI API DEFINITIONS                                       *****/
 /******************************************************************************/
 /******************************************************************************/
+
 /*******************************************/
 /**  Audio format types
 \ingroup stream
@@ -263,10 +264,10 @@ enum HPI_CONTROLS {
 	HPI_CONTROL_MULTIPLEXER = 5,	/**< multiplexer control. */
 
 	HPI_CONTROL_AESEBU_TRANSMITTER = 6,	/**< AES/EBU transmitter control. */
-	HPI_CONTROL_AESEBUTX = HPI_CONTROL_AESEBU_TRANSMITTER,
+	HPI_CONTROL_AESEBUTX = 6,	/* HPI_CONTROL_AESEBU_TRANSMITTER */
 
 	HPI_CONTROL_AESEBU_RECEIVER = 7, /**< AES/EBU receiver control. */
-	HPI_CONTROL_AESEBURX = HPI_CONTROL_AESEBU_RECEIVER,
+	HPI_CONTROL_AESEBURX = 7,	/* HPI_CONTROL_AESEBU_RECEIVER */
 
 	HPI_CONTROL_LEVEL = 8, /**< level/trim control - works in d_bu. */
 	HPI_CONTROL_TUNER = 9,	/**< tuner control. */
@@ -281,7 +282,7 @@ enum HPI_CONTROLS {
 	HPI_CONTROL_SAMPLECLOCK = 17,	/**< sample clock control. */
 	HPI_CONTROL_MICROPHONE = 18,	/**< microphone control. */
 	HPI_CONTROL_PARAMETRIC_EQ = 19,	/**< parametric EQ control. */
-	HPI_CONTROL_EQUALIZER = HPI_CONTROL_PARAMETRIC_EQ,
+	HPI_CONTROL_EQUALIZER = 19,	/*HPI_CONTROL_PARAMETRIC_EQ */
 
 	HPI_CONTROL_COMPANDER = 20,	/**< compander control. */
 	HPI_CONTROL_COBRANET = 21,	/**< cobranet control. */
@@ -767,14 +768,6 @@ enum HPI_TUNER_MODE_VALUES {
 	HPI_TUNER_MODE_RDS_RBDS = 2 /**<  RDS - RBDS mode */
 };
 
-/** Tuner Level settings
-\ingroup tuner
-*/
-enum HPI_TUNER_LEVEL {
-	HPI_TUNER_LEVEL_AVERAGE = 0,
-	HPI_TUNER_LEVEL_RAW = 1
-};
-
 /** Tuner Status Bits
 
 These bitfield values are returned by a call to HPI_Tuner_GetStatus().
@@ -783,13 +776,13 @@ Multiple fields are returned from a single call.
 */
 enum HPI_TUNER_STATUS_BITS {
 	HPI_TUNER_VIDEO_COLOR_PRESENT = 0x0001,	/**< video color is present. */
-	HPI_TUNER_VIDEO_IS_60HZ = 0x0020,	/**< 60 hz video detected. */
-	HPI_TUNER_VIDEO_HORZ_SYNC_MISSING = 0x0040,	/**< video HSYNC is missing. */
-	HPI_TUNER_VIDEO_STATUS_VALID = 0x0100,	/**< video status is valid. */
-	HPI_TUNER_PLL_LOCKED = 0x1000,		/**< the tuner's PLL is locked. */
-	HPI_TUNER_FM_STEREO = 0x2000,		/**< tuner reports back FM stereo. */
-	HPI_TUNER_DIGITAL = 0x0200,		/**< tuner reports digital programming. */
-	HPI_TUNER_MULTIPROGRAM = 0x0400		/**< tuner reports multiple programs. */
+	HPI_TUNER_VIDEO_IS_60HZ = 0x0020, /**< 60 hz video detected. */
+	HPI_TUNER_VIDEO_HORZ_SYNC_MISSING = 0x0040, /**< video HSYNC is missing. */
+	HPI_TUNER_VIDEO_STATUS_VALID = 0x0100, /**< video status is valid. */
+	HPI_TUNER_DIGITAL = 0x0200, /**< tuner reports digital programming. */
+	HPI_TUNER_MULTIPROGRAM = 0x0400, /**< tuner reports multiple programs. */
+	HPI_TUNER_PLL_LOCKED = 0x1000, /**< the tuner's PLL is locked. */
+	HPI_TUNER_FM_STEREO = 0x2000 /**< tuner reports back FM stereo. */
 };
 
 /** Channel Modes
@@ -909,6 +902,8 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL = 114,
 	/** The returned response did not match the sent message */
 	HPI_ERROR_RESPONSE_MISMATCH = 115,
+	/** A control setting that should have been cached was not. */
+	HPI_ERROR_CONTROL_CACHING = 116,
 
 	/** Too many adapters.*/
 	HPI_ERROR_TOO_MANY_ADAPTERS = 200,
@@ -954,13 +949,13 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_FLASH = 220,
 
 	/** Flash has bad checksum */
-	HPI_ERROR_BAD_CHECKSUM = (HPI_ERROR_FLASH + 1),
-	HPI_ERROR_BAD_SEQUENCE = (HPI_ERROR_FLASH + 2),
-	HPI_ERROR_FLASH_ERASE = (HPI_ERROR_FLASH + 3),
-	HPI_ERROR_FLASH_PROGRAM = (HPI_ERROR_FLASH + 4),
-	HPI_ERROR_FLASH_VERIFY = (HPI_ERROR_FLASH + 5),
-	HPI_ERROR_FLASH_TYPE = (HPI_ERROR_FLASH + 6),
-	HPI_ERROR_FLASH_START = (HPI_ERROR_FLASH + 7),
+	HPI_ERROR_BAD_CHECKSUM = 221,
+	HPI_ERROR_BAD_SEQUENCE = 222,
+	HPI_ERROR_FLASH_ERASE = 223,
+	HPI_ERROR_FLASH_PROGRAM = 224,
+	HPI_ERROR_FLASH_VERIFY = 225,
+	HPI_ERROR_FLASH_TYPE = 226,
+	HPI_ERROR_FLASH_START = 227,
 
 	/** Reserved for OEMs. */
 	HPI_ERROR_RESERVED_1 = 290,
@@ -1027,7 +1022,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_NVMEM_FAIL = 452,
 
 	/** I2C */
-	HPI_ERROR_I2C_MISSING_ACK = HPI_ERROR_CONTROL_I2C_MISSING_ACK,
+	HPI_ERROR_I2C_MISSING_ACK = 405,	/*HPI_ERROR_CONTROL_I2C_MISSING_ACK */
 	HPI_ERROR_I2C_BAD_ADR = 460,
 
 	/** Entity errors */
@@ -1035,6 +1030,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_ENTITY_ITEM_COUNT = 471,
 	HPI_ERROR_ENTITY_TYPE_INVALID = 472,
 	HPI_ERROR_ENTITY_ROLE_INVALID = 473,
+	HPI_ERROR_ENTITY_SIZE_MISMATCH = 474,
 
 	/* AES18 specific errors were 500..507 */
 
@@ -1045,10 +1041,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_MUTEX_TIMEOUT = 700,
 
 	/** errors from HPI backends have values >= this */
-	HPI_ERROR_BACKEND_BASE = 900,
-
-	/** indicates a cached u16 value is invalid. */
-	HPI_ERROR_ILLEGAL_CACHE_VALUE = 0xffff
+	HPI_ERROR_BACKEND_BASE = 900
 };
 
 /** \defgroup maximums HPI maximum values
@@ -1092,7 +1085,7 @@ struct hpi_format {
 				/**< Stereo/JointStereo/Mono */
 	u16 mode_legacy;
 				/**< Legacy ancillary mode or idle bit  */
-	u16 unused;	      /**< unused */
+	u16 unused;	      /**< Unused */
 	u16 channels; /**< 1,2..., (or ancillary mode or idle bit */
 	u16 format;   /**< HPI_FORMAT_PCM16, _MPEG etc. see #HPI_FORMATS. */
 };
@@ -1106,8 +1099,8 @@ struct hpi_anc_frame {
 */
 struct hpi_async_event {
 	u16 event_type;	/**< type of event. \sa async_event  */
-	u16 sequence;  /**< sequence number, allows lost event detection */
-	u32 state;    /**< new state */
+	u16 sequence;  /**< Sequence number, allows lost event detection */
+	u32 state;    /**< New state */
 	u32 h_object;	 /**< handle to the object returning the event. */
 	union {
 		struct {
@@ -1120,55 +1113,6 @@ struct hpi_async_event {
 	} u;
 };
 
-/*/////////////////////////////////////////////////////////////////////////// */
-/* Public HPI Entity related definitions                                     */
-
-struct hpi_entity;
-
-enum e_entity_type {
-	entity_type_null,
-	entity_type_sequence,	/* sequence of potentially heterogeneous TLV entities */
-
-	entity_type_reference,	/* refers to a TLV entity or NULL */
-
-	entity_type_int,	/* 32 bit */
-	entity_type_float,	/* ieee754 binary 32 bit encoding */
-	entity_type_double,
-
-	entity_type_cstring,
-	entity_type_octet,
-	entity_type_ip4_address,
-	entity_type_ip6_address,
-	entity_type_mac_address,
-
-	LAST_ENTITY_TYPE
-};
-
-enum e_entity_role {
-	entity_role_null,
-	entity_role_value,
-	entity_role_classname,
-
-	entity_role_units,
-	entity_role_flags,
-	entity_role_range,
-
-	entity_role_mapping,
-	entity_role_enum,
-
-	entity_role_instance_of,
-	entity_role_depends_on,
-	entity_role_member_of_group,
-	entity_role_value_constraint,
-	entity_role_parameter_port,
-
-	entity_role_block,
-	entity_role_node_group,
-	entity_role_audio_port,
-	entity_role_clock_port,
-	LAST_ENTITY_ROLE
-};
-
 /* skip host side function declarations for
    DSP compile and documentation extraction */
 
@@ -1191,34 +1135,19 @@ u16 hpi_stream_estimate_buffer_size(struct hpi_format *pF,
 
 /*/////////// */
 /* SUB SYSTEM */
-struct hpi_hsubsys *hpi_subsys_create(void
-	);
+struct hpi_hsubsys *hpi_subsys_create(void);
 
 void hpi_subsys_free(const struct hpi_hsubsys *ph_subsys);
 
-u16 hpi_subsys_get_version(const struct hpi_hsubsys *ph_subsys,
-	u32 *pversion);
-
 u16 hpi_subsys_get_version_ex(const struct hpi_hsubsys *ph_subsys,
 	u32 *pversion_ex);
 
-u16 hpi_subsys_get_info(const struct hpi_hsubsys *ph_subsys, u32 *pversion,
-	u16 *pw_num_adapters, u16 aw_adapter_list[], u16 list_length);
-
-u16 hpi_subsys_find_adapters(const struct hpi_hsubsys *ph_subsys,
-	u16 *pw_num_adapters, u16 aw_adapter_list[], u16 list_length);
-
 u16 hpi_subsys_get_num_adapters(const struct hpi_hsubsys *ph_subsys,
 	int *pn_num_adapters);
 
 u16 hpi_subsys_get_adapter(const struct hpi_hsubsys *ph_subsys, int iterator,
 	u32 *padapter_index, u16 *pw_adapter_type);
 
-u16 hpi_subsys_ssx2_bypass(const struct hpi_hsubsys *ph_subsys, u16 bypass);
-
-u16 hpi_subsys_set_host_network_interface(const struct hpi_hsubsys *ph_subsys,
-	const char *sz_interface);
-
 /*///////// */
 /* ADAPTER */
 
@@ -1244,13 +1173,10 @@ u16 hpi_adapter_set_mode_ex(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_adapter_get_mode(const struct hpi_hsubsys *ph_subsys,
 	u16 adapter_index, u32 *padapter_mode);
 
-u16 hpi_adapter_get_assert(const struct hpi_hsubsys *ph_subsys,
-	u16 adapter_index, u16 *assert_present, char *psz_assert,
-	u16 *pw_line_number);
-
-u16 hpi_adapter_get_assert_ex(const struct hpi_hsubsys *ph_subsys,
-	u16 adapter_index, u16 *assert_present, char *psz_assert,
-	u32 *pline_number, u16 *pw_assert_on_dsp);
+u16 hpi_adapter_get_assert2(const struct hpi_hsubsys *ph_subsys,
+	u16 adapter_index, u16 *p_assert_count, char *psz_assert,
+	u32 *p_param1, u32 *p_param2, u32 *p_dsp_string_addr,
+	u16 *p_processor_id);
 
 u16 hpi_adapter_test_assert(const struct hpi_hsubsys *ph_subsys,
 	u16 adapter_index, u16 assert_id);
@@ -1274,66 +1200,6 @@ u16 hpi_adapter_get_property(const struct hpi_hsubsys *ph_subsys,
 u16 hpi_adapter_enumerate_property(const struct hpi_hsubsys *ph_subsys,
 	u16 adapter_index, u16 index, u16 what_to_enumerate,
 	u16 property_index, u32 *psetting);
-
-/*////////////// */
-/* NonVol Memory */
-u16 hpi_nv_memory_open(const struct hpi_hsubsys *ph_subsys, u16 adapter_index,
-	u32 *ph_nv_memory, u16 *pw_size_in_bytes);
-
-u16 hpi_nv_memory_read_byte(const struct hpi_hsubsys *ph_subsys,
-	u32 h_nv_memory, u16 index, u16 *pw_data);
-
-u16 hpi_nv_memory_write_byte(const struct hpi_hsubsys *ph_subsys,
-	u32 h_nv_memory, u16 index, u16 data);
-
-/*////////////// */
-/* Digital I/O */
-u16 hpi_gpio_open(const struct hpi_hsubsys *ph_subsys, u16 adapter_index,
-	u32 *ph_gpio, u16 *pw_number_input_bits, u16 *pw_number_output_bits);
-
-u16 hpi_gpio_read_bit(const struct hpi_hsubsys *ph_subsys, u32 h_gpio,
-	u16 bit_index, u16 *pw_bit_data);
-
-u16 hpi_gpio_read_all_bits(const struct hpi_hsubsys *ph_subsys, u32 h_gpio,
-	u16 aw_all_bit_data[4]
-	);
-
-u16 hpi_gpio_write_bit(const struct hpi_hsubsys *ph_subsys, u32 h_gpio,
-	u16 bit_index, u16 bit_data);
-
-u16 hpi_gpio_write_status(const struct hpi_hsubsys *ph_subsys, u32 h_gpio,
-	u16 aw_all_bit_data[4]
-	);
-
-/**********************/
-/* Async Event Object */
-/**********************/
-u16 hpi_async_event_open(const struct hpi_hsubsys *ph_subsys,
-	u16 adapter_index, u32 *ph_async);
-
-u16 hpi_async_event_close(const struct hpi_hsubsys *ph_subsys, u32 h_async);
-
-u16 hpi_async_event_wait(const struct hpi_hsubsys *ph_subsys, u32 h_async,
-	u16 maximum_events, struct hpi_async_event *p_events,
-	u16 *pw_number_returned);
-
-u16 hpi_async_event_get_count(const struct hpi_hsubsys *ph_subsys,
-	u32 h_async, u16 *pw_count);
-
-u16 hpi_async_event_get(const struct hpi_hsubsys *ph_subsys, u32 h_async,
-	u16 maximum_events, struct hpi_async_event *p_events,
-	u16 *pw_number_returned);
-
-/*/////////// */
-/* WATCH-DOG  */
-u16 hpi_watchdog_open(const struct hpi_hsubsys *ph_subsys, u16 adapter_index,
-	u32 *ph_watchdog);
-
-u16 hpi_watchdog_set_time(const struct hpi_hsubsys *ph_subsys, u32 h_watchdog,
-	u32 time_millisec);
-
-u16 hpi_watchdog_ping(const struct hpi_hsubsys *ph_subsys, u32 h_watchdog);
-
 /**************/
 /* OUT STREAM */
 /**************/
@@ -1957,68 +1823,6 @@ u16 hpi_silence_detector_set_threshold(const struct hpi_hsubsys *ph_subsys,
 
 u16 hpi_silence_detector_get_threshold(const struct hpi_hsubsys *ph_subsys,
 	u32 hC, int *threshold);
-
-/*******************************
-  Universal control
-*******************************/
-u16 hpi_entity_find_next(struct hpi_entity *container_entity,
-	enum e_entity_type type, enum e_entity_role role, int recursive_flag,
-	struct hpi_entity **current_match);
-
-u16 hpi_entity_copy_value_from(struct hpi_entity *entity,
-	enum e_entity_type type, size_t item_count, void *value_dst_p);
-
-u16 hpi_entity_unpack(struct hpi_entity *entity, enum e_entity_type *type,
-	size_t *items, enum e_entity_role *role, void **value);
-
-u16 hpi_entity_alloc_and_pack(const enum e_entity_type type,
-	const size_t item_count, const enum e_entity_role role, void *value,
-	struct hpi_entity **entity);
-
-void hpi_entity_free(struct hpi_entity *entity);
-
-u16 hpi_universal_info(const struct hpi_hsubsys *ph_subsys, u32 hC,
-	struct hpi_entity **info);
-
-u16 hpi_universal_get(const struct hpi_hsubsys *ph_subsys, u32 hC,
-	struct hpi_entity **value);
-
-u16 hpi_universal_set(const struct hpi_hsubsys *ph_subsys, u32 hC,
-	struct hpi_entity *value);
-
-/*/////////// */
-/* DSP CLOCK  */
-/*/////////// */
-u16 hpi_clock_open(const struct hpi_hsubsys *ph_subsys, u16 adapter_index,
-	u32 *ph_dsp_clock);
-
-u16 hpi_clock_set_time(const struct hpi_hsubsys *ph_subsys, u32 h_clock,
-	u16 hour, u16 minute, u16 second, u16 milli_second);
-
-u16 hpi_clock_get_time(const struct hpi_hsubsys *ph_subsys, u32 h_clock,
-	u16 *pw_hour, u16 *pw_minute, u16 *pw_second, u16 *pw_milli_second);
-
-/*/////////// */
-/* PROFILE        */
-/*/////////// */
-u16 hpi_profile_open_all(const struct hpi_hsubsys *ph_subsys,
-	u16 adapter_index, u16 profile_index, u32 *ph_profile,
-	u16 *pw_max_profiles);
-
-u16 hpi_profile_get(const struct hpi_hsubsys *ph_subsys, u32 h_profile,
-	u16 index, u16 *pw_seconds, u32 *pmicro_seconds, u32 *pcall_count,
-	u32 *pmax_micro_seconds, u32 *pmin_micro_seconds);
-
-u16 hpi_profile_start_all(const struct hpi_hsubsys *ph_subsys, u32 h_profile);
-
-u16 hpi_profile_stop_all(const struct hpi_hsubsys *ph_subsys, u32 h_profile);
-
-u16 hpi_profile_get_name(const struct hpi_hsubsys *ph_subsys, u32 h_profile,
-	u16 index, char *sz_profile_name, u16 profile_name_length);
-
-u16 hpi_profile_get_utilization(const struct hpi_hsubsys *ph_subsys,
-	u32 h_profile, u32 *putilization);
-
 /*//////////////////// */
 /* UTILITY functions */
 
-- 
1.7.0.4
