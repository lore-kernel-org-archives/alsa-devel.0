From: Frans Ketelaars <ketelaars@wanadoo.nl>
Subject: Re: can't compile
Date: Mon, 23 Sep 2002 13:10:19 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923131019.2332c921.ketelaars@wanadoo.nl>
References: <1032676882.752.116.camel@zen8100a>
	<1032735604.473.34.camel@zen8100a>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1032735604.473.34.camel@zen8100a>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 23 Sep 2002 10:00:04 +1100
Zenaan Harkness <zen@getsystems.com> wrote:

> Sorry if the list admin sends this through again - I didn't realise the
> list was moderated, or I would have joined before sending. Anyway, my
> problem report for compiling is below. Hoping someone can help.
> 
> 
> On Sun, 2002-09-22 at 17:41, Zenaan Harkness wrote:
> > I have kernel 2.4.19 + low latency patch.
> > 
> > Debian GNU/Linux testing/ sarge.
> > 
> > Here is compile error when I try to compile alsa-driver:
> > 
> > gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
> > -I/src/build/alsa-driver-0.9.0rc3/include -I/usr/src/linux/include -O2
> > -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
> > -Wstrict-prototypes -fomit-frame-pointer -pipe 
> > -DKBUILD_BASENAME=als100   -c -o als100.o als100.c
> > In file included from
> > /src/build/alsa-driver-0.9.0rc3/include/adriver.h:124,
> >                  from
> > /src/build/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
> >                  from ../alsa-kernel/isa/als100.c:23,
> >                  from als100.c:1:
> > /src/build/alsa-driver-0.9.0rc3/include/linux/isapnp.h:334: warning:
> > `struct isapnp_card_id' declared inside parameter list
> > /src/build/alsa-driver-0.9.0rc3/include/linux/isapnp.h:334: warning: its
> > scope is only this definition or declaration, which is probably not what
> > you want.
> > In file included from als100.c:1:
> > ../alsa-kernel/isa/als100.c:121: elements of array `snd_als100_pnpids'
> > have incomplete type

<snip>

> > make[1]: *** [als100.o] Error 1
> > make[1]: Leaving directory `/src/build/alsa-driver-0.9.0rc3/isa'
> > make: *** [compile] Error 1
> > 
> > -----------------
> > Here is my compile command:
> > /src/build/alsa-driver-0.9.0rc3# make install
> > 
> > -----------------
> > I have a hammerfall RME 9652 so I don't need to compile isa drivers. It
> > would be convenient to compile a drive for the on-board Intel sound:
> > output from cat /proc/pci:
> > 
> >   Bus  0, device  31, function  5:
> >     Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
> > (rev 5).
> >       IRQ 5.
> >       I/O at 0x1c00 [0x1cff].
> >       I/O at 0x1840 [0x187f].
> > 
> > --------------
> > uname -a:
> > Linux myhost 2.4.19 #1 Fri Sep 20 21:18:31 VUT 2002 i686 unknown
> > 
> > TIA
> > Zen

See http://www.alsa-project.org/ :

Latest News     page 1 of 4    2002-08-22  Note for compiling alsa-driver-0.9.0rc3:
 Please remove the file - alsa-driver-0.9.0rc3/include/linux/isapnp.h - before 
running the configure script.

HTH,

    -Frans


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
