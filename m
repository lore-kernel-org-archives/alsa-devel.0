From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 17/30] mfd: cros_ec: Add fingerprint API
Date: Fri,  3 May 2019 15:02:20 -0700
Message-ID: <20190503220233.64546-18-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA52BF8973F
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2019 00:03:12 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id u17so3534740pfn.7
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2019 15:03:12 -0700 (PDT)
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

Add support for fingerprint sensors managed by embedded controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 2d59b4480876..399fedebc388 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3339,6 +3339,40 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
+#define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
+#define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
+#define EC_MKBP_FP_ENROLL_PROGRESS_OFFSET 4
+#define EC_MKBP_FP_ENROLL_PROGRESS(fpe) (((fpe) & 0x00000FF0) \
+					 >> EC_MKBP_FP_ENROLL_PROGRESS_OFFSET)
+#define EC_MKBP_FP_MATCH_IDX_OFFSET 12
+#define EC_MKBP_FP_MATCH_IDX_MASK 0x0000F000
+#define EC_MKBP_FP_MATCH_IDX(fpe) (((fpe) & EC_MKBP_FP_MATCH_IDX_MASK) \
+					 >> EC_MKBP_FP_MATCH_IDX_OFFSET)
+#define EC_MKBP_FP_ENROLL               BIT(27)
+#define EC_MKBP_FP_MATCH                BIT(28)
+#define EC_MKBP_FP_FINGER_DOWN          BIT(29)
+#define EC_MKBP_FP_FINGER_UP            BIT(30)
+#define EC_MKBP_FP_IMAGE_READY          BIT(31)
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_ENROLL is set */
+#define EC_MKBP_FP_ERR_ENROLL_OK               0
+#define EC_MKBP_FP_ERR_ENROLL_LOW_QUALITY      1
+#define EC_MKBP_FP_ERR_ENROLL_IMMOBILE         2
+#define EC_MKBP_FP_ERR_ENROLL_LOW_COVERAGE     3
+#define EC_MKBP_FP_ERR_ENROLL_INTERNAL         5
+/* Can be used to detect if image was usable for enrollment or not. */
+#define EC_MKBP_FP_ERR_ENROLL_PROBLEM_MASK     1
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_MATCH is set */
+#define EC_MKBP_FP_ERR_MATCH_NO                0
+#define EC_MKBP_FP_ERR_MATCH_NO_INTERNAL       6
+#define EC_MKBP_FP_ERR_MATCH_NO_TEMPLATES      7
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_QUALITY    2
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_COVERAGE   4
+#define EC_MKBP_FP_ERR_MATCH_YES               1
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATED       3
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATE_FAILED 5
+
+
 /*****************************************************************************/
 /* Temperature sensor commands */
 
-- 
2.21.0.1020.gf2820cf01a-goog
