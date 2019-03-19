From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] slimbus: ngd: Fix to avoid potential NULL pointer dereference
Date: Mon, 18 Mar 2019 20:25:23 -0500
Message-ID: <20190319012523.14644-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In of_qcom_slim_ngd_register, of_match_node may fail and return a NULL
pointer. This patch avoids such a scenario leading to NULL pointer
dereference.

Fixes: 458a445deb9c ("slimbus: ngd: Fix build error on x86")
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..9cc7256028c9 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1332,6 +1332,8 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	u32 id;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
+	if (!match)
+		return -ENXIO;
 	data = match->data;
 	for_each_available_child_of_node(parent->of_node, node) {
 		if (of_property_read_u32(node, "reg", &id))
-- 
2.17.1
