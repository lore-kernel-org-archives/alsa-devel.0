From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: MPU401 broken in CVS
Date: Fri, 24 Jan 2003 20:01:45 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030124200145.1826.qmail@web40613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

I think that there might be some header file changes
to commit in CVS too.

Chris

gcc -D__KERNEL__ -DMODULE=1
-I/home/chris/Programs/alsa/alsa-driver/include 
-I/home/chris/linux-2.4.20/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__
-DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -pipe -DALSA_BUILD  
-DEXPORT_SYMTAB -c mpu401_uart.c
In file included from mpu401_uart.c:1:
../../alsa-kernel/drivers/mpu401/mpu401_uart.c: In
function `snd_mpu401_uart_output_trigger':
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:373:
structure has no member named `mpu_output_lock'


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
