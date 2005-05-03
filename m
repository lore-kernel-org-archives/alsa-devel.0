From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] compiling problem fixed
Date: Tue, 3 May 2005 16:29:16 +0200
Message-ID: <20050503142916.GA3281@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This fixes a 2.4 compiling problem on alpha. GFP_KERNEL was undeclared.

Signed-Off-by: Martin Langer <martin-langer@gmx.de>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="adriver.patch"

--- include/adriver.h.ORIGINAL	2005-05-03 15:57:09.000000000 +0200
+++ include/adriver.h	2005-05-03 16:09:16.000000000 +0200
@@ -23,6 +23,7 @@
  */
 
 #include <linux/version.h>
+#include <linux/slab.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 2, 3)
 #error "This driver requires Linux 2.2.3 or higher."

--ReaqsoxgOBHFXBhH--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
