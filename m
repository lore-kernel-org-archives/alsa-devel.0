From: Martin Langer <martin-langer@gmx.de>
Subject: Re: problems on alpha
Date: Mon, 17 Nov 2003 22:15:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031117211523.GA545@tuba.home>
References: <20031116175117.GA1174@tuba.home> <s5hvfpjjlqg.wl@alsa2.suse.de> <s5h65hikhgu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65hikhgu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2003 at 06:55:29PM +0100, Takashi Iwai wrote:
> At Mon, 17 Nov 2003 12:08:39 +0100,
> I wrote:
> > 
> > At Sun, 16 Nov 2003 18:51:17 +0100,
> > Martin Langer wrote:
> > > 
> > > gcc -D__KERNEL__ -DMODULE=1 -I/usr/local/src/alsa-cvs/alsa-driver/include
> > > -I/lib/modules/2.2.19/build/include -O2 -mno-fp-regs -ffixed-8 -Wa,-mev6
> > > -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
> > > -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
> > > -DKBUILD_BASENAME=memory_wrapper   -c -o memory_wrapper.o memory_wrapper.c
> > > memory_wrapper.c: In function snd_compat_vmalloc_to_page':
> > > memory_wrapper.c:35: warning: implicit declaration of function VMALLOC_VMADDR'
> > > memory_wrapper.c:39: warning: implicit declaration of function pgd_offset'
> > > memory_wrapper.c:39: warning: assignment makes pointer from integer without
> > > a cast
> > > memory_wrapper.c:40: warning: implicit declaration of function pmd_offset'
> > > memory_wrapper.c:40: warning: assignment makes pointer from integer without
> > > a cast
> > > memory_wrapper.c:41: warning: implicit declaration of function pte_offset'
> > > memory_wrapper.c:41: warning: assignment makes pointer from integer without
> > > a cast
> > > memory_wrapper.c:43: warning: implicit declaration of function pte_page'
> > 
> > it seems that configure script didn't detect these checks correctly.
> > could you check config.log ?
> 
> it seems that 2.2.19 kernel surely has these definitions.
> are you sure that you pass the correct kernel source path to configure
> script, or /lib/modules/2.2.19/build is symlinked to its kernel source
> tree?

Yes. I've found the lines in config.log and it's an alpha problem.
Thanks for that config.log hint. 

martin


configure:3194: checking for vmalloc_to_page
configure:3214: gcc -c -g -O2 -I/lib/modules/2.2.19/build/include  conftest.c 1>&5
In file included from /lib/modules/2.2.19/build/include/asm/semaphore.h:11,
                 from /lib/modules/2.2.19/build/include/linux/sched.h:17,
                 from /lib/modules/2.2.19/build/include/linux/mm.h:4,
                 from configure:3204:
/lib/modules/2.2.19/build/include/asm/current.h:4: global register variable follows a function definition
/lib/modules/2.2.19/build/include/asm/current.h:4: warning: call-clobbered register used for global register variable
configure: In function `main':
configure:3209: `vmalloc_to_page' undeclared (first use in this function)
configure:3209: (Each undeclared identifier is reported only once
configure:3209: for each function it appears in.)



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
