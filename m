From: marco trevisani <marco@ccrma.stanford.edu>
Subject: Re: alsa and kernel 2.4.17 with acpi patch
Date: Wed, 13 Feb 2002 12:55:38 -0400
Message-ID: <20020213125538.A20138@trevisani>
References: <20020213104837.A21803@gramsci> <s5hvgd14big.wl@alsa2.suse.de>
Reply-To: marco@ccrma.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hvgd14big.wl@alsa2.suse.de>; from tiwai@suse.de on Wed, Feb 13, 2002 at 12:00:55 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


thank you.

BTW...:-) while i was compiling i forgot to select only the card i need and i 
figured out that the same problem happens with file wavefront.h (i'm not sure 
if that is the exact name of the file...i'm on a different computer right 
now)..so it could be that more files need to be changed.

thanks again,

	marco trevisani

On  Wednesday, 13 February 2002 12:00:55 Takashi Iwai wrote:
>    Hi,
>       At Wed, 13 Feb 2002 10:48:37 -0400,
>    marco trevisani wrote:
>    >
>    >
>    > Hi,
>    >
>    > i was trying to compile alsa 090beta10
>    > on kernel 2.4.17 with latest acpi patch (necessary for machines with
>    legacy
>    > free in order to get IRQ assigned during boot time), and i ran into this
>    error.
>    > [ kernel module i810 is reported to work i didnt tried it yet]
>    >
>    > here is the error:
>    > -------------------------------
>    > make[5]: Entering directory `/usr/src/modules/alsa-driver/kernel/oss'
>    > gcc   -DALSA_BUILD -D__KERNEL__ -O2 -mpreferred-stack-boundary=2
>    -march=i686
>    > -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe
>    > -I/usr/src/linux/include -I../.. -c -o route.o route.c
>    > route.c:59: `UINT32' redeclared as different kind of symbol
>    > /usr/src/linux/include/linux/../../drivers/acpi/include/actypes.h:121:
>    > previous declaration of `UINT32'
>    > route.c:59: `UINT64' redeclared as different kind of symbol
>    > /usr/src/linux/include/linux/../../drivers/acpi/include/actypes.h:122:
>    > previous declaration of `UINT64'
>    > make[5]: *** [route.o] Error 1
>    > make[5]: Leaving directory `/usr/src/modules/alsa-driver/kernel/oss'
>    > make[4]: *** [all] Error 1
>    > -------------------------
>    > Below are lines 121 and 122 from actypes.h
>    > typedef unsigned int                    UINT32;
>    > typedef COMPILER_DEPENDENT_UINT64       UINT64;
>    > ----------------------------------------------
>       try to rename UINT32 and UINT64 in route.c (line 59)
>    as different names such as SUM_UINT32 and SUM_UINT64.
>    these words appear only once for each below around line 562,
>    so please check them as well.
>       i'll fix it on cvs, now.
>          Takashi
>       _______________________________________________
>    Alsa-devel mailing list
>    Alsa-devel@lists.sourceforge.net
>    https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

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
