From: Pavel Roskin <proski@gnu.org>
Subject: Breakage in alsa-driver/include/adriver.h on CVS
Date: Wed, 2 Oct 2002 17:34:55 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210021726190.12070-100000@marabou.research.att.com>
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

ALSA on CVS doesn't compile.  alsa-driver/include/adriver.h has several 
problems:

/usr/local/src/alsa/alsa-driver/include/adriver.h:186: parse error before 
`dir'
/usr/local/src/alsa/alsa-driver/include/adriver.h:188: multiple storage 
classes in declaration of `devfs_find_and_unregister'
/usr/local/src/alsa/alsa-driver/include/adriver.h:188: warning: function 
declaration isn't a prototype

I'm using devfs, and the first error can be fixed by adding this code
above in the header:

#ifdef CONFIG_DEVFS_FS
#include <linux/devfs_fs_kernel.h>
#endif

"multiple storage classes" is apparently "extern" and "static" in the same 
declaration.

"function declaration isn't a prototype" - there should not be any
semicolon between `)' and `{'.

On the positive side, I appreciate the work on eliminating acconfig.h 

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
