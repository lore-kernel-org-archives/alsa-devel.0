From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
	RT5642
Date: Tue, 22 Apr 2014 12:53:47 +0100
Message-ID: <20140422115347.GR12304@sirena.org.uk>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2909304962253605122=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A5AB261A9F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:53:57 +0200 (CEST)
In-Reply-To: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, jarkko.nikula@linux.intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2909304962253605122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/TTpdoN/8xAVVIu"
Content-Disposition: inline


--j/TTpdoN/8xAVVIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 10:24:06AM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We have been using rt5640.c codec driver with RT5642 codec chip before co=
mmit
> 022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts us=
ing
> device ID reading in reset register for adding device specific controls a=
nd
> routes runtime.

Applied, thanks.  Now I look again and remember that it exists I see
there's no update to the DT portions of the code - please submit a
followup patch adding the device to the DT bindings and to the OF match
table.  rt5639 is also missing there.

--j/TTpdoN/8xAVVIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVlhIAAoJELSic+t+oim990IP/1iP/tbZGWET4QHkJxu27dk/
XK5hlRJVmNoYs1WGhNQXaTqAb5WT3Ic8+2W9ui1rhl8Q4n5Tak73D0KzPtx96L9w
kpK+z8M4ckPXdIG//Oz7syGcE3fj2NadIKtTzctEsEMwqYgPoFz06J+6kerJb2D2
b88N1e7LDmuyDqfvHmtrjP3c9tNzDUc8/9oaqYzCuXvd+fE/EOPvDbLHwVB+sVp+
aw5iSMo3TL843Nf+Q7KokmesNKAWCp9LV2kwCdMZWGx9x5T5S6E4ncFUMmnzutXC
+5ddWTBgJqkk+iMh6T74haVth6mNkkyRN9Fe/QZXYKaP2r04kInhcyRbvKIG/rfd
jT6isFSaYSFEnG4Irv+ZeOG/g9JzEMRZ/IpKDxpulQ1sU4iPaN5pKiQyFyeJuMzW
QGtHfc+vGOCzNDFBNXfeYIb4surRpw50mNCf8vi6/d9C6l+hcUjH/0FRetNGZBm7
1k97uRjatRs9l19HEomauKRVxgfrAaVkoPQd/OA5OT5ceqW7mmUpC7a5x3C0fvTd
RWThhbZBHoY6RDdEpif17UiB8p946WjfleF13Ma1jycwmWkdH066dmh45tQYULXm
WYazAWBsRmAcJoCGKRLb+a5OccI/L+x15DunPUGr2qVOs/15PJrHKwRXszmBWQ+k
r53dIQh+gDB/HynCq9V0
=QKWJ
-----END PGP SIGNATURE-----

--j/TTpdoN/8xAVVIu--

--===============2909304962253605122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2909304962253605122==--
