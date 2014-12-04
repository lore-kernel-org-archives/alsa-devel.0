From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 1/2] macintosh: therm_windtunnel: drop using
	attach adapter
Date: Thu,  4 Dec 2014 17:41:52 +0100
Message-ID: <1417711313-7257-2-git-send-email-wsa@the-dreams.de>
References: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 75CE7264ED4
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 17:42:16 +0100 (CET)
In-Reply-To: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: alsa-devel@alsa-project.org

As we now have deferred probing, we can use a custom mechanism and
finally get rid of the legacy interface from the i2c core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 3b4a157714b1..9de83cdd0bca 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -431,7 +431,6 @@ static struct i2c_driver g4fan_driver = {
 	.driver = {
 		.name	= "therm_windtunnel",
 	},
-	.attach_adapter = do_attach,
 	.probe		= do_probe,
 	.remove		= do_remove,
 	.id_table	= therm_windtunnel_id,
@@ -444,7 +443,29 @@ static struct i2c_driver g4fan_driver = {
 
 static int therm_of_probe(struct platform_device *dev)
 {
-	return i2c_add_driver( &g4fan_driver );
+	struct i2c_adapter *adap;
+	int ret, i = 0;
+
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	ret = i2c_add_driver(&g4fan_driver);
+	if (ret) {
+		i2c_put_adapter(adap);
+		return ret;
+	}
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		do_attach(adap);
+		if (x.running)
+			break;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return 0;
 }
 
 static int
-- 
2.1.3
