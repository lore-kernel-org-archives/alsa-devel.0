From: marco trevisani <marco@ccrma.stanford.edu>
Subject: alsa and kernel 2.4.17 with acpi patch
Date: Wed, 13 Feb 2002 10:48:37 -0400
Message-ID: <20020213104837.A21803@gramsci>
Reply-To: marco@ccrma.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Received: from localhost ([204.183.116.42])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA19151
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 15:48:51 +0100
Received: from localhost ([127.0.0.1] helo=gramsci)
	by localhost with esmtp (Exim 3.34 #1 (Debian))
	id 16b0i5-0005tY-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 10:48:37 -0400
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


Hi,

i was trying to compile alsa 090beta10
on kernel 2.4.17 with latest acpi patch (necessary for machines with legacy 
free in order to get IRQ assigned during boot time), and i ran into this error.
[ kernel module i810 is reported to work i didnt tried it yet]

here is the error:
-------------------------------
make[5]: Entering directory `/usr/src/modules/alsa-driver/kernel/oss'
gcc   -DALSA_BUILD -D__KERNEL__ -O2 -mpreferred-stack-boundary=2 -march=i686 
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe 
-I/usr/src/linux/include -I../.. -c -o route.o route.c
route.c:59: `UINT32' redeclared as different kind of symbol
/usr/src/linux/include/linux/../../drivers/acpi/include/actypes.h:121: 
previous declaration of `UINT32'
route.c:59: `UINT64' redeclared as different kind of symbol
/usr/src/linux/include/linux/../../drivers/acpi/include/actypes.h:122: 
previous declaration of `UINT64'
make[5]: *** [route.o] Error 1
make[5]: Leaving directory `/usr/src/modules/alsa-driver/kernel/oss'
make[4]: *** [all] Error 1
-------------------------
Below are lines 121 and 122 from actypes.h 
typedef unsigned int                    UINT32;
typedef COMPILER_DEPENDENT_UINT64       UINT64;
----------------------------------------------

Any suggestion?

	marco



*-------------------------------------------------------------------*
      marco trevisani   (to get the real email address take out "__")
email________________:  m__arco@ccrma.sta__nford.edu      
Web________________:  http://trevisani.mine.nu	      DeMuDi -- Debian 
Multimedia Distribution 	 demudi email_________:  
m__arco@dem__udi.org              demudi web__________:  
http://www.demudi.org		      Digital Arts Festivals. Calls and 
reports <--NEW!!
D-Festival Web______:  http://festivals.webhop.org
*-------------------------------------------------------------------*

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
