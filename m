From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, add missing module_param's
Date: Wed, 12 Apr 2006 21:56:52 +0200
Message-ID: <20060412215652.4b17d18c.pochini@shiny.it>
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


Add missing module_param's.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	2006-02-23 22:41:31.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio.c	2006-04-12 21:37:06.000000000 +0200
@@ -26,6 +26,13 @@ static int index[SNDRV_CARDS] = SNDRV_DE
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " ECHOCARD_NAME " soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " ECHOCARD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " ECHOCARD_NAME " soundcard.");
+
 static unsigned int channels_list[10] = {1, 2, 4, 6, 8, 10, 12, 14, 16, 999999};
 
 

--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
