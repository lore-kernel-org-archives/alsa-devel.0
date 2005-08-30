From: Harald Welte <laforge@gnumonks.org>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 16:36:36 +0200
Message-ID: <20050830143635.GH4221@rama.de.gnumonks.org>
References: <s5hhdd73glc.wl%tiwai@suse.de> <200508301149.46320.rene@exactcode.de> <s5hek8b3fpu.wl%tiwai@suse.de> <s5h7je33d59.wl%tiwai@suse.de> <20050830122423.GC4295@rama.de.gnumonks.org> <s5hek8bk34d.wl%tiwai@suse.de> <20050830130652.GI4295@rama.de.gnumonks.org> <s5hacizk1mf.wl%tiwai@suse.de> <20050830135940.GA4221@rama.de.gnumonks.org> <s5h1x4bjyxy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1x4bjyxy.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 04:12:41PM +0200, Takashi Iwai wrote:
> At Tue, 30 Aug 2005 15:59:40 +0200,
> Harald Welte wrote:
> >=20
> > > Could you try to tune this manually by writing like
> > > 	# echo 7a 40b2 > /proc/asound/card0/codec97#0/ac97#0-0+regs
> > > as root?
> >=20
> > done.  doesn't change anything.  I again re-tried with EA on/off and
> > headphones plugged in and not plugged in.  It still behaves exactly like
> > the original kernel.
>=20
> It's a pity.  Just to be sure, compare the value of 0x7a in
> /proc/asound/card0/codec97#0/ac97#0-0+regs file after the procedure
> above.

yes, I did that.  the register has been set to the value I wrote to it.

> I have no other clue yet...

No problem, it's not all that important... I didn't buy the device
because of it's lousy notebook speakers anyway ;)

Thanks again,
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFG7zXaXGVTD0i/8RAg+sAJ9OjWJPX7J9J3JQMcyTL2eRvMwdrgCbBT9k
KmjddjppV17WsCn1odHp0yM=
=cjjO
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
