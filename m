From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] slimbus: fix retries comparison to correctly identify failed allocation
Date: Fri, 22 Dec 2017 00:21:43 +0000
Message-ID: <20171222002143.10660-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for too many retries fails because retries is actually
-1 when the retry loop terminates if no pbuf can be allocated because of
the post decrement on retries.  Fix this by not comparing retries with zero
but instead check if it is negative.

Detected by CoverityScan, CID#1463143 ("Logically dead code") and
CID#1463144 ("Dereference after null check")

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/slimbus/qcom-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 35ad70dbfe3a..9b7846f1f8c3 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -347,7 +347,7 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 		}
 	}
 
-	if (!retries && !pbuf)
+	if (retries < 0 && !pbuf)
 		return -ENOMEM;
 
 	puc = (u8 *)pbuf;
-- 
2.14.1

