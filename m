From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 25/30] mfd: cros_ec: Add API for Touchpad
	support
Date: Fri,  3 May 2019 15:02:28 -0700
Message-ID: <20190503220233.64546-26-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EECBF8973B
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2019 00:03:25 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id t22so3332875pgi.10
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2019 15:03:25 -0700 (PDT)
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

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 52fd9bfafc7f..1d0311df44d3 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* Touchpad MCU commands: range 0x0500-0x05FF */
+
+/* Perform touchpad self test */
+#define EC_CMD_TP_SELF_TEST 0x0500
+
+/* Get number of frame types, and the size of each type */
+#define EC_CMD_TP_FRAME_INFO 0x0501
+
+struct ec_response_tp_frame_info {
+	uint32_t n_frames;
+	uint32_t frame_sizes[0];
+} __ec_align4;
+
+/* Create a snapshot of current frame readings */
+#define EC_CMD_TP_FRAME_SNAPSHOT 0x0502
+
+/* Read the frame */
+#define EC_CMD_TP_FRAME_GET 0x0503
+
+struct ec_params_tp_frame_get {
+	uint32_t frame_index;
+	uint32_t offset;
+	uint32_t size;
+} __ec_align4;
+
 /*****************************************************************************/
 /* EC-EC communication commands: range 0x0600-0x06FF */
 
-- 
2.21.0.1020.gf2820cf01a-goog
