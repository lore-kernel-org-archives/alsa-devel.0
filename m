From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: PATCH: OPL3 playback on the CS4281
Date: Wed, 07 Aug 2002 15:07:13 +0200 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208071306.g77D6KwM016349@smtpzilla1.xs4all.nl>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Changelog:
- Added delays after writes. Without them, FM sounds really bad.

--- opl3_lib.c	Fri May 31 15:28:24 2002
+++ opl3_lib.cn	Wed Aug  7 15:04:16 2002
@@ -101,8 +101,10 @@
 	spin_lock_irqsave(&opl3->reg_lock, flags);
 
 	writel((unsigned int)cmd, port << 2);
+	udelay(10);
 
 	writel((unsigned int)val, (port + 1) << 2);
+	udelay(30);
 
 	spin_unlock_irqrestore(&opl3->reg_lock, flags);
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
