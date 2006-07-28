From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] Makefile cleanup
Date: Fri, 28 Jul 2006 19:59:38 +0200
Message-ID: <20060728175938.GA4072@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Let's remove an miro dependency from alsa-driver, because miro is a part 
of alsa-kernel now.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--- alsa-driver/isa/cs423x/Makefile.ORIGINAL	2006-07-28 19:41:16.000000000 +0200
+++ alsa-driver/isa/cs423x/Makefile	2006-07-28 19:41:31.000000000 +0200
@@ -13,6 +13,5 @@
 
 snd-pc98-cs4232-objs := pc98.o
 obj-$(CONFIG_SND_PC98_CS4232) += snd-pc98-cs4232.o snd-cs4231-lib.o
-obj-$(CONFIG_SND_MIRO) += snd-cs4231-lib.o
 
 include $(SND_TOPDIR)/Rules.make


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
