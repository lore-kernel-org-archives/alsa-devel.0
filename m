From: Robin Cook <rcook@wyrms.net>
Subject: problem compiling with Mandrake 8.2 rc1
Date: 10 Mar 2002 00:55:52 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1015743352.6122.15.camel@pheuri.wyrms.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from phlare.wyrms.net (adsl-216-62-231-61.dsl.snantx.swbell.net [216.62.231.61])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id HAA30328
	for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2002 07:55:55 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to build alsa 0.9.0beta12 with the current rc1 for Mandrake
8.2 but I am getting an error.

./configure --with-kernel=/usr/src/linux-2.4.18-5mdk
--with-moddir=/lib/modules/2.4.18-5mdk/misc --with-sequencer=yes
--with-oss=yes --with-cards=all

I then get this error while configure is running...

checking for directory with kernel source... /usr/src/linux-2.4.18-5mdk
checking for kernel version... expr: syntax error
expr: syntax error
expr: syntax error
failed (probably missing
/usr/src/linux/2.4.18-5mdk/include/linux/version.h)

This files does exist. And this is it's content

#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.18-5mdksmp"
#elif defined(__module__enterprise)
#define UTS_RELEASE "2.4.18-5mdkenterprise"
#elif defined(__module__up)
#define UTS_RELEASE "2.4.18-5mdk"
#else
#define UTS_RELEASE "2.4.18-5mdksecure"
#endif
#define LINUX_VERSION_CODE 132114
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

Is there something I can change somewhere to get this working?


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
