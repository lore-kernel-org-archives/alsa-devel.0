From: John Rigg <ad@sound-man.co.uk>
Subject: alsa-utils-1.0.10rc2 compile failure
Date: Sun, 06 Nov 2005 16:05:33 +0000
Message-ID: <E1EYn1R-0001GR-2H@localhost.localdomain>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just tried compiling alsa-utils-1.0.10rc2 and it failed with the following 
error:

make[2]: Entering directory `/home/jqr/alsa-1.0.10/alsa-utils-1.0.10rc2/alsaconf/po'
mv: cannot stat `t-ja.gmo': No such file or directory
make[2]: *** [ja.gmo] Error 1

I tried again with --disable-nls and it got further but failed here:

aplay.c: In function 'main':
aplay.c:365: error: 'LC_ALL' undeclared (first use in this function)
aplay.c:365: error: (Each undeclared identifier is reported only once
aplay.c:365: error: for each function it appears in.)
aplay.c: In function 'voc_pcm_write':
aplay.c:1335: warning: pointer targets in passing argument 1 of 'pcm_write' differ in signedness
aplay.c: In function 'voc_write_silence':
aplay.c:1358: warning: pointer targets in passing argument 1 of 'voc_pcm_write' differ in signedness
aplay.c: In function 'voc_pcm_flush':
aplay.c:1378: warning: pointer targets in passing argument 1 of 'pcm_write' differ in signedness
aplay.c: In function 'playback_go':
aplay.c:1875: warning: pointer targets in passing argument 1 of 'pcm_write' differ in signedness
aplay.c:1904: warning: pointer targets in passing argument 1 of 'pcm_write' differ in signedness
aplay.c: In function 'capture_go':
aplay.c:1929: warning: pointer targets in passing argument 1 of 'pcm_read' differ in signedness
aplay.c: In function 'playbackv_go':
aplay.c:2047: warning: pointer targets in assignment differ in signedness
aplay.c: In function 'capturev_go':
aplay.c:2094: warning: pointer targets in assignment differ in signedness
make[1]: *** [aplay.o] Error 1
make[1]: Leaving directory `/home/jqr/alsa-1.0.10/alsa-utils-1.0.10rc2/aplay'
make: *** [all-recursive] Error 1

System is Debian unstable amd64, gcc-4.0_4.0.2-2.
Any ideas why this is happening?

John


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
