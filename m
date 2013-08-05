From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Mon, 5 Aug 2013 15:40:54 +0100
Message-ID: <20130805144054.GE9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5239058689637610274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 890AE2615F2
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 16:40:59 +0200 (CEST)
In-Reply-To: <20130805113310.GU23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5239058689637610274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNP6oKA3AwjrAnw/"
Content-Disposition: inline


--RNP6oKA3AwjrAnw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:

> > This doesn't look good - this is adding DAPM routes which should
> > correspond to the DAI link that's already been configured.

> No, you're wrong there:

> CPU DAI:				Codec DAI
> dma-playback	--->	i2sdo	--->	Playback
> 		`-->	spdifdo -> not connected
> dma-capture	<---	i2sdi	<---	Capture

> And the intermediate level is needed to determine which outputs from
> the chip are wired up.

Right, and that's exactly what the dai_links are doing - they're showing
what's hanging off each of the DAIs.

> And don't even say "use dpcm" - if you say that, I want _you_ to write
> it because dpcm is totally and utterly unusable as it currently stands -
> as you can see from all the emails I've sent over the weekend.

I'm going to tell you to work with the framework rather than around it;
adding routes that link the CODEC and CPU together in parallel with the
links set up for the DAIs is not something that seems like it's going to
continue to work sensibly going forwards.  If this were done at a
framework level that should be fine but having it as a special case in
some specific boards isn't good.

Since I don't have Kirkwood hardware or any particular use for it I've
no real intention of working on the hardware directly, sorry.

--RNP6oKA3AwjrAnw/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7lzAAoJELSic+t+oim9kawQAJG5GnIvqKoidO+G+TjKJx1l
kZ2QpNtkdh1kQczkG3mrwJagLLWBRo0+6ScoiqgOAF+d9S9bJX5kZd5uqUIktMr0
ML+JhGIxUHQaNzwNGFtoWclWjUuvYblwP75zDS5V/tX2vhM50kf4wtncaZ7stQlU
oLvDUdiTEtvOHrHOKb9RHm1tc/PLevEezYfErzIdSFlPM3T80ItOc0r+gndmR5Ge
vlmfzlKZPu4S3nzU+OpyQ/fbpHR7A4xvJ5qI1E7MZiAyRsc/pTMST/4IBwWIgRq9
VVw6lC4JCskyeUYXLwh7cxDitSOsDlCjS3Vi8kB6Ae2Y9Sxj1YFRVebqiQEoHYXj
yycLeOyrdEwNKXiO7Vt8sGHjfUrjB6NI66RWv2AgPUpgs5illM8GmKv/pg4s/uly
tsVB3c71DchF4IXQNK15nzDjWheDNt6eJ1L5NgsYPNFgr9T+q9CuBAsZ1zxSQBSN
cfTbh1FFxq0yYwOd+J/pZXa+HUxWS1eUeHGk6bj6iaFp0985dFmiy4sQQY73wyJ6
l5SGjkQS9DbYiq/UyUcsmFGucJRUJrM0A2zALWByAGdCs3R8GVqRlyGCCogcVtGB
vVx5bBoAfEMjtjBRdBv6aiE7+llgOPT6Hg2LDiOcOQO7ErzsL3d/304YfYIEbo4M
m4tFDkAOIfUi/2QDHOnv
=WN0L
-----END PGP SIGNATURE-----

--RNP6oKA3AwjrAnw/--

--===============5239058689637610274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5239058689637610274==--
