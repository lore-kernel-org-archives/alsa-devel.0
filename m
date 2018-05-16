From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] slimbus: messaging: initialize completion correctly
Date: Wed, 16 May 2018 12:36:42 +0100
Message-ID: <20180516113642.28136-8-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

slim_val_inf can contain random value from stack, make sure the completion
is initialized to NULL while filling the msg.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index fd0788019357..2635eaaadf4a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -277,6 +277,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2
