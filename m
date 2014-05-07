From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: dapm: Skip CODEC<->CODEC links
 in connect_dai_link_widgets()
Date: Wed, 7 May 2014 14:55:49 +0100
Message-ID: <20140507135549.GH22111@sirena.org.uk>
References: <1399467948-8770-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4231169764333459787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 332092652CD
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:56:35 +0200 (CEST)
In-Reply-To: <1399467948-8770-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4231169764333459787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hix8K3b8kRbLLbv+"
Content-Disposition: inline


--Hix8K3b8kRbLLbv+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2014 at 03:05:44PM +0200, Lars-Peter Clausen wrote:
> For CODEC to CODEC DAI links the paths are already created in
> snd_soc_dapm_new_pcm(). Make sure to not create additional connections in
> snd_soc_dapm_connect_dai_link_widgets() for CODEC to CODEC links.
>=20
> Fixes: b893ea5 ("ASoC: sapm: Automatically connect DAI link widgets in DA=
PM graph.")
> Cc: stable@vger.kernel.org (for 3.14+)
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Why is this tagged for stable - is there a non-cosmetic issue here (your
commit log doesn't make it apparent if there is?

--Hix8K3b8kRbLLbv+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTajtdAAoJELSic+t+oim977kP/2DG1bdOoVi2AQii7UFJaWQg
bDFqbFuHufEiu6FPjOWg2pIh8jMBV2EsHcKknrAzv67YBS/LGKu1912CwmbHkGba
h1idB7OVPyqx489oClligR0FB01x3M8B6tCUPTBYf4Ekh8OjXgVgF10iHNcTK3DX
Zy7nOY+JdJ5ZOpglVZ6JpkbaaTe45/+RA06NNzrOTwq+TMBomDbJynS6FFP5T7A7
GvuH7O5Na5u7AnY3KvSaAnx24Dph1z0w3cChOWpnlJgBDQSP3QWNFzE3qAKQNTR8
/udYP7hxetfVQ3rVrVwrrVhYRB3cohuvKOyvaJZQjHi8Et1oYIU24MaSyXgngu2b
DQ7SskrrotTpaEa8R5iOGI+cL/sAFqPdTNyGn6CKbDUYNy53DbPm+zlAtmXkI1U1
8WaWOZLGaYHKvhRZoGsAJjmjHm/IOduUT0jiHqps3sZg3j1MMnrZ77V3pqwYAsNC
P0SKeIPZ9eyHA9cnZxAAHuCT21KnBZbI0SiZTJngC0Xp7rcxCZ3sR7RrEFYBeQry
Cf1N9i0WpDlYPMP1Oa6boL0wJuZGaIu9YaqgDAIhvo5mXi80NPvSWJB0CWtsHv8r
jPjY1EX81EPNtPLRdKHA4kvhrGCPBFGQAdZmbOphYTA3D27OIKqJFSCYljrJzsRd
5exkeuBGjZ2AITdwvGp0
=DGIp
-----END PGP SIGNATURE-----

--Hix8K3b8kRbLLbv+--

--===============4231169764333459787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4231169764333459787==--
