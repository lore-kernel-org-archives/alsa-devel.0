From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Cross compiling alsa-driver
Date: Tue, 04 Apr 2006 22:56:59 +0100
Message-ID: <1144187819.9472.25.camel@localhost.localdomain>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Cannot get this to work.

Doing it from cvs and from the package gives the same result...

./configure
--with-cross=~/buildroot/build_sh4/staging_dir/bin/sh4-linux-
--with-build=/home/adrian/linux-2.6.15.2

gives...

make[3]: Entering directory
`/home/adrian/alsa-driver-1.0.11rc4/pci/vx222'
make[3]: Leaving directory
`/home/adrian/alsa-driver-1.0.11rc4/pci/vx222'
make[3]: Entering directory
`/home/adrian/alsa-driver-1.0.11rc4/pci/ymfpci'
make[3]: Leaving directory
`/home/adrian/alsa-driver-1.0.11rc4/pci/ymfpci'
make[2]: Leaving directory `/home/adrian/alsa-driver-1.0.11rc4/pci'
make[1]: Leaving directory `/home/adrian/alsa-driver-1.0.11rc4'
make -C /lib/modules/2.6.12-10-686/build
SUBDIRS=/home/adrian/alsa-driver-1.0.11rc4 O=/home/adrian/linux-2.6.15.2
modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.12-10-686'
/usr/src/linux-headers-2.6.12-10-686/Makefile:530: /usr/src/linux-headers-2.6.12-10-686/arch//Makefile: No such file or directory
/bin/sh: /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc-3.4: No such file or directory
make[2]: *** No rule to make target
`/usr/src/linux-headers-2.6.12-10-686/arch//Makefile'.  Stop.
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.12-10-686'
make: *** [compile] Error 2

ie it is still looking for headers on the building machine.

Building from cvs gives a similar result.

The configure script appears to be broken...as this segment of output
suggests - as even though I specify a kernel directory it is still
looking elsewhere

checking for current directory... /home/adrian/alsa-driver-1.0.11rc4
checking cross
compile... /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-
checking for directory with kernel
source... /lib/modules/2.6.12-10-686/build
checking for directory with kernel build... /home/adrian/linux-2.6.15.2







-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
