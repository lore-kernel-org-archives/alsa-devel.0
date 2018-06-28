From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date: Thu, 28 Jun 2018 12:52:50 +0100
Message-ID: <20180628115250.GE14040@sirena.org.uk>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180618104159.24b9fffb@bbrezillon>
 <87d0wnrhqz.fsf@belgarion.home>
 <20180625130704.GQ9413@sirena.org.uk>
 <87r2ksl0wa.fsf@belgarion.home>
 <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5119178038725380829=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B5E3266E76
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 13:52:54 +0200 (CEST)
In-Reply-To: <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5119178038725380829==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 11:03:16PM +0200, Daniel Mack wrote:
> On Wednesday, June 27, 2018 05:11 PM, Robert Jarzmik wrote:
> > Mark Brown <broonie@kernel.org> writes:

> > Anyways, the immutable branch doesn't contain the specific ASoC patch "ASoC:
> > pxa: remove the dmaengine compat need", and up to my better understanding
> > neither does your for-next branch.

> > So until I see it in your branch it will dwelve happily in pxa/for-next. If it
> > has to be routed through your tree, so that Daniel can work on ASoC pxa, I'd
> > like to know at -rc4 time so that I drop it from my pxa/for-next branch.

> Ah, yes. The series I just posted depends on that.

Ugh, please resend this patch so I know what's going on :(  My
understanding was that I was pulling a tag with the dependencies.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0zBEACgkQJNaLcl1U
h9CqMAf/YnJSuYfkDLsMJj+Ma+azKxHUUSNo2TTk7zLNL2f7sFayIkYng3Go7cw4
KcZhV5KILOySk00mHN8RmO+kW/j1sipOD9MaNoQfr3omL0upYyaa9gTs5SHm1e7o
s5yeLUrFCn1V0gSsuIsgEHDS0tA7h9V8p9ATAMRZcs94Zho490r/VeKya9Ouqxhw
qVYrApADDxxyvoiZ0W7SdfWYvottnqzNzZFAmTtEmbj7AAQcKI0fcn6tTlAZUcuj
fW9A4GdAvv+xZGHgD496oLaIe3yP4rhGpz6gIvmtFxBMJCU0BAEL5Rc/JVh7d/gG
RGrTKKeFKpwFciY7VgyEDzR/QQfJEQ==
=OPKL
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--===============5119178038725380829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5119178038725380829==--
