From: Dave Andruczyk <djandruczyk@yahoo.com>
Subject: 0.9beta 12 won't build on Mandrake 8.2 (SMP)
Date: Fri, 22 Mar 2002 16:07:41 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020323000741.73300.qmail@web14108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received: from web14108.mail.yahoo.com (web14108.mail.yahoo.com [216.136.172.138])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id BAA13676
	for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2002 01:07:44 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


./configure fails in alsa driver 0.9beta12

output from configure:
checking for current directory... /home/dave/sound/alsa-driver-0.9.0beta1=
2
checking for directory with kernel source... /lib/modules/2.4.18-6mdksmp/=
build
checking for kernel version... expr: syntax error
expr: syntax error
expr: syntax error
failed (probably missing
/lib/modules/2.4.18-6mdksmp/build/include/linux/version.h)

file exists (version.h)  its contents are:
#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.18-6mdksmp"
#elif defined(__module__enterprise)
#define UTS_RELEASE "2.4.18-6mdkenterprise"
#elif defined(__module__up)
#define UTS_RELEASE "2.4.18-6mdk"
#else
#define UTS_RELEASE "2.4.18-6mdksecure"
#endif
#define LINUX_VERSION_CODE 132114
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

output from config.log
configure:1381: gcc -o conftest -g -O2   conftest.c  1>&5
In file included from configure:1343:
/lib/modules/2.4.18-6mdksmp/build/include/linux/version.h:1:28:
linux/rhconfig.h: No such file or directory
configure: failed program was:
#line 1339 "configure"
#include "confdefs.h"

#include <stdio.h>
#include <ctype.h>
#include "/lib/modules/2.4.18-6mdksmp/build/include/linux/version.h"
int main()
{
 FILE *f;
 char kversion[128];
 char kpatchlevel[128];

EXTRA LINES DELETED... (excessive output)


the rhconfig.h file also exists in the supposed correct location.  Seems =
like
the include path is missing/incorrect for it to fail to find the header f=
ile.


Creating a symlink in /usr/include/linux for rhconfig.h to point to
/usr/src/linux/include/linux/rhconfig.h SOLVES the problem, but I do NOT =
think
it is "The Right Thing" (tm) to do.. =20

any suggestions from the developers?




=3D=3D=3D=3D=3D
Dave J. Andruczyk
Enterprise Resource Providers

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards=AE
http://movies.yahoo.com/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
