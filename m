From: Lee Revell <rlrevell@joe-job.com>
Subject: alsa-lib won't compile from CVS
Date: Fri, 25 Feb 2005 19:09:58 -0500
Message-ID: <1109376598.14434.13.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YrPgwoWtcA5TFp3ltToB"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-YrPgwoWtcA5TFp3ltToB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I get this error when I run ./cvscompile:

config.status: creating src/ordinary_mixer/Makefile
config.status: creating src/pcm/Makefile
config.status: error: cannot find input file: src/pcm/ext/Makefile.in

In fact src/pcm/ext is empty.

This patch fixes it.

Lee



--=-YrPgwoWtcA5TFp3ltToB
Content-Disposition: attachment; filename=alsa-lib-fix.patch
Content-Type: text/x-patch; name=alsa-lib-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-pre1.0.9/alsa-lib/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/configure.in,v
retrieving revision 1.143
diff -u -r1.143 configure.in
--- alsa-pre1.0.9/alsa-lib/configure.in	14 Feb 2005 13:52:00 -0000	1.143
+++ alsa-pre1.0.9/alsa-lib/configure.in	26 Feb 2005 00:07:49 -0000
@@ -203,7 +203,7 @@
 AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile include/Makefile
 	  include/sound/Makefile src/Makefile \
           src/control/Makefile src/mixer/Makefile src/ordinary_mixer/Makefile \
-	  src/pcm/Makefile src/pcm/ext/Makefile src/pcm/scopes/Makefile src/ordinary_pcm/Makefile \
+	  src/pcm/Makefile src/pcm/scopes/Makefile src/ordinary_pcm/Makefile \
 	  src/rawmidi/Makefile src/timer/Makefile \
           src/hwdep/Makefile src/seq/Makefile src/instr/Makefile \
           src/compat/Makefile src/alisp/Makefile src/conf/Makefile \

--=-YrPgwoWtcA5TFp3ltToB--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
