From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 8/19] ASoC 0.13 AT91xxxx slave patch
Date: Fri, 02 Feb 2007 14:44:48 +0000
Message-ID: <1170427488.18082.138.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-N/PC3GCk9IpyGVlIb5XK"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-N/PC3GCk9IpyGVlIb5XK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds support for I2S slave mode for the ETI_B1 machine from
Endrelia.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-N/PC3GCk9IpyGVlIb5XK
Content-Disposition: attachment; filename="asoc13-at91-kconfig-slave.patch"
Content-Type: text/x-patch; name="asoc13-at91-kconfig-slave.patch";
	charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/at91/Kconfig
--- a/soc/at91/Kconfig	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/at91/Kconfig	Wed Jan 31 16:43:17 2007 +0000
@@ -13,12 +13,20 @@ config SND_AT91_SOC_I2S
 	tristate
 
 config SND_AT91_SOC_ETI_B1_WM8731
-	tristate "SoC I2S Audio support for Endrelia ETI-B1 board"
-	depends on SND_AT91_SOC && MACH_ETI_B1
+	tristate "SoC I2S Audio support for WM8731-based Endrelia ETI-B1 boards"
+	depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
 	select SND_AT91_SOC_I2S
 	select SND_SOC_WM8731
 	help
-	  Say Y if you want to add support for SoC audio on Endrelia
-          ETI-B1 board.
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.
+
+config SND_AT91_SOC_ETI_SLAVE
+	bool "Run codec in slave Mode on Endrelia boards"
+	depends on SND_AT91_SOC_ETI_B1_WM8731
+	default n
+	help
+	  Say Y if you want to run with the AT91 SSC generating the BCLK
+	  and LRC signals on Endrelia boards.
 
 endmenu

--=-N/PC3GCk9IpyGVlIb5XK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-N/PC3GCk9IpyGVlIb5XK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-N/PC3GCk9IpyGVlIb5XK--
