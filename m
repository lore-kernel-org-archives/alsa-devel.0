From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Tue, 20 Apr 2004 22:39:31 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040420183931.GB2166@sirius.home>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de> <200404201939.54966.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200404201939.54966.bero@arklinux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2004 at 07:39:54PM +0200, Bernhard Rosenkraenzer wrote:
> On Tuesday 20 April 2004 12:39, Takashi Iwai wrote:
> > > Hi,
> > > On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22=
),
> > > snd_ali5451 loads and can adjust mixer settings (except for PCM volum=
e,
> > > but I think that's a limitation of the hardware), but doesn't make any
> > > noise - apparently PCM is always muted (volume fixed at 0?).
> >
> > there is no PCM volume on CM9739.  it has only PCM mute switch.
> > you can mute on/off via 'M' key of alsamixer.
>=20
> I knew that -- it doesn't make any sound even if it's unmuted though.
> Nothing useful in dmesg output either.

And what does "amixer contents" show?

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhW5jW82GfkQfsqIRAudmAKCOEF0H0vYM09oYKqChjaKlzmnzEQCeICWo
//A7X8lm0iGinphj6usd3SY=
=S2bf
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
