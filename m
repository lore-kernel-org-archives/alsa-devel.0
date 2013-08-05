From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
	depop
Date: Mon, 5 Aug 2013 15:48:08 +0100
Message-ID: <20130805144808.GG9858@sirena.org.uk>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2604132482506955286=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F08FB26160D
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 16:48:13 +0200 (CEST)
In-Reply-To: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2604132482506955286==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xCVEtYh6KEJlbT+/"
Content-Disposition: inline


--xCVEtYh6KEJlbT+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 12:19:03PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> Add mute/unmute control in widget event and modify the power on/off seque=
nce to avoid pop noise.

This looks like you should be using Lars-Peter's patch for controls that
are disabled while a widget isn't powered - as far as I can tell from a
quick read through all this does is keep the speaker/headphone muted
while the outputs are powered down.

--xCVEtYh6KEJlbT+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7slAAoJELSic+t+oim9ejkP/3pjqBBgyenzT55d3czgohqD
N9LZvkXyYcR7ELGxkbELOOiZoU1Fzy1uQI3Q+ZMG0RRqJE7qQ/0s9Ly3uh6sOS5T
s1qkQ81pynPAl4X5qiCTRCb5vf9dD/iRnxcXB9NvYzLP4hCtYzRkg8mX0Vy5CXwG
WRS/RHfMKsX2hrX45S0aieAFdGnUpyIsk3lMln53L4VLqrzFIom+vDWDQjjTAUlT
L27okVqDbJgpK1a+Xz4pGql5tjjLeqnfHKat9Z7R2XSywwohf2yfABeWlpP5i9YU
lK+78Tqs8LnqrzBpFwvUL8F2GSiDbt7VPzXN0ZAijLJuU8REvggb9cuPjb00G2ff
ZDn0M3uLgUcfPZk9aPaBWTElML/+G69CUIoDxKgC4VfqsdaJN7NMTF/OZh2lhIRe
o4SIazMD4Kh4JoXDO+88F08xIoDywSS/CLBQXSKUDS3od8dzP04KHA9Rh6nesR/Q
jvc5UuPfSouWUO1V4cI5xQ2ZYaDdCxmDRc/igq0hIXquw5ujzQTR4tMUfOBdzp+Y
naK5bhk8frGIxsy6rRm2N7WN8S2b7uy2upYsBDCpHsv0jlVDGP2C7ki4IR48hqiE
+gjZLsX1ckhYBVmGhHF74aiY0JYrrE0rwGSjb8f7AolZhi9UXXiO0cfGOHmAmiBN
cSYiHPSzaPjg1ZBJfAga
=190E
-----END PGP SIGNATURE-----

--xCVEtYh6KEJlbT+/--

--===============2604132482506955286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2604132482506955286==--
