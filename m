From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 29/30] mfd: cros_ec: Add Management API
	entry points
Date: Fri,  3 May 2019 15:02:32 -0700
Message-ID: <20190503220233.64546-30-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 928DAF8975E
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2019 00:03:31 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id 13so3227593pfw.9
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2019 15:03:31 -0700 (PDT)
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add commands for test and management.
Add command space for future development.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 113 +++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 860a76274334..fc8babce1576 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5176,6 +5176,119 @@ struct ec_params_set_cbi {
 	uint8_t data[];		/* For string and raw data */
 } __ec_align1;
 
+/*
+ * Information about resets of the AP by the EC and the EC's own uptime.
+ */
+#define EC_CMD_GET_UPTIME_INFO 0x0121
+
+struct ec_response_uptime_info {
+	/*
+	 * Number of milliseconds since the last EC boot. Sysjump resets
+	 * typically do not restart the EC's time_since_boot epoch.
+	 *
+	 * WARNING: The EC's sense of time is much less accurate than the AP's
+	 * sense of time, in both phase and frequency.  This timebase is similar
+	 * to CLOCK_MONOTONIC_RAW, but with 1% or more frequency error.
+	 */
+	uint32_t time_since_ec_boot_ms;
+
+	/*
+	 * Number of times the AP was reset by the EC since the last EC boot.
+	 * Note that the AP may be held in reset by the EC during the initial
+	 * boot sequence, such that the very first AP boot may count as more
+	 * than one here.
+	 */
+	uint32_t ap_resets_since_ec_boot;
+
+	/*
+	 * The set of flags which describe the EC's most recent reset.  See
+	 * include/system.h RESET_FLAG_* for details.
+	 */
+	uint32_t ec_reset_flags;
+
+	/* Empty log entries have both the cause and timestamp set to zero. */
+	struct ap_reset_log_entry {
+		/*
+		 * See include/chipset.h: enum chipset_{reset,shutdown}_reason
+		 * for details.
+		 */
+		uint16_t reset_cause;
+
+		/* Reserved for protocol growth. */
+		uint16_t reserved;
+
+		/*
+		 * The time of the reset's assertion, in milliseconds since the
+		 * last EC boot, in the same epoch as time_since_ec_boot_ms.
+		 * Set to zero if the log entry is empty.
+		 */
+		uint32_t reset_time_ms;
+	} recent_ap_reset[4];
+} __ec_align4;
+
+/*
+ * Add entropy to the device secret (stored in the rollback region).
+ *
+ * Depending on the chip, the operation may take a long time (e.g. to erase
+ * flash), so the commands are asynchronous.
+ */
+#define EC_CMD_ADD_ENTROPY	0x0122
+
+enum add_entropy_action {
+	/* Add entropy to the current secret. */
+	ADD_ENTROPY_ASYNC = 0,
+	/*
+	 * Add entropy, and also make sure that the previous secret is erased.
+	 * (this can be implemented by adding entropy multiple times until
+	 * all rolback blocks have been overwritten).
+	 */
+	ADD_ENTROPY_RESET_ASYNC = 1,
+	/* Read back result from the previous operation. */
+	ADD_ENTROPY_GET_RESULT = 2,
+};
+
+struct ec_params_rollback_add_entropy {
+	uint8_t action;
+} __ec_align1;
+
+/*
+ * Perform a single read of a given ADC channel.
+ */
+#define EC_CMD_ADC_READ		0x0123
+
+struct ec_params_adc_read {
+	uint8_t adc_channel;
+} __ec_align1;
+
+struct ec_response_adc_read {
+	int32_t adc_value;
+} __ec_align4;
+
+/*
+ * Read back rollback info
+ */
+#define EC_CMD_ROLLBACK_INFO		0x0124
+
+struct ec_response_rollback_info {
+	int32_t id; /* Incrementing number to indicate which region to use. */
+	int32_t rollback_min_version;
+	int32_t rw_rollback_version;
+} __ec_align4;
+
+
+/* Issue AP reset */
+#define EC_CMD_AP_RESET 0x0125
+
+/*****************************************************************************/
+/* The command range 0x200-0x2FF is reserved for Rotor. */
+
+/*****************************************************************************/
+/*
+ * Reserve a range of host commands for the CR51 firmware.
+ */
+#define EC_CMD_CR51_BASE 0x0300
+#define EC_CMD_CR51_LAST 0x03FF
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.1020.gf2820cf01a-goog
