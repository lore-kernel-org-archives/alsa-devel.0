From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [Alsa-user] config.log
Date: Fri, 27 Oct 2006 11:09:44 +0200
Message-ID: <1161940184.6205.274354678@webmail.messagingengine.com>
References: <20061026143710.89794.qmail@web51108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061026143710.89794.qmail@web51108.mail.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: sercan sen <sensercan@yahoo.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

sercan sen wrote:
> > The configure script didn't detect [quite a few things].
> > Please show the contents of your config.log file.
> 
> configure:6889: gcc -c -Wall -fno-strict-aliasing -g -O2
>   -I/lib/modules/2.6.9-34.EL.cern/build/include
>   -I/lib/modules/2.6.9-34.EL.cern/source/include
>   -I/lib/modules/2.6.9-34.EL.cern/source/include/asm-i386/mach-default
>   -nostdinc -iwithprefix include -DKBUILD_STR(s)=#s
>   -DKBUILD_BASENAME=KBUILD_STR(dummy) -Werror  conftest.c >&5
> In file included from conftest.c:22:
> /lib/modules/2.6.9-34.EL.cern/build/include/linux/kernel.h:10:20:
>   stdarg.h: No such file or directory

This file should have been picked up from the compiler's own include
directory.

I think there may be something wrong with your compiler configuration.
If you create a test.c file with the following contents:

	#include <stdarg.h>
	int main() {}

and compile it with "gcc -c test.c", does it work?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
