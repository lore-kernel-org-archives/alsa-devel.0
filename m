From: Tim Goetze <tim@quitte.de>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Thu, 19 Sep 2002 16:35:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209191627530.595-100000@summer.quitte>
References: <s5h7khiqh4g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7khiqh4g.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>since the old ice1712.c is still compiled as default, you'll have to
>run "make" on alsa-driver/pci/ice1712.  the new files are not compiled
>otherwise.

[~/audio/alsa-cvs/alsa-driver] make -C pci/ice1712
make: Entering directory
`/home/tim/audio/alsa-cvs/alsa-driver/pci/ice1712'
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/home/tim/audio/alsa-cvs/alsa-driver/include
-I/lib/modules/2.4.19-ll/build/include -O2
-mpreferred-stack-boundary=2 -march=k6 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAME=ews
-c -o ews.o ews.c
In file included from ews.c:1:
../../alsa-kernel/pci/ice1712/ews.c: In function
`snd_ice1712_ews_init':
../../alsa-kernel/pci/ice1712/ews.c:403: parse error before `*'
../../alsa-kernel/pci/ice1712/ews.c:406: `ak' undeclared (first use in
this function)
../../alsa-kernel/pci/ice1712/ews.c:406: (Each undeclared identifier
is reported only once
../../alsa-kernel/pci/ice1712/ews.c:406: for each function it appears
in.)
make: *** [ews.o] Error 1
make: Leaving directory
`/home/tim/audio/alsa-cvs/alsa-driver/pci/ice1712'

i don't have a clue what gives. was my make invocation wrong? 

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
