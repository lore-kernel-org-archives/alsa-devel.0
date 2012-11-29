From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 1/2] ASoC: add
	snd_soc_of_parse_daifmt()
Date: Thu, 29 Nov 2012 15:12:35 +0000
Message-ID: <20121129151235.GJ32691@opensource.wolfsonmicro.com>
References: <87txs9hvy7.wl%kuninori.morimoto.gx@renesas.com>
 <87sj7thvwy.wl%kuninori.morimoto.gx@renesas.com>
 <50B6F0F7.1050902@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5454923130489828283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 091D326166B
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:12:37 +0100 (CET)
In-Reply-To: <50B6F0F7.1050902@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5454923130489828283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GwwLvQJ0l3HSwfoE"
Content-Disposition: inline


--GwwLvQJ0l3HSwfoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2012 at 10:21:59PM -0700, Stephen Warren wrote:

> But isn't there a lot more to the DAI format than just the format enum
> itself?

There is but it should be OK to represent that as separate properties
rather than trying to glom all the combinations into a single property.
For the frame inversion flags we can assume a reasonable default of non
inverted so it seems OK to leave them for now.

--GwwLvQJ0l3HSwfoE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQt3tRAAoJELSic+t+oim9excP/i2Ld0kk1mhcbhgHMFHhtkNe
BuTJum7Lc3x6Z49A8hfsWUCEGrRpx7t3n2dkiy4kfCjydLJZS6mcVGshQNMhGk8V
Q7hmbbbhHFT9Zv5bfkuVHTkiRZjoPPB1cY8C7oCFjjcsOM9/xRslxdnVBP63JIrF
P3jyAQ6QppB65bOrF01dfq/re4IC0izVaybGOieOGVF3frBrlx2tD/ba/mDMhY2/
ggCCDzir2bwvl/CRoirbbWsDm/2uhRGQ6Uuua9FtbP88ssqZ/XUUxkxAs0o+x4Na
YExmrNpaO65LhAOVdsByv4WhS95B6+E3J2reWqBPl6ecPb1H7XnpggJFVzj7EyFg
cB8qgyCqRmHqQU/BVQJFsmHz0o4qS48TQIpXeWXxGbS0n4qTQ3HupApE+7U59RXR
IXcV8rjPhsZbiaF0VI/zIDIs1cHfp+P68V9y2jiY3xyry+lNJaNmWRH8uijTere4
uLS7dF8bYdvE2t8fcUWMADCwZjTOk1kFuwN9kGT0CPSiCz1dAzOgBM/q+IRwI5i0
mMVJnwwqGuV0h78b6mB4oStI1TY8JMvHhSiBtFwYLPykbKfzQq0UFFKbfob/e9my
eC6TvKjY0uA2ezsuCqB4hirXyP6e+UycYU+r8U3IUYH5B13Q90lJq8SB2NRRoxEa
enjX8NCHNsqU1SnO8CUx
=7ToL
-----END PGP SIGNATURE-----

--GwwLvQJ0l3HSwfoE--

--===============5454923130489828283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5454923130489828283==--
