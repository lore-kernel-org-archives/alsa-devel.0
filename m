From: "Jared D. McNeill" <jared.mcneill@gmail.com>
Subject: Re: intel8x0m and conexant ac97 modem codecs
Date: Fri, 22 Apr 2005 09:30:34 -0300
Message-ID: <41d6f0b905042205302d5f5068@mail.gmail.com>
References: <41d6f0b90504120905d469db0@mail.gmail.com>
	 <1113329101.31159.23.camel@mindpipe>
	 <41d6f0b905041211143edfd71e@mail.gmail.com>
	 <20050413212806.GB1096@tecr>
	 <41d6f0b9050413155325e269c4@mail.gmail.com>
	 <20050414103910.GA12914@tecr>
Reply-To: "Jared D. McNeill" <jared.mcneill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050414103910.GA12914@tecr>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Jared D. McNeill" <jared.mcneill@gmail.com>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, jmcneill@netbsd.org
List-Id: alsa-devel@alsa-project.org

On 4/14/05, Sasha Khapyorsky <sashak@smlink.com> wrote:
> On 19:53 Wed 13 Apr     , Jared D. McNeill wrote:
> >
> > I've looked at the SmartMC II datasheet -- it doesn't even document
> > the EXT_MODEM_CTRL register! From what I've read about Conexant HSF
> > modems, it looks like the majority of them need firmware to be loaded
> > before they're usable; I don't see any documentation on how to do this
> > in the AC-Link version, but I wouldn't be suprised if this was the
> > case.
> >
> > I'm unfortunate enough to have a CXT codec in my laptop (Dell Latitude =
D600):
> >   auich1 at pci0 dev 31 function 6: i82801DB (ICH4) AC-97 Modem
> >   auich1: interrupting at irq 11
> >   auich1: ac97: Conexant D480 MDC V.92 Modem codec; no 3D stereo
> >   auich1: ac97: ext mid 4001<LINE1>, secondary codec
> >   auich1: codec not responding, status=3D0xff00
>=20
> How could I look for NetBSD driver sources?

http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/ic/ac97.c
http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/pci/auich.c

Cheers,
Jared


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
