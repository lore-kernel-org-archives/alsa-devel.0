From: Jaakko Prattala <Jaakko.Prattala@Helsinki.FI>
Subject: emu10k1 module compile error with latest cvs
Date: 02 Aug 2003 12:54:16 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1059818056.5386.5.camel@gruuvi>
Reply-To: Jaakko.Prattala@Helsinki.FI
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

gcc -D__KERNEL__ -DMODULE=1
-I/home/jaakko/downloads/alsa020803/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=emufx   -c -o emufx.o emufx.c
In file included from emufx.c:2:
../../alsa-kernel/pci/emu10k1/emufx.c: In function
`snd_emu10k1_gpr_ctl_put':
../../alsa-kernel/pci/emu10k1/emufx.c:367:
`EMU10K1_GRP_TRANSLATION_BASS' undeclared (first use in this function)
../../alsa-kernel/pci/emu10k1/emufx.c:367: (Each undeclared identifier
is reported only once
../../alsa-kernel/pci/emu10k1/emufx.c:367: for each function it appears
in.)
../../alsa-kernel/pci/emu10k1/emufx.c:372:
`EMU10K1_GRP_TRANSLATION_TREBLE' undeclared (first use in this function)
In file included from emufx.c:2:
etc.

gcc version 3.2.2 on rhl 9

--
Jaakko




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
