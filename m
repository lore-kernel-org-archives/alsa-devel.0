From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Problem compiling latest CVS with gcc-2.95.3
Date: Sat, 8 Mar 2003 10:40:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030308094052.GB29733@tuba.home>
References: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr> <20030308091124.GA29733@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030308091124.GA29733@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Panagiotis Papadakos <papadako@csd.uoc.gr>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 08, 2003 at 10:11:24AM +0100, Martin Langer wrote:
> On Sat, Mar 08, 2003 at 10:51:29AM +0200, Panagiotis Papadakos wrote:
>
> same with gcc 2.95.4!
> > 
> > gcc -M -D__KERNEL__ -DMODULE=1
> > -I/mnt/disk/CVS/ALSA-CVS/alsa-driver/include
> > -I/lib/modules/2.4.21-pre5-ac2/build/include -O2
> > -mpreferred-stack-boundary=2 -march=i686 -falign-functions=4 -DLINUX -Wall
>                                            ^^^^^^^^^^^^^^^^^^^
> > -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
> > -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  usbaudio.c usbmidi.c
> > usbmixer.c > .depend
> > make[1]: Leaving directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/usb'
> > make[1]: Entering directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/acore'
> > gcc -D__KERNEL__ -DMODULE=1 -I/mnt/disk/CVS/ALSA-CVS/alsa-driver/include
> > -I/lib/modules/2.4.21-pre5-ac2/build/include -O2
> > -mpreferred-stack-boundary=2 -march=i686 -falign-functions=4 -DLINUX -Wall
> > -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
> > -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c
> > hwdep.c
> > cc1: Invalid option `-falign-functions=4'
>                        ^^^^^^^^^^^^^^^^^^^
> > make[1]: *** [hwdep.o] Error 1
> > make[1]: Leaving directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/acore'
> > make: *** [compile] Error 1
> > -(root@Santorini:0)-(12 files:18k@ALSA-CVS)-(0 jobs)-(10:48)-
> > -(/mnt/disk/CVS/ALSA-CVS:#)->
> 

this are messages the of the following machine:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1102.523
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2195.45




Another machine (same Alsa-CVS, both debian woody) shows a different problem:

gcc -D__KERNEL__ -DMODULE=1 -I/usr/local/src/alsa-cvs/alsa-driver/include
-I/lib/modules/2.4.20/build/include -O2 -mpreferred-stack-boundary=2
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-DEXPORT_SYMTAB -c ainstr_iw.c
rm -f snd-ainstr-fm.o
ld  -r -o snd-ainstr-fm.o ainstr_fm.o
rm -f snd-ainstr-gf1.o
ld  -r -o snd-ainstr-gf1.o ainstr_gf1.o
rm -f snd-ainstr-iw.o
ld  -r -o snd-ainstr-iw.o ainstr_iw.o
rm -f snd-ainstr-simple.o
ld  -r -o snd-ainstr-simple.o ainstr_simple.o
ainstr_simple.o: file not recognized: File truncated
make[4]: *** [snd-ainstr-simple.o] Error 1
make[4]: Leaving directory
/usr/local/src/alsa-cvs/alsa-driver/acore/seq/instr'
make[3]: *** [_modsubdir_instr] Error 2
make[3]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/acore/seq'
make[2]: *** [_modsubdir_seq] Error 2
make[2]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/acore'

and that one is such a damned slow compiling.....

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 7
model name      : Cyrix MediaGXtm MMXtm Enhanced
stepping        : 4
cpu MHz         : 200.456
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 399.76



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
