From: Raymond <rayau@netvigator.com>
Subject: ac97_codec.c - unresolved symbol msecs_to_jiffies on Kernel 2.4
Date: Tue, 12 Jul 2005 16:38:46 +0800
Message-ID: <42D38196.6020106@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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



make  -C ac97 modules
make[2]: Entering directory `/root/alsa/alsa-driver-1.0.9b/pci/ac97'
gcc32 -D__KERNEL__ -DMODULE=1 -I/root/alsa/alsa-driver-1.0.9b/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h
-DEXPORT_SYMTAB -c ac97_codec.c
In file included from ac97_codec.c:1:
../../alsa-kernel/pci/ac97/ac97_codec.c: In function `snd_ac97_resume':
../../alsa-kernel/pci/ac97/ac97_codec.c:2252: warning: implicit
declaration of function `msecs_to_jiffies'


http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.188&r2=1.189


# modprobe snd-au8830
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/pci/ac97/snd-ac97-codec.o: 
unresolved symbol msecs_to_jiffies
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/pci/ac97/snd-ac97-codec.o: 
insmod 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/pci/ac97/snd-ac97-codec.o 
failed
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/pci/ac97/snd-ac97-codec.o: 
insmod snd-au8830 failed





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
