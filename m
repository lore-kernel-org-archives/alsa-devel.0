From: Martin Langer <martin-langer@gmx.de>
Subject: CVS doesn't compile
Date: Sun, 27 Jul 2003 11:36:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030727093647.GA8056@tuba.home>
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


Sorry to say,

but CVS doesn't compile! Building the mixart driver fails:

make[3]: Entering directory /usr/local/src/alsa-cvs/alsa-driver/pci/mixart'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/local/src/alsa-cvs/alsa-driver/include
-I/lib/modules/2.4.19-rc1/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD  -DKBUILD_BASENAME=mixart   -c -o mixart.o mixart.c
In file included from mixart.c:35:
mixart_core.h:292: field streams' has incomplete type
make[3]: *** [mixart.o] Error 1
make[3]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/pci/mixart'
make[2]: *** [_modsubdir_mixart] Error 2
make[2]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/pci'
make[1]: *** [compile] Error 1


martin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
