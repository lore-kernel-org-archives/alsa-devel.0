From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] fix broken compilation of sound/core/init.c
Date: Wed, 13 Nov 2002 09:46:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2fzu5uaab.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

sound/core/init.c needs linux/ctype.h for isalnum ... :

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa-compile.diff

--- ./sound/core/init.c.tv	2002-11-12 22:55:18.000000000 -0500
+++ ./sound/core/init.c	2002-11-12 22:59:04.000000000 -0500
@@ -27,6 +27,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <linux/ctype.h>
 
 int snd_cards_count = 0;
 static unsigned int snd_cards_lock = 0;	/* locked for registering/using */

--=-=-=


(patch against 2.5.47-bk1)

--=-=-=--



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
