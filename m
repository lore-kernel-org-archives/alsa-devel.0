From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 21:31:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c1fbb0$32eb45a0$ac1f830a@ico>
References: <200205150001.g4F012T12698@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205150001.g4F012T12698@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Paul Davis [mailto:pbd@op.net]
> Sent: Tuesday, May 14, 2002 8:02 PM
> To: Ivica Bukvic
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: Failed to compile HDSP driver from the CVS
> 
> >I am a bit confused. It is not the fact that I do have this file, but
> >that the compile was looking for it. It must have been that issue you
> >mentioned about CVS being not up-to-date.
> 
> its a combination of the "fastdep" target looking at *all* existing
> sources, whether they are meant to be there or not, plus the CVS sync
> issue.
> 
> 					   However, here's the error
when
> >I try to compile the driver now, after updating it with
> 
> use cvscompile to build it, i think.
> 
> --p

But all this still comes up with the same error, so this does not seem
to be the solution. The compiling still stops with the same error which
I am unable to figure out since it has to do with some define statements
at the beginning of the hammerfall_mem.c file:

make  -C rme9652 modules
make[2]: Entering directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/LocalDump/Install/Alsa/CVS/alsa-driver/include
-I/lib/modules/2.4.8-26mdk/build/include -O2
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -pipe   -DEXPORT_SYMTAB -c
hammerfall_mem.c
In file included from hammerfall_mem.c:1:
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: parse error before
string constant
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: type
defaults to `int' in declaration of `MODULE_LICENSE'
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: function
declaration isn't a prototype
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: data
definition has no type or storage class
make[2]: *** [hammerfall_mem.o] Error 1
make[2]: Leaving directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
make[1]: *** [_modsubdir_rme9652] Error 2
make[1]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver/pci'
make: *** [compile] Error 1

It is obvious that it is having a problem with the hammerfall_mem.c
file, not the addition or removal of rme9652_mem.c file any more.

Does anyone else seem to have a problem with this one or is it just me?

Ico



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
