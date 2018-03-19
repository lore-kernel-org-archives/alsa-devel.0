From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v3 3/5] sndif: Make requests and
	responses 64 octets long
Date: Mon, 19 Mar 2018 09:22:22 +0200
Message-ID: <1521444144-12451-4-git-send-email-andr2000@gmail.com>
References: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A6C2673ED
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:22:39 +0100 (CET)
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so17571688lff.3
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 00:22:39 -0700 (PDT)
In-Reply-To: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
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

Extend the size of the requests and responses to 64 octets.
Bump protocol version to 2.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 xen/include/public/io/sndif.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
index 916be1d3a13f..ec47ff990f2c 100644
--- a/xen/include/public/io/sndif.h
+++ b/xen/include/public/io/sndif.h
@@ -41,7 +41,7 @@
  *                           Protocol version
  ******************************************************************************
  */
-#define XENSND_PROTOCOL_VERSION         1
+#define XENSND_PROTOCOL_VERSION         2
 
 /*
  ******************************************************************************
@@ -533,7 +533,7 @@
  *
  *---------------------------------- Requests ---------------------------------
  *
- * All request packets have the same length (32 octets)
+ * All request packets have the same length (64 octets)
  * All request packets have common header:
  *         0                1                 2               3        octet
  * +----------------+----------------+----------------+----------------+
@@ -570,7 +570,7 @@
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * pcm_rate - uint32_t, stream data rate, Hz
@@ -639,7 +639,7 @@ struct xensnd_page_directory {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * Request read/write - used for read (for capture) or write (for playback):
@@ -657,7 +657,7 @@ struct xensnd_page_directory {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_READ for read or XENSND_OP_WRITE for write
@@ -684,7 +684,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_SET_VOLUME for volume set
@@ -726,7 +726,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_MUTE for mute or XENSND_OP_UNMUTE for unmute
@@ -759,7 +759,7 @@ struct xensnd_rw_req {
 /*
  *---------------------------------- Responses --------------------------------
  *
- * All response packets have the same length (32 octets)
+ * All response packets have the same length (64 octets)
  *
  * Response for all requests:
  *         0                1                 2               3        octet
@@ -772,7 +772,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * id - uint16_t, copied from the request
@@ -787,7 +787,7 @@ struct xensnd_req {
     union {
         struct xensnd_open_req open;
         struct xensnd_rw_req rw;
-        uint8_t reserved[24];
+        uint8_t reserved[56];
     } op;
 };
 
@@ -796,7 +796,7 @@ struct xensnd_resp {
     uint8_t operation;
     uint8_t reserved;
     int32_t status;
-    uint8_t reserved1[24];
+    uint8_t reserved1[56];
 };
 
 DEFINE_RING_TYPES(xen_sndif, struct xensnd_req, struct xensnd_resp);
-- 
2.7.4
