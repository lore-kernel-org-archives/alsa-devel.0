From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] soundwire: Fix typo in return value
	check of sdw_read()
Date: Tue, 2 Jan 2018 04:08:19 +0000
Message-ID: <1514866099-108711-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (unknown [45.249.212.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF98266FDE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 05:02:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix the typo, 'status' should be instead of 'status2'.

Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soundwire/bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4c34519..266d2b3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -671,8 +671,8 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		status2 = sdw_read(slave, SDW_DP0_INT);
 		if (status2 < 0) {
 			dev_err(slave->bus->dev,
-				"SDW_DP0_INT read failed:%d", status);
-			return status;
+				"SDW_DP0_INT read failed:%d", status2);
+			return status2;
 		}
 		status &= status2;
 
@@ -741,10 +741,10 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 
 		/* Read DPN interrupt again */
 		status2 = sdw_read(slave, addr);
-		if (status < 0) {
+		if (status2 < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_DPN_INT read failed:%d", status);
-			return status;
+					"SDW_DPN_INT read failed:%d", status2);
+			return status2;
 		}
 		status &= status2;
