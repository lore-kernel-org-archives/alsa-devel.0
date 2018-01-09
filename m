From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] soundwire: Testing the wrong variable
Date: Tue, 9 Jan 2018 12:37:44 +0300
Message-ID: <20180109093744.egp4vynjgghidp6i@mwanda>
References: <20180109093700.7275ardpus7g6rkq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 63BC226717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:37:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180109093700.7275ardpus7g6rkq@mwanda>
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

We should be using "status2" here instead of "status".

Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ac88031f7664..a5d41a4a1609 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
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
 
