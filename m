From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: ALSA CVS: cannot find uda1341.h
Date: Wed, 17 Apr 2002 20:54:11 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020417195411.57057.qmail@web13102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I just tried to totally rebuild the latest alsa-driver
modules from CVS, and I'm getting this error when I
try to generate the dependencies:

gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/home/chris/Programs/alsa/alsa-driver/include
-I/lib/modules/2.4.18/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__
-DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -pipe  uda1341.c > .depend
In file included from uda1341.c:1:
/home/chris/Programs/alsa/alsa-driver/alsa-kernel/i2c/l3/uda1341.c:37:25:
linux/l3/l3.h: No such file or directory
/home/chris/Programs/alsa/alsa-driver/alsa-kernel/i2c/l3/uda1341.c:41:21:
uda1341.h: No such file or directory
make[2]: *** [fastdep] Error 1
make[2]: Leaving directory
`/home/chris/Programs/alsa/alsa-driver/i2c/l3'
make[1]: *** [_sfdep_l3] Error 2
make[1]: Leaving directory
`/home/chris/Programs/alsa/alsa-driver/i2c'
make: *** [dep] Error 1

I think that those uda1341.* files were added today.

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
