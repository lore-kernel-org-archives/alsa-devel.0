From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 10/14] soundwire: avoid multiple assignments
Date: Thu,  2 May 2019 16:29:26 +0530
Message-ID: <20190502105930.9889-11-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E497F89744
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:38 +0200 (CEST)
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Modify the code to avoid multiple assignments by assigning to variable
after error checks in soundwire bus.

CHECK: multiple assignments should be avoided

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 16b2a3b2662d..aac35fc3cf22 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -812,12 +812,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
 	/* Read Instat 1, Instat 2 and Instat 3 registers */
-	buf = ret = sdw_read(slave, SDW_SCP_INT1);
+	ret = sdw_read(slave, SDW_SCP_INT1);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INT1 read failed:%d\n", ret);
 		return ret;
 	}
+	buf = ret;
 
 	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
@@ -910,12 +911,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * Read status again to ensure no new interrupts arrived
 		 * while servicing interrupts.
 		 */
-		_buf = ret = sdw_read(slave, SDW_SCP_INT1);
+		ret = sdw_read(slave, SDW_SCP_INT1);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT1 read failed:%d\n", ret);
 			return ret;
 		}
+		_buf = ret;
 
 		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
-- 
2.20.1
