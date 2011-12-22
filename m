From: linux@audioscience.com
Subject: [PATCH 10/21] Remove unused structs and defs
Date: Thu, 22 Dec 2011 13:38:40 +1300
Message-ID: <1324514331-22570-11-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 683E9103C1E
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:11 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:27 +1300 (NZDT)
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

Structs related to network flash update are not required in kernel.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi_internal.h |   96 +--------------------------------------
 1 files changed, 2 insertions(+), 94 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index e5e9e33..e06c5e0 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -25,6 +25,7 @@ HPI internal definitions
 #define _HPI_INTERNAL_H_
 
 #include "hpi.h"
+
 /** maximum number of memory regions mapped to an adapter */
 #define HPI_MAX_ADAPTER_MEM_SPACES (2)
 
@@ -220,8 +221,6 @@ enum HPI_CONTROL_ATTRIBUTES {
 
 	HPI_COBRANET_SET = HPI_CTL_ATTR(COBRANET, 1),
 	HPI_COBRANET_GET = HPI_CTL_ATTR(COBRANET, 2),
-	/*HPI_COBRANET_SET_DATA         = HPI_CTL_ATTR(COBRANET, 3), */
-	/*HPI_COBRANET_GET_DATA         = HPI_CTL_ATTR(COBRANET, 4), */
 	HPI_COBRANET_GET_STATUS = HPI_CTL_ATTR(COBRANET, 5),
 	HPI_COBRANET_SEND_PACKET = HPI_CTL_ATTR(COBRANET, 6),
 	HPI_COBRANET_GET_PACKET = HPI_CTL_ATTR(COBRANET, 7),
@@ -393,14 +392,10 @@ enum HPI_FUNCTION_IDS {
 	HPI_SUBSYS_OPEN = HPI_FUNC_ID(SUBSYSTEM, 1),
 	HPI_SUBSYS_GET_VERSION = HPI_FUNC_ID(SUBSYSTEM, 2),
 	HPI_SUBSYS_GET_INFO = HPI_FUNC_ID(SUBSYSTEM, 3),
-	/* HPI_SUBSYS_FIND_ADAPTERS     = HPI_FUNC_ID(SUBSYSTEM, 4), */
 	HPI_SUBSYS_CREATE_ADAPTER = HPI_FUNC_ID(SUBSYSTEM, 5),
 	HPI_SUBSYS_CLOSE = HPI_FUNC_ID(SUBSYSTEM, 6),
-	/* HPI_SUBSYS_DELETE_ADAPTER    = HPI_FUNC_ID(SUBSYSTEM, 7), */
 	HPI_SUBSYS_DRIVER_LOAD = HPI_FUNC_ID(SUBSYSTEM, 8),
 	HPI_SUBSYS_DRIVER_UNLOAD = HPI_FUNC_ID(SUBSYSTEM, 9),
-	/* HPI_SUBSYS_READ_PORT_8               = HPI_FUNC_ID(SUBSYSTEM, 10), */
-	/* HPI_SUBSYS_WRITE_PORT_8              = HPI_FUNC_ID(SUBSYSTEM, 11), */
 	HPI_SUBSYS_GET_NUM_ADAPTERS = HPI_FUNC_ID(SUBSYSTEM, 12),
 	HPI_SUBSYS_GET_ADAPTER = HPI_FUNC_ID(SUBSYSTEM, 13),
 	HPI_SUBSYS_SET_NETWORK_INTERFACE = HPI_FUNC_ID(SUBSYSTEM, 14),
@@ -661,13 +656,6 @@ union hpi_adapterx_msg {
 		u16 index;
 	} module_info;
 	struct {
-		u32 checksum;
-		u16 sequence;
-		u16 length;
-		u16 offset; /**< offset from start of msg to data */
-		u16 unused;
-	} program_flash;
-	struct {
 		u16 index;
 		u16 what;
 		u16 property_index;
@@ -678,25 +666,18 @@ union hpi_adapterx_msg {
 		u16 parameter2;
 	} property_set;
 	struct {
-		u32 offset;
-	} query_flash;
-	struct {
 		u32 pad32;
 		u16 key1;
 		u16 key2;
 	} restart;
 	struct {
-		u32 offset;
-		u32 length;
-		u32 key;
-	} start_flash;
-	struct {
 		u32 pad32;
 		u16 value;
 	} test_assert;
 	struct {
 		u32 yes;
 	} irq_query;
+	u32 pad[3];
 };
 
 struct hpi_adapter_res {
@@ -724,18 +705,10 @@ union hpi_adapterx_res {
 		u32 adapter_mode;
 	} mode;
 	struct {
-		u16 sequence;
-	} program_flash;
-	struct {
 		u16 parameter1;
 		u16 parameter2;
 	} property_get;
 	struct {
-		u32 checksum;
-		u32 length;
-		u32 version;
-	} query_flash;
-	struct {
 		u32 yes;
 	} irq_query;
 };
@@ -1150,71 +1123,6 @@ struct hpi_res_adapter_get_info {
 	struct hpi_adapter_res p;
 };
 
-/* padding is so these are same size as v0 hpi_message */
-struct hpi_msg_adapter_query_flash {
-	struct hpi_message_header h;
-	u32 offset;
-	u8 pad_to_version0_size[sizeof(struct hpi_message) -	/* V0 res */
-		sizeof(struct hpi_message_header) - 1 * sizeof(u32)];
-};
-
-/* padding is so these are same size as v0 hpi_response */
-struct hpi_res_adapter_query_flash {
-	struct hpi_response_header h;
-	u32 checksum;
-	u32 length;
-	u32 version;
-	u8 pad_to_version0_size[sizeof(struct hpi_response) -	/* V0 res */
-		sizeof(struct hpi_response_header) - 3 * sizeof(u32)];
-};
-
-struct hpi_msg_adapter_start_flash {
-	struct hpi_message_header h;
-	u32 offset;
-	u32 length;
-	u32 key;
-	u8 pad_to_version0_size[sizeof(struct hpi_message) -	/* V0 res */
-		sizeof(struct hpi_message_header) - 3 * sizeof(u32)];
-};
-
-struct hpi_res_adapter_start_flash {
-	struct hpi_response_header h;
-	u8 pad_to_version0_size[sizeof(struct hpi_response) -	/* V0 res */
-		sizeof(struct hpi_response_header)];
-};
-
-struct hpi_msg_adapter_program_flash_payload {
-	u32 checksum;
-	u16 sequence;
-	u16 length;
-	u16 offset; /**< offset from start of msg to data */
-	u16 unused;
-	/* ensure sizeof(header + payload) == sizeof(hpi_message_V0)
-	   because old firmware expects data after message of this size */
-	u8 pad_to_version0_size[sizeof(struct hpi_message) -	/* V0 message */
-		sizeof(struct hpi_message_header) - sizeof(u32) -
-		4 * sizeof(u16)];
-};
-
-struct hpi_msg_adapter_program_flash {
-	struct hpi_message_header h;
-	struct hpi_msg_adapter_program_flash_payload p;
-	u32 data[256];
-};
-
-struct hpi_res_adapter_program_flash {
-	struct hpi_response_header h;
-	u16 sequence;
-	u8 pad_to_version0_size[sizeof(struct hpi_response) -	/* V0 res */
-		sizeof(struct hpi_response_header) - sizeof(u16)];
-};
-
-struct hpi_msg_adapter_debug_read {
-	struct hpi_message_header h;
-	u32 dsp_address;
-	u32 count_bytes;
-};
-
 struct hpi_res_adapter_debug_read {
 	struct hpi_response_header h;
 	u8 bytes[256];
-- 
1.7.0.4
