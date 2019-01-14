From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: core: do not call device_status under a lock
Date: Mon, 14 Jan 2019 13:44:47 +0000
Message-ID: <20190114134449.15367-3-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Calling device_status callback under a lock would prevent drivers
to do any slimbus trasactions which would invoke this lock like
get_laddr(). Remove this unnecessary lock!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 9e4f3b21ba8c..1ba08b5f2e78 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -466,6 +466,7 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 
 	sbdev->laddr = laddr;
 	sbdev->is_laddr_valid = true;
+	mutex_unlock(&ctrl->lock);
 
 	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_UP);
 
@@ -473,6 +474,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		laddr, sbdev->e_addr.manf_id, sbdev->e_addr.prod_code,
 		sbdev->e_addr.dev_index, sbdev->e_addr.instance);
 
+	return 0;
+
 err:
 	mutex_unlock(&ctrl->lock);
 	return ret;
-- 
2.20.1
