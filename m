From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] ac97_bus power management
Date: Fri, 2 Feb 2007 22:44:37 +0100
Message-ID: <20070202214436.GA3607@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0C0FC26F
	for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2007 22:44:38 +0100 (MET)
Received: from ml by tuba with local (Exim 4.50) id 1HD6Cz-0000ws-3j
	for alsa-devel@alsa-project.org; Fri, 02 Feb 2007 22:44:37 +0100
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Any reason why ac97_bus.c comes without CONFIG_PM?
This patch adds CONFIG_PM to the ac97_bus driver.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--- ../alsa-driver-1.0.14rc2-original/alsa-kernel/ac97_bus.c	2007-01-15 14:25:18.000000000 +0100
+++ alsa-kernel/ac97_bus.c	2007-02-02 21:39:47.000000000 +0100
@@ -26,6 +26,7 @@
 	return 1;
 }
 
+#ifdef CONFIG_PM
 static int ac97_bus_suspend(struct device *dev, pm_message_t state)
 {
 	int ret = 0;
@@ -45,12 +46,15 @@
 
 	return ret;
 }
+#endif /* CONFIG_PM */
 
 struct bus_type ac97_bus_type = {
 	.name		= "ac97",
 	.match		= ac97_bus_match,
+#ifdef CONFIG_PM
 	.suspend	= ac97_bus_suspend,
 	.resume		= ac97_bus_resume,
+#endif /* CONFIG_PM */
 };
 
 static int __init ac97_bus_init(void)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
