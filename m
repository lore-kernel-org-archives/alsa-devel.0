From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: core: add missing spin_lock_init on txn_lock
Date: Mon, 14 Jan 2019 13:44:49 +0000
Message-ID: <20190114134449.15367-5-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add missing spin lock intialization this also fixes the spinlock bad magic
warning.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 8ffdc9876223..b2f07d2043eb 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -274,6 +274,7 @@ int slim_register_controller(struct slim_controller *ctrl)
 	mutex_init(&ctrl->lock);
 	mutex_init(&ctrl->sched.m_reconf);
 	init_completion(&ctrl->sched.pause_comp);
+	spin_lock_init(&ctrl->txn_lock);
 
 	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
 		ctrl->name, ctrl->dev);
-- 
2.20.1
