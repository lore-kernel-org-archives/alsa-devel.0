From: Harald Welte <laforge@gnumonks.org>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Fri, 2 Sep 2005 13:10:35 +0200
Message-ID: <20050902111035.GC4759@rama.de.gnumonks.org>
References: <s5h7je33d59.wl%tiwai@suse.de> <20050830122423.GC4295@rama.de.gnumonks.org> <s5hek8bk34d.wl%tiwai@suse.de> <20050830130652.GI4295@rama.de.gnumonks.org> <s5hacizk1mf.wl%tiwai@suse.de> <20050830135940.GA4221@rama.de.gnumonks.org> <s5h1x4bjyxy.wl%tiwai@suse.de> <20050830143635.GH4221@rama.de.gnumonks.org> <s5hacivvl8z.wl%tiwai@suse.de> <s5h7jdzvks4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7jdzvks4.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2005 at 12:14:35PM +0200, Takashi Iwai wrote:
> At Fri, 02 Sep 2005 12:04:28 +0200,
> I wrote:
> >=20
> > Could you try the patch below?
> > The point of the patch is to turn on reg 0x74 0x0800.
>=20
> There was a typo.  The fixed patch is below.

Thanks, I'll try later this afternoon. =20

btw: In case this doesn't work, please don't invest any further time
into this.   The device was actually a GPL violation, and as I now see,
the vendor-provided kernel objectcode (based on 2.6.6) produces correct
sound output, whereas the sourcecode they ship doesn't.  So I've now
asked my lawyer to send them a nice letter indicating that the soucre
code they provide is not the "full corresponding source code" and that
they need to publish the changes they did - including those that make
the speakers work :)

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGDMrXaXGVTD0i/8RAo4+AJ91V6wFEoDfmm/oRpw8M7AustKXIwCfT2m9
j3O4UNfRT3OGGUXXh+L/LwI=
=+2oc
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
