From: linux@audioscience.com
Subject: [PATCH 16/21] New defs and comments.
Date: Thu, 22 Dec 2011 13:38:46 +1300
Message-ID: <1324514331-22570-17-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id B1F6C103C11
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:17 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:31 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
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

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Add new error codes, and adapter properties.
Clean up some comments.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi.h |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index f2f1d98..2088724 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -431,7 +431,19 @@ Indicates that the adapter in it's current mode supports interrupts
 across the host bus. Note, this does not imply that interrupts are
 enabled. Instead it indicates that they can be enabled.
 */
-	HPI_ADAPTER_PROPERTY_SUPPORTS_IRQ = 272
+	HPI_ADAPTER_PROPERTY_SUPPORTS_IRQ = 272,
+/** Readonly supports firmware updating.
+Indicates that the adapter implements an interface to update firmware
+on the adapter.
+*/
+	HPI_ADAPTER_PROPERTY_SUPPORTS_FW_UPDATE = 273,
+/** Readonly Firmware IDs
+Identifiy firmware independent of individual adapter type.
+May be used as a filter for firmware update images.
+Property 1 = Bootloader ID
+Property 2 = Main program ID
+*/
+	HPI_ADAPTER_PROPERTY_FIRMWARE_ID = 274
 };
 
 /** Adapter mode commands
@@ -619,7 +631,7 @@ enum HPI_MIXER_STORE_COMMAND {
 	HPI_MIXER_STORE_ENABLE = 4,
 /** Disable auto storage of some control settings. */
 	HPI_MIXER_STORE_DISABLE = 5,
-/** Save the attributes of a single control. */
+/** Unimplemented - save the attributes of a single control. */
 	HPI_MIXER_STORE_SAVE_SINGLE = 6
 };
 
@@ -922,7 +934,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_BAD_ADAPTER_NUMBER = 202,
 	/** 2 adapters with the same adapter number. */
 	HPI_ERROR_DUPLICATE_ADAPTER_NUMBER = 203,
-	/** DSP code failed to bootload. (unused?) */
+	/** DSP code failed to bootload. Usually a DSP memory test failure. */
 	HPI_ERROR_DSP_BOOTLOAD = 204,
 	/** Couldn't find or open the DSP code file. */
 	HPI_ERROR_DSP_FILE_NOT_FOUND = 206,
@@ -959,6 +971,9 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_FLASH_VERIFY = 225,
 	HPI_ERROR_FLASH_TYPE = 226,
 	HPI_ERROR_FLASH_START = 227,
+	HPI_ERROR_FLASH_READ = 228,
+	HPI_ERROR_FLASH_READ_NO_FILE = 229,
+	HPI_ERROR_FLASH_SIZE = 230,
 
 	/** Reserved for OEMs. */
 	HPI_ERROR_RESERVED_1 = 290,
@@ -1001,6 +1016,8 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_NO_INTERDSP_GROUPS = 315,
 	/** Stream wait cancelled before threshold reached. */
 	HPI_ERROR_WAIT_CANCELLED = 316,
+	/** A character string is invalid. */
+	HPI_ERROR_INVALID_STRING = 317,
 
 	/** Invalid mixer node for this adapter. */
 	HPI_ERROR_INVALID_NODE = 400,
@@ -1027,11 +1044,15 @@ enum HPI_ERROR_CODES {
 	/** I2C */
 	HPI_ERROR_I2C_BAD_ADR = 460,
 
-	/** Entity errors */
+	/** Entity type did not match requested type */
 	HPI_ERROR_ENTITY_TYPE_MISMATCH = 470,
+	/** Entity item count did not match requested count */
 	HPI_ERROR_ENTITY_ITEM_COUNT = 471,
+	/** Entity type is not one of the valid types */
 	HPI_ERROR_ENTITY_TYPE_INVALID = 472,
+	/** Entity role is not one of the valid roles */
 	HPI_ERROR_ENTITY_ROLE_INVALID = 473,
+	/** Entity size doesn't match target size */
 	HPI_ERROR_ENTITY_SIZE_MISMATCH = 474,
 
 	/* AES18 specific errors were 500..507 */
@@ -1059,8 +1080,7 @@ enum HPI_ERROR_CODES {
 /** \defgroup maximums HPI maximum values
 \{
 */
-/** Maximum number of adapters per HPI sub-system
-   WARNING: modifying this value changes the response structure size.*/
+/** Maximum number of PCI HPI adapters */
 #define HPI_MAX_ADAPTERS                20
 /** Maximum number of in or out streams per adapter */
 #define HPI_MAX_STREAMS                 16
@@ -1071,6 +1091,9 @@ enum HPI_ERROR_CODES {
 #define HPI_MAX_ANC_BYTES_PER_FRAME     (64)
 #define HPI_STRING_LEN                  16
 
+/** Networked adapters have index >= 100 */
+#define HPI_MIN_NETWORK_ADAPTER_IDX 100
+
 /** Velocity units */
 #define HPI_OSTREAM_VELOCITY_UNITS      4096
 /** OutStream timescale units */
@@ -1092,14 +1115,14 @@ enum HPI_ERROR_CODES {
 struct hpi_format {
 	u32 sample_rate;
 				/**< 11025, 32000, 44100 ... */
-	u32 bit_rate;	      /**< for MPEG */
+	u32 bit_rate;		  /**< for MPEG */
 	u32 attributes;
 				/**< Stereo/JointStereo/Mono */
 	u16 mode_legacy;
 				/**< Legacy ancillary mode or idle bit  */
-	u16 unused;	      /**< Unused */
-	u16 channels; /**< 1,2..., (or ancillary mode or idle bit */
-	u16 format;   /**< HPI_FORMAT_PCM16, _MPEG etc. see #HPI_FORMATS. */
+	u16 unused;		  /**< Unused */
+	u16 channels;	  /**< 1,2..., (or ancillary mode or idle bit */
+	u16 format;	  /**< HPI_FORMAT_PCM16, _MPEG etc. see #HPI_FORMATS. */
 };
 
 struct hpi_anc_frame {
@@ -1125,9 +1148,6 @@ struct hpi_async_event {
 	} u;
 };
 
-/* skip host side function declarations for
-   DSP compile and documentation extraction */
-
 #ifndef DISABLE_PRAGMA_PACK1
 #pragma pack(pop)
 #endif
@@ -1338,7 +1358,7 @@ u16 hpi_volume_get_mute(u32 h_control, u32 *mute);
 u16 hpi_volume_query_range(u32 h_control, short *min_gain_01dB,
 	short *max_gain_01dB, short *step_gain_01dB);
 
-u16 hpi_volume_query_channels(const u32 h_volume, u32 *p_channels);
+u16 hpi_volume_query_channels(const u32 h_control, u32 *p_channels);
 
 u16 hpi_volume_auto_fade(u32 h_control,
 	short an_stop_gain0_01dB[HPI_MAX_CHANNELS], u32 duration_ms);
-- 
1.7.0.4
