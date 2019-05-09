From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 14/30] mfd: cros_ec: Add EC transport protocol v4
Date: Thu,  9 May 2019 14:13:37 -0700
Message-ID: <20190509211353.213194-15-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

Introduce a new transport procotol between EC and host.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 143 ++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 76943e64998a..40a8069a58e8 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -455,7 +455,10 @@
 #define EC_LPC_STATUS_BUSY_MASK \
 	(EC_LPC_STATUS_FROM_HOST | EC_LPC_STATUS_PROCESSING)
 
-/* Host command response codes */
+/*
+ * Host command response codes (16-bit).  Note that response codes should be
+ * stored in a uint16_t rather than directly in a value of this type.
+ */
 enum ec_status {
 	EC_RES_SUCCESS = 0,
 	EC_RES_INVALID_COMMAND = 1,
@@ -471,7 +474,13 @@ enum ec_status {
 	EC_RES_OVERFLOW = 11,		/* Table / data overflow */
 	EC_RES_INVALID_HEADER = 12,     /* Header contains invalid data */
 	EC_RES_REQUEST_TRUNCATED = 13,  /* Didn't get the entire request */
-	EC_RES_RESPONSE_TOO_BIG = 14    /* Response was too big to handle */
+	EC_RES_RESPONSE_TOO_BIG = 14,   /* Response was too big to handle */
+	EC_RES_BUS_ERROR = 15,		/* Communications bus error */
+	EC_RES_BUSY = 16,		/* Up but too busy.  Should retry */
+	EC_RES_INVALID_HEADER_VERSION = 17,  /* Header version invalid */
+	EC_RES_INVALID_HEADER_CRC = 18,      /* Header CRC invalid */
+	EC_RES_INVALID_DATA_CRC = 19,        /* Data CRC invalid */
+	EC_RES_DUP_UNAVAILABLE = 20,         /* Can't resend response */
 };
 
 /*
@@ -744,6 +753,136 @@ struct ec_host_response {
 	uint16_t reserved;
 } __ec_align4;
 
+/*****************************************************************************/
+
+/*
+ * Host command protocol V4.
+ *
+ * Packets always start with a request or response header.  They are followed
+ * by data_len bytes of data.  If the data_crc_present flag is set, the data
+ * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * polynomial.
+ *
+ * Host algorithm when sending a request q:
+ *
+ * 101) tries_left=(some value, e.g. 3);
+ * 102) q.seq_num++
+ * 103) q.seq_dup=0
+ * 104) Calculate q.header_crc.
+ * 105) Send request q to EC.
+ * 106) Wait for response r.  Go to 201 if received or 301 if timeout.
+ *
+ * 201) If r.struct_version != 4, go to 301.
+ * 202) If r.header_crc mismatches calculated CRC for r header, go to 301.
+ * 203) If r.data_crc_present and r.data_crc mismatches, go to 301.
+ * 204) If r.seq_num != q.seq_num, go to 301.
+ * 205) If r.seq_dup == q.seq_dup, return success.
+ * 207) If r.seq_dup == 1, go to 301.
+ * 208) Return error.
+ *
+ * 301) If --tries_left <= 0, return error.
+ * 302) If q.seq_dup == 1, go to 105.
+ * 303) q.seq_dup = 1
+ * 304) Go to 104.
+ *
+ * EC algorithm when receiving a request q.
+ * EC has response buffer r, error buffer e.
+ *
+ * 101) If q.struct_version != 4, set e.result = EC_RES_INVALID_HEADER_VERSION
+ *      and go to 301
+ * 102) If q.header_crc mismatches calculated CRC, set e.result =
+ *      EC_RES_INVALID_HEADER_CRC and go to 301
+ * 103) If q.data_crc_present, calculate data CRC.  If that mismatches the CRC
+ *      byte at the end of the packet, set e.result = EC_RES_INVALID_DATA_CRC
+ *      and go to 301.
+ * 104) If q.seq_dup == 0, go to 201.
+ * 105) If q.seq_num != r.seq_num, go to 201.
+ * 106) If q.seq_dup == r.seq_dup, go to 205, else go to 203.
+ *
+ * 201) Process request q into response r.
+ * 202) r.seq_num = q.seq_num
+ * 203) r.seq_dup = q.seq_dup
+ * 204) Calculate r.header_crc
+ * 205) If r.data_len > 0 and data is no longer available, set e.result =
+ *      EC_RES_DUP_UNAVAILABLE and go to 301.
+ * 206) Send response r.
+ *
+ * 301) e.seq_num = q.seq_num
+ * 302) e.seq_dup = q.seq_dup
+ * 303) Calculate e.header_crc.
+ * 304) Send error response e.
+ */
+
+/* Version 4 request from host */
+struct ec_host_request4 {
+	/*
+	 * bits 0-3: struct_version: Structure version (=4)
+	 * bit    4: is_response: Is response (=0)
+	 * bits 5-6: seq_num: Sequence number
+	 * bit    7: seq_dup: Sequence duplicate flag
+	 */
+	uint8_t fields0;
+
+	/*
+	 * bits 0-4: command_version: Command version
+	 * bits 5-6: Reserved (set 0, ignore on read)
+	 * bit    7: data_crc_present: Is data CRC present after data
+	 */
+	uint8_t fields1;
+
+	/* Command code (EC_CMD_*) */
+	uint16_t command;
+
+	/* Length of data which follows this header (not including data CRC) */
+	uint16_t data_len;
+
+	/* Reserved (set 0, ignore on read) */
+	uint8_t reserved;
+
+	/* CRC-8 of above fields, using x^8 + x^2 + x + 1 polynomial */
+	uint8_t header_crc;
+} __ec_align4;
+
+/* Version 4 response from EC */
+struct ec_host_response4 {
+	/*
+	 * bits 0-3: struct_version: Structure version (=4)
+	 * bit    4: is_response: Is response (=1)
+	 * bits 5-6: seq_num: Sequence number
+	 * bit    7: seq_dup: Sequence duplicate flag
+	 */
+	uint8_t fields0;
+
+	/*
+	 * bits 0-6: Reserved (set 0, ignore on read)
+	 * bit    7: data_crc_present: Is data CRC present after data
+	 */
+	uint8_t fields1;
+
+	/* Result code (EC_RES_*) */
+	uint16_t result;
+
+	/* Length of data which follows this header (not including data CRC) */
+	uint16_t data_len;
+
+	/* Reserved (set 0, ignore on read) */
+	uint8_t reserved;
+
+	/* CRC-8 of above fields, using x^8 + x^2 + x + 1 polynomial */
+	uint8_t header_crc;
+} __ec_align4;
+
+/* Fields in fields0 byte */
+#define EC_PACKET4_0_STRUCT_VERSION_MASK	0x0f
+#define EC_PACKET4_0_IS_RESPONSE_MASK		0x10
+#define EC_PACKET4_0_SEQ_NUM_SHIFT		5
+#define EC_PACKET4_0_SEQ_NUM_MASK		0x60
+#define EC_PACKET4_0_SEQ_DUP_MASK		0x80
+
+/* Fields in fields1 byte */
+#define EC_PACKET4_1_COMMAND_VERSION_MASK	0x1f  /* (request only) */
+#define EC_PACKET4_1_DATA_CRC_PRESENT_MASK	0x80
+
 /*****************************************************************************/
 /*
  * Notes on commands:
-- 
2.21.0.1020.gf2820cf01a-goog
