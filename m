From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 17:21:54 +0100
Message-ID: <20160518162154.GP8104@sirena.org.uk>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <209086304.1BTKYSBN0B@ws-stein>
 <20160518152820.GN8104@sirena.org.uk> <1574831.WL8kGhHEjA@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2872896758118341049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69DFF26605D
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 18:22:02 +0200 (CEST)
In-Reply-To: <1574831.WL8kGhHEjA@ws-stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2872896758118341049==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmVHo2jXx4bdYlgS"
Content-Disposition: inline


--cmVHo2jXx4bdYlgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 18, 2016 at 05:50:50PM +0200, Alexander Stein wrote:

> My first idea was to use dev_dbg() but that actualy remove that message a=
t=20
> all, unless dynamic debug is used, so I went with dev_notice. It's still=
=20
> there, but does not clobber quiet boot log, nor some sophisticated kernel=
 log=20
> parser as journalctl which prints errors in red color.

It's just shifting the problem around...  it sounds like for your use
case suppressing the messages until we finish kernel boot would deal
with most of the issue in a far more general fashion.

--cmVHo2jXx4bdYlgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPJahAAoJECTWi3JdVIfQfwYH/iR8JSjvAuQFSf783YRskEGg
/fjq6uw5Sy9bt+tSa2RN8nlSvKcVXHRTA61sblL2SCzdq1RVrWRjAcyhRY/oek25
/GFZ0wlOStMxMeI50t8ET+7Jpz8cQ+PHDerwiN8RRRSukEB4DNR52JmtL0pK/6Pp
gLIbxJzMsBsKQ6bvGS3LQOPAYF/ITXwdqe0RYB0gS2plgex5TdM3lLa9dyc5CW3X
N9QL0Wn1IK2DyWelKElehaIpAZqJj4Vhu3G54AdW94rAlI72CmoW/BRXiW5GIK6Q
rvVwTxq9s9NTdLEG2gE5OMgduSRbXhsrBYPi02wNyP//K/xHDI6Rt5OkcSfhaPQ=
=YhL5
-----END PGP SIGNATURE-----

--cmVHo2jXx4bdYlgS--

--===============2872896758118341049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2872896758118341049==--
