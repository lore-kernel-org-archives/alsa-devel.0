From: Lee Revell <rlrevell@joe-job.com>
Subject: alsa-tools: cvscompile fails at ./configure for qlo10k1
Date: Fri, 25 Mar 2005 21:53:57 -0500
Message-ID: <1111805637.24049.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

/usr/share/aclocal/glib.m4:8: warning: underquoted definition of AM_PATH_GLIB
/usr/share/aclocal/aalib.m4:12: warning: underquoted definition of AM_PATH_AALIB
/usr/share/aclocal/ORBit.m4:4: warning: underquoted definition of AM_PATH_ORBIT
aclocal:configure.in:12: warning: macro `AM_PATH_LD10K1' not found in library
/usr/share/aclocal/pkg.m4:5: warning: underquoted definition of PKG_CHECK_MODULES
  run info '(automake)Extending aclocal'
  or see http://sources.redhat.com/automake/automake.html#Extending-aclocal
/usr/share/aclocal/libart.m4:11: warning: underquoted definition of AM_PATH_LIBART
/usr/share/aclocal/libIDL.m4:6: warning: underquoted definition of AM_PATH_LIBIDL
/usr/share/aclocal/gtk.m4:7: warning: underquoted definition of AM_PATH_GTK
/usr/share/aclocal/glib.m4:8: warning: underquoted definition of AM_PATH_GLIB
/usr/share/aclocal/aalib.m4:12: warning: underquoted definition of AM_PATH_AALIB
/usr/share/aclocal/ORBit.m4:4: warning: underquoted definition of AM_PATH_ORBIT
aclocal:configure.in:12: warning: macro `AM_PATH_LD10K1' not found in library
configure.in:12: error: possibly undefined macro: AM_PATH_LD10K1
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
autoreconf: /usr/bin/autoconf failed with exit status: 1
CFLAGS=-O2 -Wall -pipe -g
./configure 
configure: error: cannot find install-sh or install.sh in . ./.. ./../..
make[1]: Entering directory `/home/rlrevell/cvs/alsa/alsa-tools/qlo10k1'
make[1]: *** No targets specified and no makefile found.  Stop.
make[1]: Leaving directory `/home/rlrevell/cvs/alsa/alsa-tools/qlo10k1'
make[1]: Entering directory `/home/rlrevell/cvs/alsa/alsa-tools/qlo10k1'
make[1]: *** No targets specified and no makefile found.  Stop.
make[1]: Leaving directory `/home/rlrevell/cvs/alsa/alsa-tools/qlo10k1'
make: *** [all] Error 2

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
