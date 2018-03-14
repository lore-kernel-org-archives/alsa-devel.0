From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v2 3/3] sndif: Add explicit back and
	front parameter negotiation
Date: Wed, 14 Mar 2018 18:02:45 +0200
Message-ID: <1521043365-26813-4-git-send-email-andr2000@gmail.com>
References: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5238B2673E5
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:02:59 +0100 (CET)
Received: by mail-lf0-f68.google.com with SMTP id w16-v6so5573340lfc.13
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 09:02:59 -0700 (PDT)
In-Reply-To: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, tiwai@suse.de
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

In order to provide explicit stream parameter negotiation between
backend and frontend the following changes are introduced in the protocol:
add XENSND_OP_HW_PARAM_QUERY request to read/update
configuration space for the parameter given: request passes
desired parameter interval (mask) and the response to this request
returns min/max interval (mask) for the parameter to be used.

Parameters supported by this request/response:
 - format mask
 - sample rate interval
 - number of channels interval
 - buffer size, interval, frames
 - period size, interval, frames

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 xen/include/public/io/sndif.h | 124 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
index 1a6a1467f253..ff0ba15b0462 100644
--- a/xen/include/public/io/sndif.h
+++ b/xen/include/public/io/sndif.h
@@ -465,12 +465,19 @@
 #define XENSND_OP_MUTE                  6
 #define XENSND_OP_UNMUTE                7
 #define XENSND_OP_TRIGGER               8
+#define XENSND_OP_HW_PARAM_QUERY        9
 
 #define XENSND_OP_TRIGGER_START         0
 #define XENSND_OP_TRIGGER_PAUSE         1
 #define XENSND_OP_TRIGGER_STOP          2
 #define XENSND_OP_TRIGGER_RESUME        3
 
+#define XENSND_OP_HW_PARAM_FORMAT       0
+#define XENSND_OP_HW_PARAM_RATE         1
+#define XENSND_OP_HW_PARAM_BUFFER       2
+#define XENSND_OP_HW_PARAM_PERIOD       3
+#define XENSND_OP_HW_PARAM_CHANNELS     4
+
 /*
  ******************************************************************************
  *                                 EVENT CODES
@@ -828,28 +835,127 @@ struct xensnd_trigger_req {
 };
 
 /*
+ * Request stream configuration parameter range: request interval or
+ *   bit mask of the supported values for the parameter given.
+ *
+ *   Sound device configuration for a particular stream is a limited subset
+ *   of the multidimensional configuration available on XenStore, for instance,
+ *   once frame rate has been selected there is a limited supported range
+ *   for sample rates becomes available (which might be the same set configured
+ *   on XenStore or less). For example, selecting 96kHz sample rate may limit
+ *   number of channels available for such configuration from 4 to 2 etc.
+ *   Thus, each call to XENSND_OP_HW_PARAM_QUERY will reduce configuration
+ *   space making it possible to iteratively get the final stream configuration,
+ *   used in XENSND_OP_OPEN request.
+ *
+ *   See response format for this request.
+ *
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                | _HW_PARAM_QUERY|    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |     param      |                     reserved                     | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                      min or mask low 32-bit                       | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                      max or mask high 32-bit                      | 20
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 24
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 28
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 32
+ * +----------------+----------------+----------------+----------------+
+ *
+ * param - uint8_t, XENSND_OP_HW_PARAM_XXX value
+ *
+ * The following parameters' payload treated as interval:
+ *   XENSND_OP_HW_PARAM_RATE
+ *   XENSND_OP_HW_PARAM_BUFFER
+ *   XENSND_OP_HW_PARAM_PERIOD
+ *   XENSND_OP_HW_PARAM_CHANNELS
+ *
+ * For interval parameters the payload of the request:
+ *   min - uint32_t, minimum value of the parameter
+ *   max - uint32_t, maximum value of the parameter
+ *
+ * For the following parameters their min and max values are expressed in
+ * frames:
+ *   XENSND_OP_HW_PARAM_BUFFER
+ *   XENSND_OP_HW_PARAM_PERIOD
+ * where frame is defined as a product of the number of channels by the
+ * number of octets per one sample.
+ *
+ * The following parameters' payload treated as a bit mask:
+ *   XENSND_OP_HW_PARAM_FORMAT
+ *
+ * For mask parameters the payload of the request:
+ *   mask - uint64_t, bit mask representing values of the parameter
+ */
+
+struct xensnd_query_hw_param_req {
+    uint8_t param;
+    uint8_t reserved[3];
+    union {
+        struct {
+            uint32_t min;
+            uint32_t max;
+        } interval;
+        uint64_t mask;
+    } val;
+};
+
+/*
  *---------------------------------- Responses --------------------------------
  *
  * All response packets have the same length (32 octets)
  *
- * Response for all requests:
+ * All response packets have common header:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |    operation   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              status                               | 8
+ * +----------------+----------------+----------------+----------------+
+ *
+ * id - uint16_t, copied from the request
+ * operation - uint8_t, XENSND_OP_* - copied from request
+ * status - int32_t, response status, zero on success and -XEN_EXX on failure
+ *
+ *
+ * HW parameter query response - response for XENSND_OP_HW_PARAM_QUERY:
  *         0                1                 2               3        octet
  * +----------------+----------------+----------------+----------------+
  * |               id                |    operation   |    reserved    | 4
  * +----------------+----------------+----------------+----------------+
  * |                              status                               | 8
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 12
+ * |                      min or mask low 32-bit                       | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                      max or mask high 32-bit                      | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
  * +----------------+----------------+----------------+----------------+
  *
- * id - uint16_t, copied from the request
- * operation - uint8_t, XENSND_OP_* - copied from request
- * status - int32_t, response status, zero on success and -XEN_EXX on failure
- *
+ * The payload meaning is the same as in the corresponing HW parameter
+ * request: see XENSND_OP_HW_PARAM_QUERY for details.
+ */
+
+union xensnd_query_hw_param_resp {
+    struct {
+        uint32_t min;
+        uint32_t max;
+    } interval;
+    uint64_t mask;
+};
+
+/*
  *----------------------------------- Events ----------------------------------
  *
  * Events are sent via a shared page allocated by the front and propagated by
@@ -902,6 +1008,7 @@ struct xensnd_req {
         struct xensnd_open_req open;
         struct xensnd_rw_req rw;
         struct xensnd_trigger_req trigger;
+        struct xensnd_query_hw_param_req hw_param;
         uint8_t reserved[24];
     } op;
 };
@@ -911,7 +1018,10 @@ struct xensnd_resp {
     uint8_t operation;
     uint8_t reserved;
     int32_t status;
-    uint8_t reserved1[24];
+    union {
+        union xensnd_query_hw_param_resp hw_param;
+        uint8_t reserved1[24];
+    } resp;
 };
 
 struct xensnd_evt {
-- 
2.7.4
