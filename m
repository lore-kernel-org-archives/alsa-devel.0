From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/i2c/cs8427.c: don't export a static
	function
Date: Fri, 30 Jun 2006 13:34:14 +0200
Message-ID: <20060630113414.GW19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D9FF629D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 13:34:14 +0200 (MEST)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Static functions shouldn't be exported.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/sound/i2c/cs8427.c.old	2006-06-30 04:24:28.000000000 +0200
+++ linux-2.6.17-mm4-full/sound/i2c/cs8427.c	2006-06-30 04:24:40.000000000 +0200
@@ -581,7 +581,6 @@
 module_exit(alsa_cs8427_module_exit)
 
 EXPORT_SYMBOL(snd_cs8427_create);
-EXPORT_SYMBOL(snd_cs8427_reset);
 EXPORT_SYMBOL(snd_cs8427_reg_write);
 EXPORT_SYMBOL(snd_cs8427_iec958_build);
 EXPORT_SYMBOL(snd_cs8427_iec958_active);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
