From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Thu, 25 Sep 2003 12:43:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309251238520.1362@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0309230903041.1405-100000@studcom.urz.uni-halle.de>
  <3F7001AF.C13AC3CC@srr.ro> <Pine.LNX.4.53.0309231107220.10953@pnote.perex-int.cz>
 <3F717ED7.15306C51@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F717ED7.15306C51@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Sep 2003, Andrei Boros wrote:

>
> Jaroslav Kysela wrote:
> >
> > > > Andrei Boros wrote:
> > > > > options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> > > > > irq=5 dma1=0 fm_port=0x380 mpu_port=0x300 mpu_irq=7
> > > I corrected it to 0x388. Doesn't work
>
> > > snd-isapnp module is not loaded automatically.
> > >
> > > If I load it manually, I see the following in the log :
> > > kernel: isapnp: Card 'OPTi Audio 16'
> > > kernel: isapnp: 1 Plug & Play card detected total
> > >
> > > Then modprobe snd-opti92x-ad1848 says :
> > > kernel: no OPTi 82C92x soundcard found
> >
> > Send us the contents of /proc/isapnp after 'modprobe snd-isapnp'.
> >
>
> modprobe snd-isapnp
>
> ---------------------------------------------------------------
> Card 1 'OPT0924:OPTi Audio 16' PnP version 1.0
>   Logical device 0 'OPT0000:Pro Audio 16'

This looks ok. It seems that you don't have compiled the ISA PnP support
for the module or something is broken. Could you check, if the snd- module
has references to pnp_* functions? (nm snd-opti92x-ad1848.o  | grep pnp_)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
