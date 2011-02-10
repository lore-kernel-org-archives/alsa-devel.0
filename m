From: linux@audioscience.com
Subject: [PATCH 23/28] New functions prep for interrupt driven
	streams.
Date: Thu, 10 Feb 2011 17:26:16 +1300
Message-ID: <1297311981-30448-24-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi.h          |   19 ++++++++++++++++++-
 pci/asihpi/hpi_internal.h |   25 +++++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 5ac978d..ec19df5 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -324,6 +324,15 @@ to enable SSX2 stream mapping within the kernel level of the driver.
 */
 	HPI_ADAPTER_PROPERTY_SSX2_SETTING = 4,
 
+/** Enables/disables PCI(e) IRQ.
+A setting of 0 indicates that no interrupts are being generated. A DSP boot
+this property is set to 0. Setting to a non-zero value specifies the number
+of frames of audio that should be processed between interrupts. This property
+should be set to multiple of the mixer interval as read back from the
+HPI_ADAPTER_PROPERTY_INTERVAL property.
+*/
+	HPI_ADAPTER_PROPERTY_IRQ_RATE = 5,
+
 /** Base number for readonly properties */
 	HPI_ADAPTER_PROPERTY_READONLYBASE = 256,
 
@@ -428,7 +437,13 @@ return value is true (1) or false (0). If the current adapter
 mode is MONO SSX2 is disabled, even though this property will
 return true.
 */
-	HPI_ADAPTER_PROPERTY_SUPPORTS_SSX2 = 271
+	HPI_ADAPTER_PROPERTY_SUPPORTS_SSX2 = 271,
+/** Readonly supports PCI(e) IRQ.
+Indicates that the adapter in it's current mode supports interrupts
+across the host bus. Note, this does not imply that interrupts are
+enabled. Instead it indicates that they can be enabled.
+*/
+	HPI_ADAPTER_PROPERTY_SUPPORTS_IRQ = 272
 };
 
 /** Adapter mode commands
@@ -998,6 +1013,8 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_NO_INTERADAPTER_GROUPS = 314,
 	/** Streams on different DSPs cannot be grouped. */
 	HPI_ERROR_NO_INTERDSP_GROUPS = 315,
+	/** Stream wait cancelled before threshold reached. */
+	HPI_ERROR_WAIT_CANCELLED = 316,
 
 	/** Invalid mixer node for this adapter. */
 	HPI_ERROR_INVALID_NODE = 400,
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 06a8779..ca5b844 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -432,7 +432,9 @@ enum HPI_FUNCTION_IDS {
 	HPI_ADAPTER_ENUM_PROPERTY = HPI_FUNC_ID(ADAPTER, 16),
 	HPI_ADAPTER_MODULE_INFO = HPI_FUNC_ID(ADAPTER, 17),
 	HPI_ADAPTER_DEBUG_READ = HPI_FUNC_ID(ADAPTER, 18),
-#define HPI_ADAPTER_FUNCTION_COUNT 18
+	HPI_ADAPTER_IRQ_QUERY_AND_CLEAR = HPI_FUNC_ID(ADAPTER, 19),
+	HPI_ADAPTER_IRQ_CALLBACK = HPI_FUNC_ID(ADAPTER, 20),
+#define HPI_ADAPTER_FUNCTION_COUNT 20
 
 	HPI_OSTREAM_OPEN = HPI_FUNC_ID(OSTREAM, 1),
 	HPI_OSTREAM_CLOSE = HPI_FUNC_ID(OSTREAM, 2),
@@ -458,7 +460,8 @@ enum HPI_FUNCTION_IDS {
 	HPI_OSTREAM_GROUP_RESET = HPI_FUNC_ID(OSTREAM, 22),
 	HPI_OSTREAM_HOSTBUFFER_GET_INFO = HPI_FUNC_ID(OSTREAM, 23),
 	HPI_OSTREAM_WAIT_START = HPI_FUNC_ID(OSTREAM, 24),
-#define HPI_OSTREAM_FUNCTION_COUNT 24
+	HPI_OSTREAM_WAIT = HPI_FUNC_ID(OSTREAM, 25),
+#define HPI_OSTREAM_FUNCTION_COUNT 25
 
 	HPI_ISTREAM_OPEN = HPI_FUNC_ID(ISTREAM, 1),
 	HPI_ISTREAM_CLOSE = HPI_FUNC_ID(ISTREAM, 2),
@@ -479,7 +482,8 @@ enum HPI_FUNCTION_IDS {
 	HPI_ISTREAM_GROUP_RESET = HPI_FUNC_ID(ISTREAM, 17),
 	HPI_ISTREAM_HOSTBUFFER_GET_INFO = HPI_FUNC_ID(ISTREAM, 18),
 	HPI_ISTREAM_WAIT_START = HPI_FUNC_ID(ISTREAM, 19),
-#define HPI_ISTREAM_FUNCTION_COUNT 19
+	HPI_ISTREAM_WAIT = HPI_FUNC_ID(ISTREAM, 20),
+#define HPI_ISTREAM_FUNCTION_COUNT 20
 
 /* NOTE:
    GET_NODE_INFO, SET_CONNECTION, GET_CONNECTIONS are not currently used */
@@ -494,7 +498,8 @@ enum HPI_FUNCTION_IDS {
 	HPI_MIXER_GET_CONTROL_ARRAY_BY_INDEX = HPI_FUNC_ID(MIXER, 9),
 	HPI_MIXER_GET_CONTROL_MULTIPLE_VALUES = HPI_FUNC_ID(MIXER, 10),
 	HPI_MIXER_STORE = HPI_FUNC_ID(MIXER, 11),
-#define HPI_MIXER_FUNCTION_COUNT 11
+	HPI_MIXER_GET_CACHE_INFO = HPI_FUNC_ID(MIXER, 12),
+#define HPI_MIXER_FUNCTION_COUNT 12
 
 	HPI_CONTROL_GET_INFO = HPI_FUNC_ID(CONTROL, 1),
 	HPI_CONTROL_GET_STATE = HPI_FUNC_ID(CONTROL, 2),
@@ -693,6 +698,9 @@ union hpi_adapterx_msg {
 		u32 pad32;
 		u16 value;
 	} test_assert;
+	struct {
+		u32 yes;
+	} irq_query;
 };
 
 struct hpi_adapter_res {
@@ -731,6 +739,9 @@ union hpi_adapterx_res {
 		u32 length;
 		u32 version;
 	} query_flash;
+	struct {
+		u32 yes;
+	} irq_query;
 };
 
 struct hpi_stream_msg {
@@ -742,6 +753,7 @@ struct hpi_stream_msg {
 		u32 time_scale;
 		struct hpi_buffer buffer;
 		struct hpi_streamid stream;
+		u32 threshold_bytes;
 	} u;
 };
 
@@ -828,6 +840,11 @@ union hpi_mixerx_res {
 		u32 p_data;	/* pointer to data array */
 		u16 more_to_do;	/* indicates if there is more to do */
 	} gcabi;
+	struct {
+		u32 total_controls;	/* count of controls in the mixer */
+		u32 cache_controls;	/* count of controls in the cac */
+		u32 cache_bytes;	/* size of cache */
+	} cache_info;
 };
 
 struct hpi_control_msg {
-- 
1.7.0.4
