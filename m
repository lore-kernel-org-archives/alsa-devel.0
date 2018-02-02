From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: fix debugfs read using
	path->connected
Date: Fri, 2 Feb 2018 16:53:40 +0100
Message-ID: <20180202155340.GC7101@sirena.org.uk>
References: <1517555015-19080-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7946392473666580064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D968326791F
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 16:53:44 +0100 (CET)
In-Reply-To: <1517555015-19080-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kaichieh.chuang@mediatek.com
Cc: alsa-devel@alsa-project.org, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, srv_wsdupstream@mediatek.com, shane.chien@mediatek.com, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7946392473666580064==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 03:03:35PM +0800, kaichieh.chuang@mediatek.com wrot=
e:
> From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
>=20
> This fix a bug in dapm_widget_power_read_file(),
> where it may sent opposite order of source/sink widget
> into the p->connected().

This doesn't apply against my tree or Linus' tree, can you please check
and resend?  The change itself seems to make sense.

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp0iYMACgkQJNaLcl1U
h9BglAf/fo2O6Zgl5GMwF7xw7/970LIln1aK++VVLzx1mGyjDJuoivOfjuGxhV57
Oz/zi6Z9alcxOdA651zgOeLg27TM7jwkKIqJv1tGzoCGYdFAzUrEJpeNETrhXBpS
frISC1dL75o4hiSA/I3cFJ4Q9TZWj/mkPWZVy+PR4fOr4Ew84WoM4P0qLvPU1mh0
o3aJAx4rSn8Ru2ooIHNa9qhCYG7CUMF2iys21oL4qbv51vo6g6URuS6wfGzHEYmw
hHp0w42uEn0QctSTVmN3NQOEu6/vh0SxOHIgI2zzIYfFKvX/ToB3KlFT04JdmyBh
hAmzenanOF8ESeq9qQdDR1mwdT3/fQ==
=wCBf
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

--===============7946392473666580064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7946392473666580064==--
