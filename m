From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: fsl_ssi: Switch to SPDX
	identifier
Date: Wed, 2 May 2018 05:51:41 +0900
Message-ID: <20180501205141.GF2714@sirena.org.uk>
References: <1525132518-27663-1-git-send-email-festevam@gmail.com>
 <83529f99-dfa0-25d3-fa2c-fd69a74c3ead@tabi.org>
 <CAOMZO5Dr6+Z9SFWsRS4FH9HhXUUR+dNdJ-k_ELjLM2_a+orYEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8025539541219783812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86FC0266F44
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 22:51:46 +0200 (CEST)
In-Reply-To: <CAOMZO5Dr6+Z9SFWsRS4FH9HhXUUR+dNdJ-k_ELjLM2_a+orYEg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org


--===============8025539541219783812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 01, 2018 at 09:14:47AM -0300, Fabio Estevam wrote:
> On Mon, Apr 30, 2018 at 11:06 PM, Timur Tabi <timur@tabi.org> wrote:
> > On 4/30/18 6:55 PM, Fabio Estevam wrote:

> >> +// SPDX-License-Identifier: GPL-2.0
> >> +//

> > I thought only the SPDX header is supposed to use // and the rest of the
> > comment should still be /* */.

> I think Mark's preference is to switch all the initial comments to // style.

Yes.  It's more that only the SPDX header has a technical requirement to
use C++ style but when you mix and match the two in what's effectively
the same comment block it just looks messy.

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro01wACgkQJNaLcl1U
h9AqvAf7B/bBrp9IMWb5FFrmep5jSHLeZUxMVAFXO8r3mbGqg1uFojQlozaJQVlZ
J3NBo9GUiSAGOy38GRyiKrbCsKqe64Wzuuc9d2JbV2vjsGTqAXVS0JQsUYXjo7jV
kVVZQoiA5iI3eZBE6f6s1gm92ZkFxJB9sySN7CEOGwMjWIkHYgGE+bGphXK+gdoe
LaqyhLXiQluqgAKHlzur+Mbga6CmCeKem78mLkIKAuABeWelwqjlzpPTh/M8K1KP
rcQdstZcmZkCzv5bfi2nuXgj54ABgKmsIY5cg45W815PfgqrVyXnLc1lAQDw8xNr
PQSEALUla/lUptFFMqoXmCswkw/DZw==
=UzKt
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

--===============8025539541219783812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8025539541219783812==--
