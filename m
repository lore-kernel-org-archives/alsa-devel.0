From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: question about implicit decl in pcm_direct.c
Date: Mon, 08 Jan 2007 15:41:21 +0100
Message-ID: <45A25811.7040603@purplelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060705010102010905090707"
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
--------------060705010102010905090707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

when compiling, i got:

pcm_direct.c:898: warning: implicit declaration of function
`snd_pcm_hw_params_set_format_first'
I don't know how to fix it properly, so i ask if someone knows :)

there is also another warning about a comparison between int and
unsigned int that i "fixed" like in the attached patch.

Cheers,

Ben


--------------060705010102010905090707
Content-Type: text/plain;
 name="pcm_direct.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_direct.c.diff"

diff -r 8803655da809 src/pcm/pcm_direct.c
--- a/src/pcm/pcm_direct.c	Mon Jan  8 15:07:02 2007 +0100
+++ b/src/pcm/pcm_direct.c	Mon Jan  8 15:40:18 2007 +0100
@@ -887,7 +887,7 @@ int snd_pcm_direct_initialize_slave(snd_
 		snd_pcm_format_t format;
 		int i;
 
-		for (i = 0; i < sizeof dmix_formats / sizeof dmix_formats[0]; ++i) {
+		for (i = 0; i < (int)(sizeof dmix_formats / sizeof dmix_formats[0]); ++i) {
 			format = dmix_formats[i];
 			ret = snd_pcm_hw_params_set_format(spcm, hw_params, format);
 			if (ret >= 0)

--------------060705010102010905090707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------060705010102010905090707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------060705010102010905090707--
