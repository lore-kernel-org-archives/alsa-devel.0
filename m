From: Bob Ham <node@users.sourceforge.net>
Subject: error in cvs compile with 2.5.43
Date: Fri, 18 Oct 2002 18:09:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021018170908.GA20262@depression.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

While attempting a cvscompile (cvs of this morning) with 2.5.43, I had to add
-I/usr/src/linux-2.5/arch/i386/mach-generic to the CFLAGS or else I got this
error while doing a make dep (or similar with a make):

In file included from /lib/modules/2.5.43/build/include/linux/irq.h:19,
                 from /lib/modules/2.5.43/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.5.43/build/include/linux/interrupt.h:25,
                 from ../../alsa-kernel/core/seq/seq_queue.h:27,
                 from ../../alsa-kernel/core/seq/seq.c:30,
                 from seq.c:1:
/lib/modules/2.5.43/build/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory

Not sure what's going on really; I can't decipher the kernel's include
system.

Bob


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
