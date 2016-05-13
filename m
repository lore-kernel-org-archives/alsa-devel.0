From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dapm: support user-defined
 stop condition in dai_get_connected_widgets
Date: Fri, 13 May 2016 14:43:20 +0100
Message-ID: <20160513134320.GS22038@sirena.org.uk>
References: <1460638999-30598-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160513120905.GK22038@sirena.org.uk>
 <20160513130143.GA27465@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0007586314141092601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 08C51260564
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 15:43:49 +0200 (CEST)
In-Reply-To: <20160513130143.GA27465@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0007586314141092601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vy6UCbb9EK60RK4A"
Content-Disposition: inline


--Vy6UCbb9EK60RK4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 02:01:43PM +0100, Piotr Stankiewicz wrote:
> On Fri, May 13, 2016 at 01:09:05PM +0100, Mark Brown wrote:

> > This seems really weird and uncomfortable.  From the naming I would
> > expect it to be a boolean function and I'm struggling to understand when
> > it would be useful to report multiple endpoints on a widget (edge
> > widgets normally being single objects).  The whole counting thing is
> > mainly a combination of debugging and an artefact of the implementation.
> > What's the motivation here?

> I don't have a strong reason for this. My motivation here was - since I
> am adding support for stopping an arbitrary point, it could be that
> someone would find a use in stopping the graph walk part-way through, and
> still reporting the number of endpoints as normal. But, if that's
> unlikely to be of use, I'm happy to make it a boolean function.

Why would the number of endpoints at the edge of the graph ever be
something other than 0 or 1?

--Vy6UCbb9EK60RK4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNdn2AAoJECTWi3JdVIfQHEIH/23Au22cu7407zmEmH/GSUVT
UyUAWKgTk/u4g9J0V5YuG1XGDD3bH6FiWjoP1tthefiIBhYYxbt8ufksCE4fejXl
AdWSTIkce/ZyyrY9YicU6u1bw3SqfVE41+9LGWQCw9u++GXoyijlaMvl5z5jwwF7
cmGL6dInSYaU3p3IYaE8qK+dtoS+6iT06g2z03veuQLQ4ZL7r/+8gOPNj0rK/0Tp
ceBcIu8ObgBUxAWOEv5AhywKs78GtGU6Nw1+h765VZb+75XnRZlESlcSSEKexCPE
9TsmD7ORA5PfAL8sEykrbv5njF5qDtdzVLyvwn2dq+PZNQOzYdGdF47Rcc5kiZo=
=YBpR
-----END PGP SIGNATURE-----

--Vy6UCbb9EK60RK4A--

--===============0007586314141092601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0007586314141092601==--
