From: Santiago Otero <santiago@atlas.uvigo.es>
Subject: Re: Request for tests: scatter-gather dma support
	on	via686 and emu10k1
Date: 22 Jul 2002 18:21:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027354918.1225.9.camel@atenea>
References: <s5hheivr5xl.wl@alsa2.suse.de> <1027166734.759.8.camel@atenea>
	<s5hptxgovji.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptxgovji.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

El lun, 22-07-2002 a las 13:24, Takashi Iwai escribi=C3=B3:
> Hi,
>=20
> At 20 Jul 2002 14:05:33 +0200,
> Santiago Otero wrote:
> >=20
> > El vie, 19-07-2002 a las 19:19, Takashi Iwai escribi=EF=BF=BD:
> > > Hi,
> > >=20
> > > i just added the support of scatter-gather (sg) dma support on some c=
hips.
> > > some chips such like via686 and emu10k1 have sg dma function, which
> > > enables to use discontiguous pages as buffer.  hence we'll have almos=
t
> > > no memory allocation problem on these chips.
> > >=20
> > > on via686 and emu10k1, the playback (and capture for via686) buffers
> > > are no longer preallocated but allocated always dynamically
> > > (preallocation doesn't make sense for sg buffers).
> > >=20
> > > on via686 driver, there is a new constraint.  the period byte size
> > > must be in power of two, to make sure that the period is aligned to
> > > the kernel page size.  i don't believe that this matters, though.
> > >=20
> > > there are some other chips with this function, via8233, intel8x0 and
> > > trident.  they will be supported eventually soon.  (the porting must
> > > be easy but i have no hardware :)
> > >=20
> > >=20
> > > anyway, if you have an emu10k1 or via686 soundchip, please test the
> > > latest cvs version of alsa-kernel/alsa-driver.
> > >=20
> > >=20
> > I've got a via686. I've tested cvs version of alsa-driver and here are
> > my results:
> > -OSS emulation works fine
> > -xmms, mplayer, xine, ogg123 work fine
>=20
> ok.  thanks for your tests.
>=20
> > -all my own applications that before were working  now  sound bad. I am
> > working on the problem
>=20
> this might be related with the period size restriction.
> how did you set the period size?
> please check /proc/asound/card0/pcm0p/sub0/hw_params and
> which condition is used.
>=20
>=20
I was using default period size. Setting period size to 1024 makes my
application work again.

Thanks.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
