From: Andrei Boros <andrei@srr.ro>
Subject: alsa-utils cvscompile
Date: Mon, 22 Sep 2003 12:13:05 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6EBD21.385BE9EA@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

 
 alsa-utils fails to compile to compile with the following :

make  all-am
make[2]: Entering directory `/serve/install/alsa-cvs/alsa-utils/include'
make[2]: Leaving directory `/serve/install/alsa-cvs/alsa-utils/include'
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-utils/include'
Making all in alsactl
make[1]: Entering directory `/serve/install/alsa-cvs/alsa-utils/alsactl'
source='alsactl.c' object='alsactl.o' libtool=no \
depfile='.deps/alsactl.Po' tmpdepfile='.deps/alsactl.TPo' \
depmode=none /bin/sh ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I. -I../include     -O2 -Wall -pipe -g -c `test
-f alsactl.c || echo './'`alsactl.c
gcc  -O2 -Wall -pipe -g   -o alsactl  alsactl.o  -lasound -lm -ldl
-lpthread
gcc: alsactl.o: No such file or directory
make[1]: *** [alsactl] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-utils/alsactl'
make: *** [all-recursive] Error 1



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
