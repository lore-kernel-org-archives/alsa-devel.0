From: Ivica Bukvic <ico@fuse.net>
Subject: Re: Failed to compile HDSP driver from the CVS
Date: 14 May 2002 18:16:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1021414588.4152.1.camel@badass-bukvic.dyndns.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ico@fuse.net, pbd@op.net
List-Id: alsa-devel@alsa-project.org

Apologies if this thing got posted twice. My mail has been acting up
lately.

I am a bit confused. It is not the fact that I do have this file, but
that the compile was looking for it. It must have been that issue you
mentioned about CVS being not up-to-date. However, here's the error when
I try to compile the driver now, after updating it with 

cvs -z3 -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa'
update -P -d 

I get the following error: 

make[3]: Leaving directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/pdplus' 
make  -C rme9652 modules 
make[3]: Entering directory
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
make[3]: *** [hammerfall_mem.o] Error 1 
make[3]: Leaving directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652' 
make[2]: *** [_modsubdir_rme9652] Error 2 
make[2]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver/pci'
make[1]: *** [compile] Error 1 
make[1]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver' 
make: *** [build] Error 2 

Any help is greatly appreciated! 

Sincerely, 

Ico 




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
