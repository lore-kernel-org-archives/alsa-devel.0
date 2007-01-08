From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: initialize dl handles where it needs to
Date: Mon, 08 Jan 2007 14:37:45 +0100
Message-ID: <45A24929.50500@purplelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020401070800040300090809"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020401070800040300090809
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this trivial patch initializes dl handle in timer.c and timer_query.c
where it needs to.

Signed-off-by: Benoit Fouet <benoit.fouet@purplelabs.com>



--------------020401070800040300090809
Content-Type: text/plain;
 name="dl_handle_init_diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dl_handle_init_diff"

diff -r b838a4b481c2 src/timer/timer.c
--- a/src/timer/timer.c Wed Dec 20 16:01:27 2006 +0100
+++ b/src/timer/timer.c Mon Jan  8 14:22:29 2007 +0100
@@ -92,7 +92,7 @@ static int snd_timer_open_conf(snd_timer
 #ifndef PIC
        extern void *snd_timer_open_symbols(void);
 #endif
-       void *h;
+       void *h = NULL;
        if (snd_config_get_type(timer_conf) != SND_CONFIG_TYPE_COMPOUND) {
                if (name)
                        SNDERR("Invalid type for TIMER %s definition", name);
diff -r b838a4b481c2 src/timer/timer_query.c
--- a/src/timer/timer_query.c   Wed Dec 20 16:01:27 2006 +0100
+++ b/src/timer/timer_query.c   Mon Jan  8 14:22:29 2007 +0100
@@ -50,7 +50,7 @@ static int snd_timer_query_open_conf(snd
 #ifndef PIC
        extern void *snd_timer_query_open_symbols(void);
 #endif
-       void *h;
+       void *h = NULL;
        if (snd_config_get_type(timer_conf) != SND_CONFIG_TYPE_COMPOUND) {
                if (name)
                        SNDERR("Invalid type for TIMER %s definition", name);

--------------020401070800040300090809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020401070800040300090809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020401070800040300090809--
