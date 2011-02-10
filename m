From: linux@audioscience.com
Subject: [PATCH 03/28] Simplify debug logging.
Date: Thu, 10 Feb 2011 17:25:56 +1300
Message-ID: <1297311981-30448-4-git-send-email-linux@audioscience.com>
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

Log HPI messages and responses in consistent numeric format,
which can be post-processed to get strings.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpidebug.c |  157 +-----------------------
 pci/asihpi/hpidebug.h |  323 +++----------------------------------------------
 2 files changed, 25 insertions(+), 455 deletions(-)

diff --git a/pci/asihpi/hpidebug.c b/pci/asihpi/hpidebug.c
index 949836e..4b81c80 100644
--- a/pci/asihpi/hpidebug.c
+++ b/pci/asihpi/hpidebug.c
@@ -45,161 +45,14 @@ int hpi_debug_level_get(void)
 	return hpi_debug_level;
 }
 
-#ifdef HPIOS_DEBUG_PRINT
-/* implies OS has no printf-like function */
-#include <stdarg.h>
-
-void hpi_debug_printf(char *fmt, ...)
-{
-	va_list arglist;
-	char buffer[128];
-
-	va_start(arglist, fmt);
-
-	if (buffer[0])
-		HPIOS_DEBUG_PRINT(buffer);
-	va_end(arglist);
-}
-#endif
-
-struct treenode {
-	void *array;
-	unsigned int num_elements;
-};
-
-#define make_treenode_from_array(nodename, array) \
-static void *tmp_strarray_##nodename[] = array; \
-static struct treenode nodename = { \
-	&tmp_strarray_##nodename, \
-	ARRAY_SIZE(tmp_strarray_##nodename) \
-};
-
-#define get_treenode_elem(node_ptr, idx, type)  \
-	(&(*((type *)(node_ptr)->array)[idx]))
-
-make_treenode_from_array(hpi_control_type_strings, HPI_CONTROL_TYPE_STRINGS)
-
-	make_treenode_from_array(hpi_subsys_strings, HPI_SUBSYS_STRINGS)
-	make_treenode_from_array(hpi_adapter_strings, HPI_ADAPTER_STRINGS)
-	make_treenode_from_array(hpi_istream_strings, HPI_ISTREAM_STRINGS)
-	make_treenode_from_array(hpi_ostream_strings, HPI_OSTREAM_STRINGS)
-	make_treenode_from_array(hpi_mixer_strings, HPI_MIXER_STRINGS)
-	make_treenode_from_array(hpi_node_strings,
-	{
-	"NODE is invalid object"})
-
-	make_treenode_from_array(hpi_control_strings, HPI_CONTROL_STRINGS)
-	make_treenode_from_array(hpi_nvmemory_strings, HPI_OBJ_STRINGS)
-	make_treenode_from_array(hpi_digitalio_strings, HPI_DIGITALIO_STRINGS)
-	make_treenode_from_array(hpi_watchdog_strings, HPI_WATCHDOG_STRINGS)
-	make_treenode_from_array(hpi_clock_strings, HPI_CLOCK_STRINGS)
-	make_treenode_from_array(hpi_profile_strings, HPI_PROFILE_STRINGS)
-	make_treenode_from_array(hpi_asyncevent_strings, HPI_ASYNCEVENT_STRINGS)
-#define HPI_FUNCTION_STRINGS \
-{ \
-  &hpi_subsys_strings,\
-  &hpi_adapter_strings,\
-  &hpi_ostream_strings,\
-  &hpi_istream_strings,\
-  &hpi_mixer_strings,\
-  &hpi_node_strings,\
-  &hpi_control_strings,\
-  &hpi_nvmemory_strings,\
-  &hpi_digitalio_strings,\
-  &hpi_watchdog_strings,\
-  &hpi_clock_strings,\
-  &hpi_profile_strings,\
-  &hpi_control_strings, \
-  &hpi_asyncevent_strings \
-}
-	make_treenode_from_array(hpi_function_strings, HPI_FUNCTION_STRINGS)
-
-	compile_time_assert(HPI_OBJ_MAXINDEX == 14, obj_list_doesnt_match);
-
-static char *hpi_function_string(unsigned int function)
-{
-	unsigned int object;
-	struct treenode *tmp;
-
-	object = function / HPI_OBJ_FUNCTION_SPACING;
-	function = function - object * HPI_OBJ_FUNCTION_SPACING;
-
-	if (object == 0 || object == HPI_OBJ_NODE
-		|| object > hpi_function_strings.num_elements)
-		return "invalid object";
-
-	tmp = get_treenode_elem(&hpi_function_strings, object - 1,
-		struct treenode *);
-
-	if (function == 0 || function > tmp->num_elements)
-		return "invalid function";
-
-	return get_treenode_elem(tmp, function - 1, char *);
-}
-
 void hpi_debug_message(struct hpi_message *phm, char *sz_fileline)
 {
 	if (phm) {
-		if ((phm->object <= HPI_OBJ_MAXINDEX) && phm->object) {
-			u16 index = 0;
-			u16 attrib = 0;
-			int is_control = 0;
-
-			index = phm->obj_index;
-			switch (phm->object) {
-			case HPI_OBJ_ADAPTER:
-			case HPI_OBJ_PROFILE:
-				break;
-			case HPI_OBJ_MIXER:
-				if (phm->function ==
-					HPI_MIXER_GET_CONTROL_BY_INDEX)
-					index = phm->u.m.control_index;
-				break;
-			case HPI_OBJ_OSTREAM:
-			case HPI_OBJ_ISTREAM:
-				break;
-
-			case HPI_OBJ_CONTROLEX:
-			case HPI_OBJ_CONTROL:
-				if (phm->version == 1)
-					attrib = HPI_CTL_ATTR(UNIVERSAL, 1);
-				else
-					attrib = phm->u.c.attribute;
-				is_control = 1;
-				break;
-			default:
-				break;
-			}
-
-			if (is_control && (attrib & 0xFF00)) {
-				int control_type = (attrib & 0xFF00) >> 8;
-				int attr_index = HPI_CTL_ATTR_INDEX(attrib);
-				/* note the KERN facility level
-				   is in szFileline already */
-				printk("%s adapter %d %s "
-					"ctrl_index x%04x %s %d\n",
-					sz_fileline, phm->adapter_index,
-					hpi_function_string(phm->function),
-					index,
-					get_treenode_elem
-					(&hpi_control_type_strings,
-						control_type, char *),
-					attr_index);
-
-			} else
-				printk("%s adapter %d %s "
-					"idx x%04x attr x%04x \n",
-					sz_fileline, phm->adapter_index,
-					hpi_function_string(phm->function),
-					index, attrib);
-		} else {
-			printk("adap=%d, invalid obj=%d, func=0x%x\n",
-				phm->adapter_index, phm->object,
-				phm->function);
-		}
-	} else
-		printk(KERN_ERR
-			"NULL message pointer to hpi_debug_message!\n");
+		printk("HPI_MSG%d,%d,%d,%d,%d\n", phm->version,
+			phm->adapter_index, phm->obj_index, phm->function,
+			phm->u.c.attribute);
+	}
+
 }
 
 void hpi_debug_data(u16 *pdata, u32 len)
diff --git a/pci/asihpi/hpidebug.h b/pci/asihpi/hpidebug.h
index a2f0952..632d7d0 100644
--- a/pci/asihpi/hpidebug.h
+++ b/pci/asihpi/hpidebug.h
@@ -37,7 +37,7 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
 #define HPI_DEBUG_LEVEL_DEFAULT HPI_DEBUG_LEVEL_NOTICE
 
 /* an OS can define an extra flag string that is appended to
-   the start of each message, eg see hpios_linux.h */
+   the start of each message, eg see linux kernel hpios.h */
 
 #ifdef SOURCEFILE_NAME
 #define FILE_LINE  SOURCEFILE_NAME ":" __stringify(__LINE__) " "
@@ -45,18 +45,11 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
 #define FILE_LINE  __FILE__ ":" __stringify(__LINE__) " "
 #endif
 
-#if defined(HPI_DEBUG) && defined(_WINDOWS)
-#define HPI_DEBUGBREAK() debug_break()
-#else
-#define HPI_DEBUGBREAK()
-#endif
-
 #define HPI_DEBUG_ASSERT(expression) \
 	do { \
-		if (!(expression)) {\
-			printk(KERN_ERR  FILE_LINE\
-				"ASSERT " __stringify(expression));\
-			HPI_DEBUGBREAK();\
+		if (!(expression)) { \
+			printk(KERN_ERR  FILE_LINE \
+				"ASSERT " __stringify(expression)); \
 		} \
 	} while (0)
 
@@ -78,28 +71,27 @@ void hpi_debug_message(struct hpi_message *phm, char *sz_fileline);
 
 void hpi_debug_data(u16 *pdata, u32 len);
 
-#define HPI_DEBUG_DATA(pdata, len)                                      \
-	do {                                                            \
+#define HPI_DEBUG_DATA(pdata, len) \
+	do { \
 		if (hpi_debug_level >= HPI_DEBUG_LEVEL_VERBOSE) \
 			hpi_debug_data(pdata, len); \
 	} while (0)
 
-#define HPI_DEBUG_MESSAGE(level, phm)                                   \
-	do {                                                            \
-		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) {         \
-			hpi_debug_message(phm,HPI_DEBUG_FLAG_##level    \
-				FILE_LINE __stringify(level));\
-		}                                                       \
+#define HPI_DEBUG_MESSAGE(level, phm) \
+	do { \
+		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
+			hpi_debug_message(phm,HPI_DEBUG_FLAG_##level \
+				FILE_LINE __stringify(level)); \
+		} \
 	} while (0)
 
-#define HPI_DEBUG_RESPONSE(phr)                                         \
-	do {                                                            \
-		if ((hpi_debug_level >= HPI_DEBUG_LEVEL_DEBUG) && (phr->error))\
-			HPI_DEBUG_LOG(ERROR, \
-				"HPI response - error# %d\n", \
-				phr->error); \
-		else if (hpi_debug_level >= HPI_DEBUG_LEVEL_VERBOSE) \
-			HPI_DEBUG_LOG(VERBOSE, "HPI response OK\n");\
+#define HPI_DEBUG_RESPONSE(phr) \
+	do { \
+		if (((hpi_debug_level >= HPI_DEBUG_LEVEL_DEBUG) && (phr->error)) ||\
+		(hpi_debug_level >= HPI_DEBUG_LEVEL_VERBOSE)) \
+			printk(KERN_DEBUG\
+				"HPI_RES%d,%d,%d\n", \
+				phr->version, phr->error, phr->specific_error); \
 	} while (0)
 
 #ifndef compile_time_assert
@@ -107,279 +99,4 @@ void hpi_debug_data(u16 *pdata, u32 len);
     typedef char msg[(cond) ? 1 : -1]
 #endif
 
-	  /* check that size is exactly some number */
-#define function_count_check(sym, size) \
-    compile_time_assert((sym##_FUNCTION_COUNT) == (size),\
-	    strings_match_defs_##sym)
-
-/* These strings should be generated using a macro which defines
-   the corresponding symbol values.  */
-#define HPI_OBJ_STRINGS \
-{                               \
-  "HPI_OBJ_SUBSYSTEM",        \
-  "HPI_OBJ_ADAPTER",          \
-  "HPI_OBJ_OSTREAM",          \
-  "HPI_OBJ_ISTREAM",          \
-  "HPI_OBJ_MIXER",            \
-  "HPI_OBJ_NODE",             \
-  "HPI_OBJ_CONTROL",          \
-  "HPI_OBJ_NVMEMORY",         \
-  "HPI_OBJ_DIGITALIO",        \
-  "HPI_OBJ_WATCHDOG",         \
-  "HPI_OBJ_CLOCK",            \
-  "HPI_OBJ_PROFILE",          \
-  "HPI_OBJ_CONTROLEX"         \
-}
-
-#define HPI_SUBSYS_STRINGS      \
-{                               \
-  "HPI_SUBSYS_OPEN",          \
-  "HPI_SUBSYS_GET_VERSION",   \
-  "HPI_SUBSYS_GET_INFO",      \
-  "HPI_SUBSYS_FIND_ADAPTERS", \
-  "HPI_SUBSYS_CREATE_ADAPTER",\
-  "HPI_SUBSYS_CLOSE",         \
-  "HPI_SUBSYS_DELETE_ADAPTER", \
-  "HPI_SUBSYS_DRIVER_LOAD", \
-  "HPI_SUBSYS_DRIVER_UNLOAD", \
-  "HPI_SUBSYS_READ_PORT_8",   \
-  "HPI_SUBSYS_WRITE_PORT_8",  \
-  "HPI_SUBSYS_GET_NUM_ADAPTERS",\
-  "HPI_SUBSYS_GET_ADAPTER",   \
-  "HPI_SUBSYS_SET_NETWORK_INTERFACE"\
-}
-function_count_check(HPI_SUBSYS, 14);
-
-#define HPI_ADAPTER_STRINGS     \
-{                               \
-  "HPI_ADAPTER_OPEN",         \
-  "HPI_ADAPTER_CLOSE",        \
-  "HPI_ADAPTER_GET_INFO",     \
-  "HPI_ADAPTER_GET_ASSERT",   \
-  "HPI_ADAPTER_TEST_ASSERT",    \
-  "HPI_ADAPTER_SET_MODE",       \
-  "HPI_ADAPTER_GET_MODE",       \
-  "HPI_ADAPTER_ENABLE_CAPABILITY",\
-  "HPI_ADAPTER_SELFTEST",        \
-  "HPI_ADAPTER_FIND_OBJECT",     \
-  "HPI_ADAPTER_QUERY_FLASH",     \
-  "HPI_ADAPTER_START_FLASH",     \
-  "HPI_ADAPTER_PROGRAM_FLASH",   \
-  "HPI_ADAPTER_SET_PROPERTY",    \
-  "HPI_ADAPTER_GET_PROPERTY",    \
-  "HPI_ADAPTER_ENUM_PROPERTY",    \
-  "HPI_ADAPTER_MODULE_INFO",    \
-  "HPI_ADAPTER_DEBUG_READ"    \
-}
-
-function_count_check(HPI_ADAPTER, 18);
-
-#define HPI_OSTREAM_STRINGS     \
-{                               \
-  "HPI_OSTREAM_OPEN",         \
-  "HPI_OSTREAM_CLOSE",        \
-  "HPI_OSTREAM_WRITE",        \
-  "HPI_OSTREAM_START",        \
-  "HPI_OSTREAM_STOP",         \
-  "HPI_OSTREAM_RESET",                \
-  "HPI_OSTREAM_GET_INFO",     \
-  "HPI_OSTREAM_QUERY_FORMAT", \
-  "HPI_OSTREAM_DATA",         \
-  "HPI_OSTREAM_SET_VELOCITY", \
-  "HPI_OSTREAM_SET_PUNCHINOUT", \
-  "HPI_OSTREAM_SINEGEN",        \
-  "HPI_OSTREAM_ANC_RESET",      \
-  "HPI_OSTREAM_ANC_GET_INFO",   \
-  "HPI_OSTREAM_ANC_READ",       \
-  "HPI_OSTREAM_SET_TIMESCALE",\
-  "HPI_OSTREAM_SET_FORMAT", \
-  "HPI_OSTREAM_HOSTBUFFER_ALLOC", \
-  "HPI_OSTREAM_HOSTBUFFER_FREE", \
-  "HPI_OSTREAM_GROUP_ADD",\
-  "HPI_OSTREAM_GROUP_GETMAP", \
-  "HPI_OSTREAM_GROUP_RESET", \
-  "HPI_OSTREAM_HOSTBUFFER_GET_INFO", \
-  "HPI_OSTREAM_WAIT_START", \
-}
-function_count_check(HPI_OSTREAM, 24);
-
-#define HPI_ISTREAM_STRINGS     \
-{                               \
-  "HPI_ISTREAM_OPEN",         \
-  "HPI_ISTREAM_CLOSE",        \
-  "HPI_ISTREAM_SET_FORMAT",   \
-  "HPI_ISTREAM_READ",         \
-  "HPI_ISTREAM_START",        \
-  "HPI_ISTREAM_STOP",         \
-  "HPI_ISTREAM_RESET",        \
-  "HPI_ISTREAM_GET_INFO",     \
-  "HPI_ISTREAM_QUERY_FORMAT", \
-  "HPI_ISTREAM_ANC_RESET",      \
-  "HPI_ISTREAM_ANC_GET_INFO",   \
-  "HPI_ISTREAM_ANC_WRITE",   \
-  "HPI_ISTREAM_HOSTBUFFER_ALLOC",\
-  "HPI_ISTREAM_HOSTBUFFER_FREE", \
-  "HPI_ISTREAM_GROUP_ADD", \
-  "HPI_ISTREAM_GROUP_GETMAP", \
-  "HPI_ISTREAM_GROUP_RESET", \
-  "HPI_ISTREAM_HOSTBUFFER_GET_INFO", \
-  "HPI_ISTREAM_WAIT_START", \
-}
-function_count_check(HPI_ISTREAM, 19);
-
-#define HPI_MIXER_STRINGS       \
-{                               \
-  "HPI_MIXER_OPEN",           \
-  "HPI_MIXER_CLOSE",          \
-  "HPI_MIXER_GET_INFO",       \
-  "HPI_MIXER_GET_NODE_INFO",  \
-  "HPI_MIXER_GET_CONTROL",    \
-  "HPI_MIXER_SET_CONNECTION", \
-  "HPI_MIXER_GET_CONNECTIONS",        \
-  "HPI_MIXER_GET_CONTROL_BY_INDEX",   \
-  "HPI_MIXER_GET_CONTROL_ARRAY_BY_INDEX",     \
-  "HPI_MIXER_GET_CONTROL_MULTIPLE_VALUES",    \
-  "HPI_MIXER_STORE",  \
-}
-function_count_check(HPI_MIXER, 11);
-
-#define HPI_CONTROL_STRINGS     \
-{                               \
-  "HPI_CONTROL_GET_INFO",     \
-  "HPI_CONTROL_GET_STATE",    \
-  "HPI_CONTROL_SET_STATE"     \
-}
-function_count_check(HPI_CONTROL, 3);
-
-#define HPI_NVMEMORY_STRINGS    \
-{                               \
-  "HPI_NVMEMORY_OPEN",        \
-  "HPI_NVMEMORY_READ_BYTE",   \
-  "HPI_NVMEMORY_WRITE_BYTE"   \
-}
-function_count_check(HPI_NVMEMORY, 3);
-
-#define HPI_DIGITALIO_STRINGS   \
-{                               \
-  "HPI_GPIO_OPEN",            \
-  "HPI_GPIO_READ_BIT",        \
-  "HPI_GPIO_WRITE_BIT",       \
-  "HPI_GPIO_READ_ALL",                \
-  "HPI_GPIO_WRITE_STATUS"\
-}
-function_count_check(HPI_GPIO, 5);
-
-#define HPI_WATCHDOG_STRINGS    \
-{                               \
-  "HPI_WATCHDOG_OPEN",        \
-  "HPI_WATCHDOG_SET_TIME",    \
-  "HPI_WATCHDOG_PING"         \
-}
-
-#define HPI_CLOCK_STRINGS       \
-{                               \
-  "HPI_CLOCK_OPEN",           \
-  "HPI_CLOCK_SET_TIME",       \
-  "HPI_CLOCK_GET_TIME"        \
-}
-
-#define HPI_PROFILE_STRINGS     \
-{                               \
-  "HPI_PROFILE_OPEN_ALL",     \
-  "HPI_PROFILE_START_ALL",    \
-  "HPI_PROFILE_STOP_ALL",     \
-  "HPI_PROFILE_GET",          \
-  "HPI_PROFILE_GET_IDLECOUNT",  \
-  "HPI_PROFILE_GET_NAME",       \
-  "HPI_PROFILE_GET_UTILIZATION" \
-}
-function_count_check(HPI_PROFILE, 7);
-
-#define HPI_ASYNCEVENT_STRINGS  \
-{                               \
-  "HPI_ASYNCEVENT_OPEN",\
-  "HPI_ASYNCEVENT_CLOSE  ",\
-  "HPI_ASYNCEVENT_WAIT",\
-  "HPI_ASYNCEVENT_GETCOUNT",\
-  "HPI_ASYNCEVENT_GET",\
-  "HPI_ASYNCEVENT_SENDEVENTS"\
-}
-function_count_check(HPI_ASYNCEVENT, 6);
-
-#define HPI_CONTROL_TYPE_STRINGS \
-{ \
-	"null control", \
-	"HPI_CONTROL_CONNECTION", \
-	"HPI_CONTROL_VOLUME", \
-	"HPI_CONTROL_METER", \
-	"HPI_CONTROL_MUTE", \
-	"HPI_CONTROL_MULTIPLEXER", \
-	"HPI_CONTROL_AESEBU_TRANSMITTER", \
-	"HPI_CONTROL_AESEBU_RECEIVER", \
-	"HPI_CONTROL_LEVEL", \
-	"HPI_CONTROL_TUNER", \
-	"HPI_CONTROL_ONOFFSWITCH", \
-	"HPI_CONTROL_VOX", \
-	"HPI_CONTROL_AES18_TRANSMITTER", \
-	"HPI_CONTROL_AES18_RECEIVER", \
-	"HPI_CONTROL_AES18_BLOCKGENERATOR", \
-	"HPI_CONTROL_CHANNEL_MODE", \
-	"HPI_CONTROL_BITSTREAM", \
-	"HPI_CONTROL_SAMPLECLOCK", \
-	"HPI_CONTROL_MICROPHONE", \
-	"HPI_CONTROL_PARAMETRIC_EQ", \
-	"HPI_CONTROL_COMPANDER", \
-	"HPI_CONTROL_COBRANET", \
-	"HPI_CONTROL_TONE_DETECT", \
-	"HPI_CONTROL_SILENCE_DETECT", \
-	"HPI_CONTROL_PAD", \
-	"HPI_CONTROL_SRC" ,\
-	"HPI_CONTROL_UNIVERSAL" \
-}
-
-compile_time_assert((HPI_CONTROL_LAST_INDEX + 1 == 27),
-	controltype_strings_match_defs);
-
-#define HPI_SOURCENODE_STRINGS \
-{ \
-	"no source", \
-	"HPI_SOURCENODE_OSTREAM", \
-	"HPI_SOURCENODE_LINEIN", \
-	"HPI_SOURCENODE_AESEBU_IN", \
-	"HPI_SOURCENODE_TUNER", \
-	"HPI_SOURCENODE_RF", \
-	"HPI_SOURCENODE_CLOCK_SOURCE", \
-	"HPI_SOURCENODE_RAW_BITSTREAM", \
-	"HPI_SOURCENODE_MICROPHONE", \
-	"HPI_SOURCENODE_COBRANET", \
-	"HPI_SOURCENODE_ANALOG", \
-	"HPI_SOURCENODE_ADAPTER" \
-}
-
-compile_time_assert((HPI_SOURCENODE_LAST_INDEX - HPI_SOURCENODE_NONE + 1) ==
-	(12), sourcenode_strings_match_defs);
-
-#define HPI_DESTNODE_STRINGS \
-{ \
-	"no destination", \
-	"HPI_DESTNODE_ISTREAM", \
-	"HPI_DESTNODE_LINEOUT", \
-	"HPI_DESTNODE_AESEBU_OUT", \
-	"HPI_DESTNODE_RF", \
-	"HPI_DESTNODE_SPEAKER", \
-	"HPI_DESTNODE_COBRANET", \
-	"HPI_DESTNODE_ANALOG" \
-}
-compile_time_assert((HPI_DESTNODE_LAST_INDEX - HPI_DESTNODE_NONE + 1) == (8),
-	destnode_strings_match_defs);
-
-#define HPI_CONTROL_CHANNEL_MODE_STRINGS \
-{ \
-	"XXX HPI_CHANNEL_MODE_ERROR XXX", \
-	"HPI_CHANNEL_MODE_NORMAL", \
-	"HPI_CHANNEL_MODE_SWAP", \
-	"HPI_CHANNEL_MODE_LEFT_ONLY", \
-	"HPI_CHANNEL_MODE_RIGHT_ONLY" \
-}
-
-#endif				/* _HPIDEBUG_H  */
+#endif				/* _HPIDEBUG_H_  */
-- 
1.7.0.4
