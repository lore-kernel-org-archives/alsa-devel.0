From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: stm32: sai: attempt to fix
	uninitialized variable
Date: Thu, 2 Nov 2017 11:21:00 +0000
Message-ID: <20171102112100.whlosjahisgtboi7@sirena.co.uk>
References: <20171102111620.3688534-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4899549533466273156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E117C267438
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 12:21:39 +0100 (CET)
In-Reply-To: <20171102111620.3688534-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


--===============4899549533466273156==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fc52zy7b45dy62p"
Content-Disposition: inline


--3fc52zy7b45dy62p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2017 at 12:15:48PM +0100, Arnd Bergmann wrote:
> After commit 61fb4ff70377 ("ASoC: stm32: sai: Move static
> settings to DAI init"), we get a valid warning about the
> use of an uninitialized variable:

A fix was already sent for this.

--3fc52zy7b45dy62p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln6/5sACgkQJNaLcl1U
h9AfKQf/f9/5iYIBHDfiwp7GHhCJ+Bl8ufrnaAe1i3lTP3YKrmJyf3wVBRqa2X7e
EGmhdy8se/6QNln1pkG/ET97+bVSSN82UtTzKNaXzeRpWUym/Iu1yghL6kn54HqJ
j4YNQI1Wjt8Jg1jbtFOhauNqfbF4Fsod7Lor8F3BA/Lo0nU51xiJP58j9gQjUtlW
PSOkbIU89Dy7ebkGR3MkqG5Uc/aHE/XcvaSq84odsDzFTTJpTUwd8nri+adEqcCF
yYfLFpjzO0ABWmq/DC3x0EGSimWHMVpRWfYOA/dDTLH+aK7EkYpM4DRUKOHnCj+O
CxYrB/Bl+pTf9KfpELcNLjZDG3lBzQ==
=1JIz
-----END PGP SIGNATURE-----

--3fc52zy7b45dy62p--

--===============4899549533466273156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4899549533466273156==--
