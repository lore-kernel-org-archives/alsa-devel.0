From: William <walsac@liam2.demon.co.uk>
Subject: Re: Redhat 9.0 also has the snd.o unresolved symbol schedule_work issue
Date: Mon, 31 Mar 2003 12:25:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303311125.MAA02409@koyuki.liam2.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa@slackware.ru, jason@corekin.no-ip.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

alsa@slackware.ru wrote:
> [Jason Corekin wrote ... ]
> > Instead I am getting the error unresolved symbol schedule_work.
> please, check the kernel includes.
> /usr/include/linux MUST be the link to the include directory of the
> kernel. it was in the process of migration from 2.4.<20 to 2.4.>20.
> some distributions have /usr/include/linux as a directory. and, when
> compiling the fresh kernel, one can get strange things with unresolved
> symbols etc (old headers + new kernel).
>
> so,
> /usr/include/linux must be the link to /usr/src/linux/include/linux,
> if kernel sources were unpacked to the /usr/src/linux.

The kernel README file has a section "INSTALLING the kernel:"

  "- If you install the full sources, put the kernel tarball in a
     directory where you have permissions (eg. your home directory) and
     unpack it:

                gzip -cd linux-2.4.XX.tar.gz | tar xvf -

     Replace "XX" with the version number of the latest kernel.

     Do NOT use the /usr/src/linux area! This area has a (usually
     incomplete) set of kernel headers that are used by the library header
     files.  They should match the library, and not get messed up by
     whatever the kernel-du-jour happens to be."

Doesn't this mean the kernel header files in /usr/src/linux/include/linux
should be the same header files which were used to build your C library,
i.e. you shouldn't change or unpack new kernels into /usr/src/linux ? 

Have you tried "make clean; rm config.cache;
./configure --with-kernel=/my_kernel", where /my_kernel is the
top-level directory of the kernel source code
which should match the version of your current running kernel ("uname -a")?

William


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
