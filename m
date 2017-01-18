From: Nali Waterfall <nwfalls@gmail.com>
Subject: Problem with alsa-compile.sh script on Linux Mint 18.1
Date: Wed, 18 Jan 2017 07:02:06 +0000
Message-ID: <CAFdEiKRNhyFEiKCxm4AktOY+zCFr1uQ8gYfSm=WEmBiv+9bQmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f180.google.com (mail-yb0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 8843E267A77
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 08:02:18 +0100 (CET)
Received: by mail-yb0-f180.google.com with SMTP id l23so1322978ybj.2
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 23:02:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello! I have a "Cannot install patch for unsupported distribution Linux"
error while trying to run alsa-compile.sh script. The script supports
Ubuntu which Mint is base on. What can I do to make it support Mint?

nwfall@desktop ~/alsa $ ./alsa-compile.sh
File environment.base is cached.
> cd /tmp/alsa-compile-script
Program git found.
Program autoconf found.
Program aclocal found.
Program gcc found.
Cannot install patch for unsupported distribution Linux.

nwfall@desktop ~/alsa $ ./alsa-compile.sh --help
Usage: ./alsa-compile.sh [OPTION]...

This is a script version 0.2.9 doing ALSA code compilation and installation.
Report any problems to <alsa-devel@alsa-project.org> mailing list.
...

nwfall@desktop /tmp/alsa-compile-script $ cat environment.base
protocol=http
distrib="Linux"
distribver="18.1"
url="http://www.alsa-project.org/snapshot/?package=alsa-driver"
package="alsa-driver"
depmodbin="/sbin/depmod"
modinfobin="/sbin/modinfo"

nwfall@desktop ~ $ lsb_release -ds
Linux Mint 18.1 Serena
