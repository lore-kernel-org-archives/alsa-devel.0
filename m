From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Tue, 23 Sep 2003 11:07:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309231107220.10953@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0309230903041.1405-100000@studcom.urz.uni-halle.de>
 <3F7001AF.C13AC3CC@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F7001AF.C13AC3CC@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Sep 2003, Andrei Boros wrote:

> Clemens Ladisch wrote:
> >
> > Andrei Boros wrote:
> > > options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> > > irq=5 dma1=0 fm_port=0x380 mpu_port=0x300 mpu_irq=7
> >
> > You've specified all parameters manually, so you could try to disable
> > ISA PnP (isapnp=0).
> >
> > And fm_port must be 0x388 (0x380 is the OPL4 port, which is detected
> > automatically if you have an OPL4).
> >
> I corrected it to 0x388. Doesn't work
> Completely commented the line. Doesn't work
> Changed to isapnp=0. Doesn't work.
>
> Again: the card is Opti924 in ISA slot.
> modprobe returns :
> /lib/modules/2.2.24/misc/snd-opti92x-ad1848.o: init_module: Device or
> resource busy
> snd: Device or resource busy
>
> snd-isapnp module is not loaded automatically.
>
> If I load it manually, I see the following in the log :
> kernel: isapnp: Card 'OPTi Audio 16'
> kernel: isapnp: 1 Plug & Play card detected total
>
> Then modprobe snd-opti92x-ad1848 says :
> kernel: no OPTi 82C92x soundcard found
>
> All documentation I found so far says that my 924 card uses the ad1848
> chip, so I compiled only this module.

Send us the contents of /proc/isapnp after 'modprobe snd-isapnp'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
