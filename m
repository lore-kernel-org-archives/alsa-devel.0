From: Dave Andruczyk <djandruczyk@yahoo.com>
Subject: PCI drivers didn't compile (0.9RC2)
Date: Tue, 25 Jun 2002 10:56:23 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020625175623.65270.qmail@web14107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On my system (Mandrake 8.2) alsa 0.9rc2 failed to compile the PCI drivers.  
looking at the configure output said PCI was NOT detected in the kernel.  After
chewing thru the configure.in file, and verifying my kernel autoconf file was
OK, I made the following switch:

AC_TRY_RUN([
#include "$CONFIG_SND_KERNELDIR/include/linux/autoconf.h"
int main( void ) {
#ifndef CONFIG_PCI
  exit(1);
#else
  exit(0);
#endif
}
],
  AC_MSG_RESULT("yes");pcisup="y",
  AC_MSG_RESULT("no");pcisup="n",
  AC_MSG_RESULT("unknown");pcisup="n"
)

   - TO -

AC_TRY_RUN([
#include "$CONFIG_SND_KERNELDIR/include/linux/autoconf.h"
int main( void ) {
#ifndef CONFIG_PCI
  exit(1);
#else
  exit(0);
#endif
}
],
  AC_MSG_RESULT("no");pcisup="n",
  AC_MSG_RESULT("yes");pcisup="y",
  AC_MSG_RESULT("unknown");pcisup="n"
)

Notice the last four lines of each block.  the AC_MSG_RESULT "no/yes" sections
had to be reversed .  Not sure if theis is something weird on my box, or what. 

After doing that, run "autoreconf" then rm *cache ; ./configure, and PCI is
detected and alsa compiles OK (including the PCI drivers)

Any suggestions?


=====
Dave J. Andruczyk
ERP

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
