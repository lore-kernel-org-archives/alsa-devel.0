From: Pavel Roskin <proski@gnu.org>
Subject: Driver headers used by alsa-lib
Date: Fri, 4 Oct 2002 13:20:32 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210041255490.23670-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

There is another configuration problem that needs to be fixed.  I had ALSA
already installed (CVS version as of a week ago or so).  Today I compiled
alsa-driver, alsa-lib and alsa-util and then started installing them.

I found that "make install" caused recompilation in alsa-lib.  It used to
be like that, but this time I wanted to do it right.

I found that the reason for recompilation is new files in
/usr/include/sound/, in particular asoundef.h.  It turmed out that there
are two different files with this name - one is
alsa-lib/include/asoundef.h, the other is alsa-kernel/include/asoundef.h.

Object files under alsa-lib were compiled against headers in
/usr/include/sound/, and "make install" in alsa-kernel installed new
headers there.  The dependency was recorded by the compiler, so the
alsa-lib object files became out of date.

It seems to me that there are at least two things wrong here.  First is
that the kernel should not be installing its headers in places where they
can be accidentally used.  Most software should not need those headers at
all.

For example, Linux kernel includes are available under linux and asm in
/usr/include.  When I'm using them, I'm well aware of the fact that it's
essentially a private kernel interface and that I should avoid it if
possible.

If I include <sound/asoundef.h>, I would assume that it's something for 
user-space software, not for kernel drivers.  Maybe kernel headers should 
be installed under /usr/include/sound/kernel if we install them at all?

The other problem is that alsa-lib should be using its own headers from
its own distribution rather than the preinstalled ones, otherwise we have 
a whole new problem with compiling against an older library.

I'm ready to provide patches once somebody confirms that my understanding 
of the problem is correct.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
