From: Andrei Boros <andrei@srr.ro>
Subject: cvs problems [current]
Date: Tue, 19 Aug 2003 09:19:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F41C181.2E8AC2BD@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


 I got some problems with alsa cvs tree compilation. I got my cvs tree
updated 15 min ago. 

 Trying to compile alsa-driver I get the following : 

(i ran cvscompile first, but interrupted it when it got the the make
part, I want my own configuration)
Kernel is 2.2.24.

gate:~/install/alsa-cvs/alsa-driver# ./configure
--with-cards=dummy,cs46xx,opti92x-ad1848 --with-oss=yes
--with-sequencer=yes --with-isapnp=yes --with-debug=detect
--enable-verbose-printk

I see this error during configure :

Creating a dummy <asm/hw_irq.h>...
touch: include/asm/hw_irq.h: No such file or directory

The, during make I see :
make[1]: Entering directory `/serve/install/alsa-cvs/alsa-driver/acore'
gcc -D__KERNEL__ -DMODULE=1
-I/serve/install/alsa-cvs/alsa-driver/include  -I/usr/src/linux/include
-O2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  
-DEXPORT_SYMTAB -c timer.c
In file included from timer.c:33:
/usr/src/linux/include/linux/kmod.h:8: conflicting types for
`snd_compat_request_module_Rb8071e26'
/serve/install/alsa-cvs/alsa-driver/include/adriver.h:56: previous
declaration of `snd_compat_request_module_Rb8071e26'
timer.c:78: warning: `slave_active_lock' defined but not used
make[1]: *** [timer.o] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/acore'
make: *** [compile] Error 1


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
