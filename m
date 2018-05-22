From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Tue, 22 May 2018 18:14:31 +0100
Message-ID: <20180522171431.GF24776@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7826923515649947130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 566B0266DF0
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 19:14:49 +0200 (CEST)
In-Reply-To: <20180522165842.233949-1-groeck@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <groeck@google.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============7826923515649947130==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 09:58:42AM -0700, Guenter Roeck wrote:

> Both problems have been widely reported. Various attempts were made to
> fix the problem, usually by providing v5 configuration files. However,
> all those attempts result in incomplete ASoC configuration.

This is the first time I've heard that there were still ongoing issues,
it's extremely disappointing - I'm guessing the attempts have all been
at the distro level.  Userspace fixes clearly aren't the thing to do
here, as discussed at the time the original fixes were done this is an
ABI and needs to be treated as such.

None of the systems I have access to have ever used topology so I've had
poor visibility of how this is working in practice, I guess I'm going to
start seeing this stuff next time I upgrade my laptop (unless someone is
making suitable non-x86 laptops by then!).

> Let's implement backward compatibility properly to solve the problem
> for good.

Thanks for doing this.  I'll give this some time for review from the
Intel people - adding Pierre as well since this is a bit of a device
thing.

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsET/YACgkQJNaLcl1U
h9AoYgf/XeNyk5qM/lMQatU+yxf76I8Gs2C2EIg+LnA+QSAVWUTYX4j7aapqK9/7
YlUDReyCF0KlNSU6wXsa5C7pXpJ21iOjNq5eFA1xF/7GQLp6JSWZqOr8aYnCmmQF
SopEfzcqQCZ+U/DcGBXO9wxD0coMa2tPjyAPvcLiQAS/PSN/uvFy9IBBR2wlrRAV
rXMdoeMYojwz/hvfZNYTmkFA9U1tGUzHHK5wSvljMeV9/m0o/9y2gXmQaM/wUR/J
2MBijJblaCn/DW4UoSuq+xMVL2FwOBIemCJQ4iBcOdIPWbJWAokd62LAiwU/9Dxo
ifxJVVmEdC3A7ai66Waq65iac2uW+g==
=s8o9
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--

--===============7826923515649947130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7826923515649947130==--
