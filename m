From: Chris Rankin <rankincj@yahoo.com>
Subject: alsa-driver CVS configure.in broken
Date: Fri, 5 Nov 2004 22:58:31 +0000 (GMT)
Message-ID: <20041105225831.99055.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I have just tried to compile my ALSA kernel modules
from CVS, and discovered that the CONFIG symbols from
the kernel's autoconf.h are not being added to the
autoconf.h in the alsa-driver/include/linux/
directory.

I reverted a one-line change to the configure.in file
and it was fine again.

Cheers,
Chris

P.S. My kernel's source and build symbolic links in
/lib/modules/<uname -r>/ point to different
directories, because I compile several different
kernels from the same source files on this machine.


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
