From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: stream: fix bad unlock balance
Date: Wed, 22 May 2019 17:25:28 +0100
Message-ID: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes below warning due to unlocking without locking.

 =====================================
 WARNING: bad unlock balance detected!
 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
 -------------------------------------
 aplay/2954 is trying to release lock (&bus->msg_lock) at:
 do_bank_switch+0x21c/0x480
 but there are no more locks to release!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 544925ff0b40..d16268f30e4f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			goto error;
 		}
 
-		mutex_unlock(&bus->msg_lock);
+		if (mutex_is_locked(&bus->msg_lock))
+			utex_unlock(&bus->msg_lock);
 	}
 
 	return ret;
-- 
2.21.0
