From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] soundwire: Fix a signedness bug
Date: Tue, 9 Jan 2018 12:37:00 +0300
Message-ID: <20180109093700.7275ardpus7g6rkq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D30726717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:37:17 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"ret" is an int and "buf" is a u8.  sdw_read() returns negative error
codes which are truncated to the u8, 0-255 range before being stored as
an int.  It means that "ret" can't be less than zero.

Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4c345197eb55..ac88031f7664 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -771,12 +771,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
 	/* Read Instat 1, Instat 2 and Instat 3 registers */
-	ret = buf = sdw_read(slave, SDW_SCP_INT1);
+	ret = sdw_read(slave, SDW_SCP_INT1);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 					"SDW_SCP_INT1 read failed:%d", ret);
 		return ret;
 	}
+	buf = ret;
 
 	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
@@ -870,12 +871,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * Read status again to ensure no new interrupts arrived
 		 * while servicing interrupts.
 		 */
-		ret = _buf = sdw_read(slave, SDW_SCP_INT1);
+		ret = sdw_read(slave, SDW_SCP_INT1);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 					"SDW_SCP_INT1 read failed:%d", ret);
 			return ret;
 		}
+		_buf = ret;
 
 		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
