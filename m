From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 7 Jun 2005 19:17:40 +0200
Message-ID: <200506071917.42953.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <s5hwtp6w2nw.wl@alsa2.suse.de> <42A5D3C8.1030903@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5869351.FrFdCTNqtf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A5D3C8.1030903@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Igor Kovalenko <garrison@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart5869351.FrFdCTNqtf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op dinsdag 7 juni 2005 19:05, schreef Igor Kovalenko:
> Takashi Iwai wrote:
> > At Tue, 7 Jun 2005 17:16:02 +0200,
> >
> > Alien wrote:
> >>[1  <text/plain; iso-8859-1 (quoted-printable)>]
> >>
> >>Op dinsdag 7 juni 2005 17:05, schreef Raymond:
> >>>The patch (diff11.diff) cause segmenation fault on my 32bit machine
> >>>during /etc/init.d/alsasound start
> >>>
> >>>http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948
> >>>
> >>>Do anyone know why readl() and writel() behave different in i386
> >>>(32bits) and AMD64 (64bits) ?
> >>>
> >>>http://sourceforge.net/mailarchive/message.php?msg_id=3D10773530
> >>>
> >>>
> >>>#ifndef CONFIG_X86_64
> >>>
> >>>#define        hwread(x,y) readl((x)+((y)>>2))
> >>>#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
> >>>
> >>>#else
> >>>
> >>>#define        hwread(x,y) readl((x)+(y))
> >>>#define        hwwrite(x,y,z) writel((z),(x)+(y))
> >>>
> >>>#endif
> >>
> >>that doesn't look good, unless the mmio is void* in 32bit and unsigned
> >> long* in x86_64...
> >>
> >>'unsigned long* mmio' should be preferred and together with '#define
> >>hwread(x,y) readl((x)+(y))' , this works for both platforms
> >
> > I guess using "unsigned long" for both architectures is broken, too.
> > Should be "u32" to be arch-independent.
>
> I strongly believe readl() and writel() on x86_64 does 32 bit reads/write=
s.
> (checked linux-2.6.12-rc5). Therefore reads/writes are of correct size wi=
th
> that patch - should be something different.

i know that does not work!

when i started doing this, i got segfaults because of the >>2 .

readl and writel do long operations as evidenced by the 'l'

i know this seems weird, but this is memory-mapped, and appearantly it's=20
memory mapped to long, anyway; when i do 'unsigned long* mmio' and i use=20
readl and writel without any bitshifts, it works...

you may believe what you want, but i _know_ that on x86_64, i _NEED_ unsign=
ed=20
long* mmio and no bitshifting to get this to work.

maybe the problem lies with writel and readl to begin with, maybe if you wr=
ote=20
an int, it would work...

AL13N

--nextPart5869351.FrFdCTNqtf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpda2uBWKXETrtdcRAmYqAJ9ZOIQYNE2qpmcf5H4fK+nZVdF+ZgCdGmo3
NKrr+45fYtPMrjjDDLtqDNk=
=2GKR
-----END PGP SIGNATURE-----

--nextPart5869351.FrFdCTNqtf--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
