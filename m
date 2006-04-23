From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] snd-miro include fix
Date: Sun, 23 Apr 2006 18:01:29 +0200
Message-ID: <20060423160129.GA4036@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id AA52D190
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 18:00:26 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1FXh1d-00013z-CY
	for alsa-devel@alsa-project.org; Sun, 23 Apr 2006 18:01:29 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

snd-miro isn't based on opti92x-ad1848.c. This patch fixes it by 
changing an include line.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro.diff"

--- ../alsa-driver-1.0.11/isa/opti9xx/miro.c	Sun Apr 23 19:33:21 2006
+++ isa/opti9xx/miro.c	Sun Apr 23 19:44:20 2006
@@ -1,6 +1,6 @@
 #include <linux/version.h>
 
-#include "../../alsa-kernel/isa/opti9xx/opti92x-ad1848.c"
+#include "../../alsa-kernel/isa/opti9xx/miro.c"
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #ifndef __isapnp_now__
 #include "miro.isapnp"

--KsGdsel6WgEHnImy--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
