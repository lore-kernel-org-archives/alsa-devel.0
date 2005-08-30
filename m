From: Harald Welte <laforge@gnumonks.org>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 15:59:40 +0200
Message-ID: <20050830135940.GA4221@rama.de.gnumonks.org>
References: <200508291419.34270.rene@exactcode.de> <200508301130.42008.rene@exactcode.de> <s5hhdd73glc.wl%tiwai@suse.de> <200508301149.46320.rene@exactcode.de> <s5hek8b3fpu.wl%tiwai@suse.de> <s5h7je33d59.wl%tiwai@suse.de> <20050830122423.GC4295@rama.de.gnumonks.org> <s5hek8bk34d.wl%tiwai@suse.de> <20050830130652.GI4295@rama.de.gnumonks.org> <s5hacizk1mf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hacizk1mf.wl%tiwai@suse.de>
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


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 03:14:48PM +0200, Takashi Iwai wrote:

> > However, I didn't reboot, I just unloaded snd_atiixp and snd-pcm-ac97
> > (unpatched), loaded snd-pcm-ac97 (patched) and snd_atiixp on top of it.
> > Will try a "clean boot" just now.
>=20
> Reloading modules should work...

Rebooting didn't change anything either.  But I thought I'd try it just
to make sure=20

> > > Anyway, could you attach the contents of
> > > /proc/asound/card0/codec97#0/* files again after the patch?
> >=20
> > See below.
> (snip)
> > 0:7a =3D 40b0
>=20
> Hmm, the bit 1 isn't set, i.e. the patch didn't do the right job.

strange.

> Could you try to tune this manually by writing like
> 	# echo 7a 40b2 > /proc/asound/card0/codec97#0/ac97#0-0+regs
> as root?

done.  doesn't change anything.  I again re-tried with EA on/off and
headphones plugged in and not plugged in.  It still behaves exactly like
the original kernel.

Thanks again.
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFGZMXaXGVTD0i/8RAofBAKCWP84zux2DMR8wdwMKUoeLd3t3PACdF1Re
IU4W+pPC5AoHPqWcBTtAB1Y=
=lbxt
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
