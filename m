From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Build Failure in CVS
Date: Fri, 28 Nov 2003 12:18:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16327.33639.283012.939781@ronispc.chem.mcgill.ca>
Reply-To: david.ronis@mcgill.ca
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


I'm on an i686-linux-2.4.22-gnu box, using gcc-3.3.2, slackware-9.0,
I've got bot the lowlatency and preemptive patches installed.

I just did a CVS upgrade and tried rebuilding.  The build fails in:

make[2]: Entering directory `/usr/src/alsa/alsa-driver/pci/ac97'
/usr/bin/gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.4.22/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c ac97_codec.c
/usr/bin/gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.4.22/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=ac97_pcm   -c -o ac97_pcm.o ac97_pcm.c
In file included from ac97_pcm.c:2:
../../alsa-kernel/pci/ac97/ac97_pcm.c: In function `get_slot_reg':
../../alsa-kernel/pci/ac97/ac97_pcm.c:169: error: `rate_preg_tables' undeclared (first use in this function)
../../alsa-kernel/pci/ac97/ac97_pcm.c:169: error: (Each undeclared identifier is reported only once
../../alsa-kernel/pci/ac97/ac97_pcm.c:169: error: for each function it appears in.)
ac97_pcm.c: At top level:
../../alsa-kernel/pci/ac97/ac97_pcm.c:44: warning: `rate_reg_tables' defined but not used
make[2]: *** [ac97_pcm.o] Error 1


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
