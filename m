From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] cvs doesn't compile atm
Date: Thu, 5 Dec 2002 18:38:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021205173800.GA773@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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



There's a problem with cvs. it doesn't compile atm. this patch fixes the typo.

martin



--- alsa-driver/Makefile.ORIGINAL	Thu Dec  5 18:30:12 2002
+++ alsa-driver/Makefile	Thu Dec  5 18:30:35 2002
@@ -152,7 +152,7 @@
 	elif [ -d /etc/rc.d/init.d ]; then \
 	  install -m 755 -g $(IGROUP) -o $(IUSER) utils/alsasound $(DESTDIR)/etc/rc.d/init.d/alsasound; \
 	elif [ -d /etc/init.d ]; then \
-	  install -m 755 -g $(UGROUP) -o $(IUSER) utils/alsasound $(DESTDIR)/etc/init.d/alsasound; \
+	  install -m 755 -g $(IGROUP) -o $(IUSER) utils/alsasound $(DESTDIR)/etc/init.d/alsasound; \
 	fi
 
 .PHONY: check-snd-prefix


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
