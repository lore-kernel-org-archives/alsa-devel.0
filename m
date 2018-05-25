From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 5/8] slimbus: messaging: initialize completion correctly
Date: Fri, 25 May 2018 15:36:15 +0100
Message-ID: <20180525143618.820-6-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

slim_val_inf can contain random value from stack, make sure the completion
is initialized to NULL while filling the msg.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 1c57b631031a..e3605ed1c459 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -246,6 +246,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2
