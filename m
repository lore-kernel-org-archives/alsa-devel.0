From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: alsa-drivers-HEAD does not compile against recent
	RHE5.1 kernels
Date: Fri, 23 May 2008 11:41:40 +1000
Message-ID: <1211506900.3811.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 663A2244A6
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 03:41:46 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1JzMHt-0002Dy-K6
	for alsa-devel@alsa-project.org; Fri, 23 May 2008 11:41:41 +1000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

alsa-drivers-HEAD does not compile against recent RHE5 kernels, such as 
ftp://ftp.redhat.com/pub/redhat/linux/enterprise/5Client/en/os/SRPMS/kernel-2.6.18-53.1.21.el5.src.rpm

The problem is mixed up with the test for init_utsname in configure.in:

dnl Check for init_utsname...
if test "$kversion.$kpatchlevel" = "2.6" -a $ksublevel -ge 19; then
  CONFIG_HAVE_INIT_UTSNAME=1
else
AC_MSG_CHECKING(for init_utsname)
  init_utsname="0"
  ac_save_CFLAGS="$CFLAGS"
  ac_save_CC="$CC"
  CFLAGS="$KERNEL_CHECK_CFLAGS -Werror"
  CC=$KCC
  AC_TRY_COMPILE([
#define __KERNEL__
#include <linux/config.h>
#include <linux/utsname.h>
],[
  int *x = (int *)init_utsname();
  *x = 0;
],
    AC_MSG_RESULT(yes);init_utsname="1",
    AC_MSG_RESULT(no);init_utsname="0",
    AC_MSG_RESULT(unknown);init_utsname="0"
)
  CFLAGS=$ac_save_CFLAGS
  CC=$ac_save_CC
  CONFIG_HAVE_INIT_UTSNAME=$init_utsname
fi
dnl AC_SUBST(CONFIG_HAVE_INIT_UTSNAME)
if test "$CONFIG_HAVE_INIT_UTSNAME" = "1"; then
  AC_DEFINE(CONFIG_HAVE_INIT_UTSNAME)
fi

The problem is that <linux/config.h> does not exist in recent kernel.org
and RH 2.6.18 kernels. The AC_TRY_COMPILE produces a negative result
(because of a warning, treated as an error, about the missing
linux/config.h file), which then causes CONFIG_HAVE_INIT_UTSNAME to NOT
be defined.

This results in a compile failure in acore/info_oss.c .

I'm not sure how this should be fixed. I'm also not sure why someone
else hasn't noticed it already, since it affects me with a standard
kernel.org kernel. Therefore, here is my test procedure.

wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
tar -xjf linux-2.6.25.tar.bz2
cd linux-2.6.25
make defconfig
make modules_prepare
cd ..

(This next step takes *forever*)
git clone git://git.alsa-project.org/alsa-kernel.git alsa-kernel

git clone git://git.alsa-project.org/alsa-driver.git alsa-driver
cd alsa-driver
./gitcompile --with-kernel=../linux-2.6.25 --with-build=../linux-2.6.25

This currently produces an error:
No alsa-kernel is found.
Please specify the correct location via ALSAKERNELDIR environment
variable.

So instead I run
ALSAKERNELDIR=../alsa-kernel ./gitcompile --with-kernel=../linux-2.6.25
--with-build=../linux-2.6.25
and I get the same error.

when I repeat the above with an alsa-kernel from hg, I do not get this
problem (in fact, alsa-driver compiles completely on the Ubuntu 7.10
machine I'm using for this test).

So, I've got perhaps two different problems here. I need a hand.

Ben Stanley.
