From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1701: add regulator consumer
	support
Date: Sat, 18 Apr 2015 14:23:22 +0100
Message-ID: <20150418132322.GV26185@sirena.org.uk>
References: <1429008420-1566-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8911532169810920433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1429008420-1566-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: patch@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8911532169810920433==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KxKI/R+N9hudrWbn"
Content-Disposition: inline


--KxKI/R+N9hudrWbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2015 at 12:47:00PM +0200, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
>=20
> The adau1701 has two power domains, DVDD and AVDD.
> Enable them both as long as the codec is in use.
> ---

This looks fine but I can't apply it because you've not signed it off -
I need a signoff for anything that's going to mainline.  Please see
Documentation/SubmittingPatches.

--KxKI/R+N9hudrWbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMlrFAAoJECTWi3JdVIfQ5zYH/RHmKNs7eNsUSAI3uuPN34hi
M4fS4TibX3UNztMd4kArdpWxKfK2bJhnowKAhFAJ94owonfhdN6l707toPYMoBgq
QwfhKIhliHCQXtn//Pq3BKbbYOU/nSr1n2s2DHxeIQpiGQX2XtzRHRatNXaMR4yR
WMpqtnqVJrn8mDL7cJe0cVrH0Z4WGzdsbHF5yjGh8sZP8KF0W1O6u4ozsvFnRYrl
ztw8Efm+Tm/JVNTxoP3/+YVuU2MVAhlQmWL2k5O4WJY2luY0yGjg6BBOE+j+0UBs
KvlSEGkVEztsS0sbkGbh720G9hzmK8mjuUNWwHrZOh7AaXVLFBme2jP+3no8wdY=
=985j
-----END PGP SIGNATURE-----

--KxKI/R+N9hudrWbn--

--===============8911532169810920433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8911532169810920433==--
