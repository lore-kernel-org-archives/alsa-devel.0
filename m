From: Lee Revell <rlrevell@joe-job.com>
Subject: CVS does not compile
Date: Tue, 15 Feb 2005 16:02:19 -0500
Message-ID: <1108501339.3772.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

make -C /home/rlrevell/kernel-source/linux-2.6.11-rc4-V0.7.39-02
SUBDIRS=/smb/rl
revell/cvs/alsa-default-2/alsa-driver
O=/lib/modules/2.6.11-rc4-RT-V0.7.39-02/bu
ild modules
make[1]: Entering directory
`/smb/rlrevell/kernel-source/linux-2.6.11-rc4-V0.7.3
9-02'
  CC [M]  /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.o
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/core.h:29,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:198: error: redefinition of `pm_message_t'
/smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/adriver.h:717:
error: `pm_message_t' previously declared here
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/core.h:29,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:218:1: warning: "PMSG_FREEZE" redefined
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/driver.h:42,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:22:
/smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/adriver.h:718:1:
warning: this is the location of the previous definition
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/core.h:29,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:219:1: warning: "PMSG_SUSPEND" redefined
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/driver.h:42,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:22:
/smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/adriver.h:719:1:
warning: this is the location of the previous definition
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/core.h:29,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:220:1: warning: "PMSG_ON" redefined
In file included
from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/sound/driver.h:42,

from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:22:
/smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/adriver.h:720:1:
warning: this is the location of the previous definition
make[4]: ***
[/smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.o] Error 1
make[3]: *** [/smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore] Error
2
make[2]: *** [_module_/smb/rlrevell/cvs/alsa-default-2/alsa-driver]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory
`/smb/rlrevell/kernel-source/linux-2.6.11-rc4-V0.7.39-02'
make: *** [compile] Error 2

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
