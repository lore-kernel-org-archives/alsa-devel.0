From: Lee Revell <rlrevell@joe-job.com>
Subject: CVS does not compile
Date: Wed, 03 Nov 2004 15:03:27 -0500
Message-ID: <1099512208.1617.33.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

make -C ~/kernel-source/linux-2.6.9-rc3-mm3-T3 SUBDIRS=/home/rlrevell/cvs/alsa/alsa-driver/kbuild O=/lib/modules/2.6.9-rc3-mm3-VP-T3/build modules
make[1]: Entering directory `/home/rlrevell/kernel-source/linux-2.6.9-rc3-mm3-T3'
  CC [M]  /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/hwdep.o
In file included from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:51,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from /home/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:22:
include/asm/processor.h:68: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
include/asm/processor.h:68: error: requested alignment is not a constant
In file included from include/linux/list.h:7,
                 from include/linux/wait.h:23,
                 from include/asm/semaphore.h:41,
                 from include/linux/sched.h:19,
                 from include/linux/module.h:10,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:51,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from /home/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:22:
include/linux/prefetch.h: In function `prefetch_range':
include/linux/prefetch.h:64: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared (first use in this function)
include/linux/prefetch.h:64: error: (Each undeclared identifier is reported only once
include/linux/prefetch.h:64: error: for each function it appears in.)
In file included from include/linux/module.h:23,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:51,
                 from /home/rlrevell/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from /home/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:22:
include/asm/module.h:54:2: #error unknown processor family
make[4]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/hwdep.o] Error 1
make[3]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2
make[2]: *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/home/rlrevell/kernel-source/linux-2.6.9-rc3-mm3-T3'
make: *** [compile] Error 2

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
