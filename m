From: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Problem compiling latest CVS with gcc-2.95.3
Date: Sat, 8 Mar 2003 10:51:29 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

I get the following error:

gcc -M -D__KERNEL__ -DMODULE=1
-I/mnt/disk/CVS/ALSA-CVS/alsa-driver/include
-I/lib/modules/2.4.21-pre5-ac2/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -falign-functions=4 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  usbaudio.c usbmidi.c
usbmixer.c > .depend
make[1]: Leaving directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/usb'
make[1]: Entering directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/mnt/disk/CVS/ALSA-CVS/alsa-driver/include
-I/lib/modules/2.4.21-pre5-ac2/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -falign-functions=4 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c
hwdep.c
cc1: Invalid option `-falign-functions=4'
make[1]: *** [hwdep.o] Error 1
make[1]: Leaving directory `/mnt/disk/CVS/ALSA-CVS/alsa-driver/acore'
make: *** [compile] Error 1
-(root@Santorini:0)-(12 files:18k@ALSA-CVS)-(0 jobs)-(10:48)-
-(/mnt/disk/CVS/ALSA-CVS:#)->

	Panagiotis Papadakos


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
