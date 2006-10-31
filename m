From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] Fix mask to stop AT91 SSC clock on shutdown
Date: Tue, 31 Oct 2006 13:16:51 +0000
Message-ID: <1162300611.15041.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TGWKhZ2CkgoFnJqBz7AU"
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


--=-TGWKhZ2CkgoFnJqBz7AU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Frank Mandarino and Hubert Kahlert fixes a bug in the AT91
SSC (i2s) shutdown code that would erroneously disable other AT91
peripheral clocks.  

Signed-off-by: Hubert Kahlert <hkahlert@hk-datentechnik.de>
Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
 

--=-TGWKhZ2CkgoFnJqBz7AU
Content-Disposition: attachment; filename=asoc-at91-sscclock.patch
Content-Type: text/x-patch; name=asoc-at91-sscclock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# HG changeset patch
# User fam@star4.sky.endrelia.com
# Date 1161951244 14400
# Node ID a8c5e404fd61fd6844b94d36efe544bec03d0b68
# Parent  24b6b107f951ce9198caaa99731dd0a9fbd08488
Fixed mask to stop SSC clock on shutdown.

Current code will stop other clocks, such as AIC and PIO, depending
on the SSC used.  Reported by Hubert Kahlert.

diff -r 24b6b107f951 -r a8c5e404fd61 soc/at91/at91rm9200-i2s.c
--- a/soc/at91/at91rm9200-i2s.c	Fri Oct 27 10:45:00 2006 +0200
+++ b/soc/at91/at91rm9200-i2s.c	Fri Oct 27 08:14:04 2006 -0400
@@ -373,7 +373,7 @@ static void at91rm9200_i2s_shutdown(stru
 	if (!ssc_p->dir_mask) {
 		/* Shutdown the SSC clock. */
 		DBG("Stopping pid %d clock\n", ssc_p->pid);
-		at91_sys_write(AT91_PMC_PCDR, ssc_p->pid);
+		at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->pid);
 
 		if (ssc_p->initialized)
 			free_irq(ssc_p->pid, ssc_p);

--=-TGWKhZ2CkgoFnJqBz7AU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-TGWKhZ2CkgoFnJqBz7AU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-TGWKhZ2CkgoFnJqBz7AU--
