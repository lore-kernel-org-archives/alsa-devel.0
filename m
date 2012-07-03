From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 1/2] ASoC: STA529: Add support for
	STA529 Audio Codec
Date: Tue, 3 Jul 2012 20:03:00 +0100
Message-ID: <20120703190300.GA29030@opensource.wolfsonmicro.com>
References: <cover.1341312609.git.rajeev-dlh.kumar@st.com>
	<0fec3fec69088f016a1093da6dab010a8eb4e599.1341312609.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2658616328961191567=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 156A71042A0
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 21:03:02 +0200 (CEST)
In-Reply-To: <0fec3fec69088f016a1093da6dab010a8eb4e599.1341312609.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============2658616328961191567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVTyp1F/hrbhzAAs"
Content-Disposition: inline


--JVTyp1F/hrbhzAAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 05:24:58PM +0530, Rajeev Kumar wrote:

> +=20
> +	/* set FFX audio frequency range */
> +	val =3D (((val & 0x83) | (play_freq_val << 4)) | (record_freq_val << 2)=
);
> +	snd_soc_update_bits(codec, STA529_MISC, FREQ_RANGE_MSK, val);

This is more buggy than last time, it's still setting both playback and
record configuration but instead of using update_bits() like write()
it's now using val uninitialised.  As I said last time it looks like you
want to move this into the playback/capture if statement immediately above.

--JVTyp1F/hrbhzAAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP80HeAAoJEBus8iNuMP3dGh0P/2x7py10PCL6EsaXeWwdzF6E
7Rew97SYFrcZeXawGBwaziOytL7gb4MInClBdeddbEaXI79P9VXMGOqNTxeo2o2U
vzzutFooFo4ahNdRT8T1qtSfu/GUjjNFeuykwpMacKy5Kyp/2/LhjSuqtZ9yk8Pf
Hz7ju9Dy76H1Bh0YSzb8hYfxvXJ57fngg3T79PoLRnvmFMHj27RVsg2T8VBPs9at
6aLS4XT3/BEcBWz0GzZvKPmIrjVPhKN/VDwYmT5qOzQnldTeHVtwdhYun3qh7CuH
ZWuNrfeWGCrYk3+JyVYUM74iPlU/jIGwN04MEwzaberLemxQkIjmagusjb/mZGBL
opZmpsyQOTGgSLiVDBQPkQJtyWHe/O/Z1t/Wq5OBW79n3dddvsYEjs6LiiQivpga
DBZ6XSNHiJs1CmBjwO6eSJj0jAtmlmKYf3fqflnTNKI0JTcFi3DjMnubTxB4Foil
fl3RqVuq0IxShLCM99BLlqu2Urg/38//ldKRWtBNIbwDPjJVTUf2BkQXB/lMyGhq
P1pG0jLZHycBwAzVh+P2vgc3lj1PYqc/5PQhHVbHsOhCfIzlWlaOZVG1uPfl8sta
i9wxJ5UvlBbgC5CZb2sNaAVNSm0maxGYowtEVMxmPxnngeTHXZZF0CzsleK97Glu
aIdXVFurbrIjgLxXGXaG
=hP5x
-----END PGP SIGNATURE-----

--JVTyp1F/hrbhzAAs--

--===============2658616328961191567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2658616328961191567==--
