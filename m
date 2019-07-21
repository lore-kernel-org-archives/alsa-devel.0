From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] slimbus: fix duplicated argument to ||
Date: Sun, 21 Jul 2019 23:17:15 +0530
Message-ID: <20190721174715.GA10747@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove duplicate argument SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION.

fix below issue reported by coccicheck
./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/slimbus/slimbus.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 9be4108..46a6441 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -438,8 +438,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
 	return (mt == SLIM_MSG_MT_CORE &&
 		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
 		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
-		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
-		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
+		 mc == SLIM_MSG_MC_REQUEST_VALUE));
 }
 
 static inline bool slim_ec_txn(u8 mt, u8 mc)
-- 
2.7.4
