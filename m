From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/14] ASoC: kirkwood: add SPDIF output
	support
Date: Tue, 3 Sep 2013 12:17:20 +0100
Message-ID: <20130903111720.GF3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3076564581456478348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9638926168D
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 13:17:37 +0200 (CEST)
In-Reply-To: <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3076564581456478348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOBTspFzEMOlPevk"
Content-Disposition: inline


--ZOBTspFzEMOlPevk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 01:47:37PM +0100, Russell King wrote:
> Add support for SPDIF output.  This is enabled via a widget being
> connected to an output.  When this widget is not connected, SPDIF
> output will remain disabled.

This is still not a good approach to adding a new digital audio
interface since it does not create a DAI but instead adds it like an
analogue link (but hooked inside the CPU using the DPCM DAPM hooks).
While this may work right now but will not be robust as the framework is
developed and can cause problems in system integration.

A new DAI should be being added for the S/PDIF interface, this should
fully utilise DPCM but an either/or approach would be OK as a stepping
stone.

--ZOBTspFzEMOlPevk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJcU9AAoJELSic+t+oim9je8QAIw2FU1djEiCNXug5sn/7/0w
gzK0SYSIFVW2IbS1WyQgFc7TleTIYsaXcdRo+7HL0EKeUaGAg4NeIt2KB19DuEpv
y82IgjsSroPYrogzxFqh1sJ026QjC8LV15RzJylZmYdd8VSo85PbO2/wXlIkwo3N
h12iIa9x/4os0D9veYYiiz5W1TY6TVa96goNeBOC0Xq02yCK+flG1KYxStBQhEPO
vtnBS6nJiE26JH04xr1LdEhSAPuLHQ1h16AjRbrXkwTXYGStD/S/9gErWv8Wsrut
+B96xRNJOlYhUAWx9itiTnpdBqWBsKq0cq5r+lgmk2krD/g0XrbAkZt4dZ/wQfYc
ycFQLjo1hNmpQskiFrG96V8NRYjg/tqvLun8IDIpQmR2KikH0l4MkVOXV0aKqb1Z
IPsShqRH4qltaQpSjHDwxS614Te5wjASrSRkN0USnQkOK7mQ5TR13sSivx/EKcX/
lSYeT8wWx/byM47penDBe7zWTMnjOmeDK9W2uMUxee/3TxVCZ+rUy0AS1QBWX8IF
GigKfp/Roibfqr3taxlQKOhofOaFO60seFygK2SjwhChscadqtmAqAq3KhJbDoJC
XxeFhbIEpWKjvyMpE9pnEORncIFWlDPDr1PreNkucEWYAUOUb81nA6YxL3GSxAUr
4Zv699bweVVvdEkzxjE7
=iQh6
-----END PGP SIGNATURE-----

--ZOBTspFzEMOlPevk--

--===============3076564581456478348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3076564581456478348==--
