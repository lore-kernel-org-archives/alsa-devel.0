From: Michal Seta <mis@creazone.com>
Subject: Re: [Alsa-user] Request for test of powermac driver
Date: Mon, 20 May 2002 10:41:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acb29s$d00$2@main.gmane.org>
References: <s5hn0v15p95.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0v15p95.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having trouble compiling the new powermac driver:

gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 -I/home/mis/CVS/alsa-driver/include -I/usr/src/linux/include -O2 -D__powerpc__ -fsigned-char -fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAME=powermac   -c -o powermac.o powermac.c
../alsa-kernel/ppc/powermac.c:40: warning: `snd_enable' defined but not used
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 -I/home/mis/CVS/alsa-driver/include -I/usr/src/linux/include -O2 -D__powerpc__ -fsigned-char -fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAME=pmac   -c -o pmac.o pmac.c
In file included from pmac.c:1:
../alsa-kernel/ppc/pmac.c: In function `snd_pmac_new':
../alsa-kernel/ppc/pmac.c:1353: structure has no member named `mode'
make[1]: *** [pmac.o] Error 1
make[1]: Leaving directory `/home/mis/CVS/alsa-driver/ppc'
make: *** [compile] Error 1

any hints?

Mike

_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
