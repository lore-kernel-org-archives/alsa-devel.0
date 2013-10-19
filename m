From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: ep93xx: Open code dma channel
 request
Date: Sat, 19 Oct 2013 21:00:32 +0100
Message-ID: <20131019200032.GD2443@sirena.org.uk>
References: <1382188384-18063-1-git-send-email-broonie@kernel.org>
 <1382188384-18063-2-git-send-email-broonie@kernel.org>
 <5262BF2D.1080104@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1073978166782824433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 55DB92610C7
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:00:37 +0200 (CEST)
In-Reply-To: <5262BF2D.1080104@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1073978166782824433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4IfZ6i/5rsADVrr6"
Content-Disposition: inline


--4IfZ6i/5rsADVrr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2013 at 07:19:41PM +0200, Lars-Peter Clausen wrote:
> On 10/19/2013 03:13 PM, Mark Brown wrote:
> [...]
> >  static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
> >  	.pcm_hardware = &ep93xx_pcm_hardware,
> >  	.compat_filter_fn = ep93xx_pcm_dma_filter,

> The compat_filter_fn attribute should probably removed

Yeah, I was in two minds about that.  Obviously the ideal thing is to
change the drivers so they can use the filter function again; from that
point of view it's kind of like what's going on with Tegra in intention
- it is notionaly using the filter function, it's just that the DAIs are
putting the data in the wrong place at the minute.

--4IfZ6i/5rsADVrr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYuTcAAoJELSic+t+oim9BYEP+gIgCjuYA2cJCmQZdeECo41k
WjwN3HHqrIxs/5yyDRR4P2RrZJ+0alfXLEZPaQFwUfBezTGTPgYhCUNCmF6jjKMx
iYbiIftMKiUpVXJuouym3KBqitb8kbL5bLwqZoWDW+plYRfKH93nC2cT3xIbFi/8
SwRKcARCDitSWq8qUjAP63BQ8NnbQlc7SXJBwaJxtJi9vQjINVD1+ZTLptVMZJyB
PCXP3WDoW5IR0oSmIWcs8yyRQljvjqAwTBV8jc4JlkQULdTami3g07PlQrbIEZUE
4GoRrCK+1CO+Znv2RGp49DBz0Mlc0NwLTDmTuJnYvaShBWOf+B/52vd2nbpTeOXv
gKc+XYQ5UKwsjQ17ydKPCJicHH6RUNBH/UNLNOHPPqhT/TnRI707XdnmcUOUFqSf
dk0GmL4/KwcCL4P0v4v9XSBmkdQqRnYQFl0kqCEjlhNpV5ibOC71lbNVgSiq4i2D
MMin+TG55Y5hi91p7QQgBvmS8gWE/7HUw/8BLW4Jcpl/dUC44ixlVwht0z844ser
c/jQO29owHLg0IpGkKhgGyGmTwDvYfywc3MSFEP8BP2pb32lh2GHTQG6RKzQoxlo
Dho4dwtLs4PCewsMHxeCIotR9snoRnr9pPqKktfiQsyBk13B35aCPLagGWRc2XJd
2COKoBDOUh9/7ImUfqNg
=YVJg
-----END PGP SIGNATURE-----

--4IfZ6i/5rsADVrr6--

--===============1073978166782824433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1073978166782824433==--
