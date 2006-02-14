From: Giuliano Pochini <pochini@shiny.it>
Subject: powermac driver doesn't compile
Date: Tue, 14 Feb 2006 22:38:23 +0100
Message-ID: <20060214223823.4d43c843.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


2.6.16rc3 + latest CVS alsa-driver.

  CC [M]  /home/giu/ttttttttttt/alsa-driver/ppc/pmac.o
In file included from /home/giu/ttttttttttt/alsa-driver/ppc/pmac.c:6:
/home/giu/ttttttttttt/alsa-driver/ppc/pmac_old.c: In function `snd_pmac_free':
/home/giu/ttttttttttt/alsa-driver/ppc/pmac_old.c:827: error: structure has no member named `of_requested'
/home/giu/ttttttttttt/alsa-driver/ppc/pmac_old.c: In function `snd_pmac_new':
/home/giu/ttttttttttt/alsa-driver/ppc/pmac_old.c:1207: error: structure has no member named `of_requested'
/home/giu/ttttttttttt/alsa-driver/ppc/pmac_old.c:1228: error: structure has no member named `of_requested'
make[3]: *** [/home/giu/ttttttttttt/alsa-driver/ppc/pmac.o] Error 1


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
