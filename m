From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: firmware: Add support for FW
	based kcontrols.
Date: Tue, 20 Nov 2012 11:11:12 +0900
Message-ID: <20121120021111.GY4483@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1975359439710353326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D3DFD264F6A
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 03:11:19 +0100 (CET)
In-Reply-To: <1353348765-6238-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1975359439710353326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hkxLWrKAgbGf75mf"
Content-Disposition: inline


--hkxLWrKAgbGf75mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 06:12:42PM +0000, Liam Girdwood wrote:
> This patch adds initial support for firmware based kcontrols by allowing
> soc.h to be included by any userspace firmware generation tools and assigns
> IDs to the standard ASoC kcontrol types using the kcontrol_new index and IDs
> to kcontrol get/put/info functions.

Applied, thanks.

Should really be two patches, one for the new ifdefs and one for adding
the IDs.

--hkxLWrKAgbGf75mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqua4AAoJELSic+t+oim9aQ8P/jjS/65A44D8rxe31YjzX9cg
ZVLdBpaRWjG953NlODCxBVe0sAplKG+HSLPPEmJtHBFzLkqBWkYSBd1nfXvkrLR9
1A1s6FpIYsn15AkUo0BOCtAFcomiKBFbxuz1VGCue7FHE9qXeyjKzdAT7i+dQauU
wdu06Y6YrJKPAdpLbzF9BGZ/aAb3CGQvKxg5eClro4Okhqfur4iZiv/y9UQ+6yxp
YxDOgXKmd8gBQIBhK29S+hERgVEWsFpR1G+16vBt2IHNmMYNglLLE1++PHGGvDi2
d0Bs6KYfG853spaeoooxawi66vv5QWJRdNY/wOixtT86z3mOaxyThjavdpFByq5w
ls/7ZkhcLhAkiuTaOvmgvUPl0lRGevNDHC25HXUVngdIl/a3tfrq61Xf3fBVvZhu
SgUudnLO4EfDsqKdah6YmjtF/9uNn/tdcT+mO/4yNntWMI/1roWSlU0uWxu9EMVS
x+bogRpCS6txf7dJ50PCpt3nJUfjSVeI4BvzSGYh0y/oZcNbK+MpO5Gm3bYbx8d+
lPaZm4vQPXava7m4pLJPBp6tT3se34DFht8ZnTHZvnO4a8n+NOBEMQ/8aWnJWoMn
rexJpnGFvbF/y2wTDjlHrP8dYQhFGyfuJFABmOcr0bCnOhGOAKMUclgspEASYG4e
X6Uk2i+FJMSENrp4GuVI
=LPiY
-----END PGP SIGNATURE-----

--hkxLWrKAgbGf75mf--

--===============1975359439710353326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1975359439710353326==--
