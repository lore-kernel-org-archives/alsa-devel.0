From: srinivas.kandagatla@linaro.org
Subject: [PATCH 2/6] slimbus: fix retries comparison to correctly identify failed allocation
Date: Tue,  2 Jan 2018 17:54:20 +0000
Message-ID: <20180102175424.14391-3-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for too many retries fails because retries is actually
-1 when the retry loop terminates if no pbuf can be allocated because of
the post decrement on retries.  Fix this by not comparing retries with zero
but instead check if it is negative.

Detected by CoverityScan, CID#1463143 ("Logically dead code") and
CID#1463144 ("Dereference after null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index fb1a5e0eb8dd..2d67419a3c37 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -345,7 +345,7 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 		}
 	}
 
-	if (!retries && !pbuf)
+	if (retries < 0 && !pbuf)
 		return -ENOMEM;
 
 	puc = (u8 *)pbuf;
-- 
2.15.0
