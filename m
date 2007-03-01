From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/2] Echoaudio,
 add support for new revisions of Indigo's and Mia cards
Date: Fri, 2 Mar 2007 00:29:42 +0100
Message-ID: <20070302002942.4b38334e.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


The new ASIC code needs more time to set up.


diff -dup alsa-kernel__orig/pci/echoaudio/echoaudio_3g.c alsa-kernel/pci/echoaudio/echoaudio_3g.c
--- alsa-kernel__orig/pci/echoaudio/echoaudio_3g.c	2006-08-30 22:40:05.000000000 +0200
+++ alsa-kernel/pci/echoaudio/echoaudio_3g.c	2007-02-22 22:50:27.000000000 +0100
@@ -233,8 +233,8 @@ static int load_asic(struct echoaudio *c
 
 	chip->asic_code = &card_fw[FW_3G_ASIC];
 
-	/* Now give the new ASIC a little time to set up */
-	mdelay(2);
+	/* Now give the new ASIC some time to set up */
+	msleep(1000);
 	/* See if it worked */
 	box_type = check_asic_status(chip);
 



(Note: the driver still works fine with the old firmware after this change.
The opposite is not true.)


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
