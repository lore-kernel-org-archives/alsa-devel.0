From: "Arcady Genkin" <agenkin@thpoon.com>
Subject: alsa-tools-0.9.7 compilation failure in sscape_ctl with headers
 from 2.4
Date: 2 Oct 2003 20:15:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <uozngjnpmf.fsf@bashful.cdf.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The code for sscape_ctl from the 0.9.7 tarball of alsa-tools does not
compile.  The problem is on line 208 in sscape_ctl.c:

    microcode.code = &_microcode;

This produces the following (fatal) error message:

  source='sscape_ctl.c' object='sscape_ctl.o' libtool=no \
  depfile='.deps/sscape_ctl.Po' tmpdepfile='.deps/sscape_ctl.TPo' \
  depmode=gcc /bin/sh ./depcomp \
  gcc -DPACKAGE=\"sscape_ctl\" -DVERSION=\"0.1.0\" -DSTDC_HEADERS=1
     -DHAVE_LIBASOUND=1  -I. -I.     -g -O2  -c `test -f sscape_ctl.c ||
     echo './'`sscape_ctl.c
  sscape_ctl.c: In function `main':
  sscape_ctl.c:208: incompatible types in assignment
  make: *** [sscape_ctl.o] Error 1

I have also noticed that this compiles fine with the Linux headers
from 2.6.0-test6 (although with a warning), but breaks with the linux
headers from 2.4.  Having looked in include/sound/sscape_ioctl.h, the
declaration of sscape_microcode has changed:

,----[ Linux headers from 2.4.18 ]
| struct sscape_microcode
| {
|   unsigned char code[65536];
| };
`----

,----[ Linux headers from 2.6.0-test6 ]
| struct sscape_microcode
| {
|   unsigned char *code;  /* 65536 chars */
| };
`----

Could somebody please have a look at these?
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
