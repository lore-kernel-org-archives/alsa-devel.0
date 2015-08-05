From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] Add SPDIF support for rockchip
Date: Wed, 5 Aug 2015 12:59:51 +0100
Message-ID: <20150805115951.GK20873@sirena.org.uk>
References: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150804153649.GP20873@sirena.org.uk>
 <1438756921.27576.4.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GNsO7fNsq+j2k5eo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438756921.27576.4.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--GNsO7fNsq+j2k5eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2015 at 08:42:01AM +0200, Sjoerd Simons wrote:
> On Tue, 2015-08-04 at 16:36 +0100, Mark Brown wrote:

> > I only appear to have patch 2 (with the misspelt subject), not the
> > binding documentation.

> Applogies, Send that patch specifically to you now.

And I deleted it unread because it was just some random off list patch
with no context.  :(

> Seems get_maintainers.pl didn't include you in the list (nor the other
> asoc maintainers in the list), I guess it might be good to add
> Documentation/devicetree/bindings/sounds/ to the ASoC file list in
> MAINTAINTERS ?

Please follow the process covered in SubmittingPatches for making kernel
changes, but note that there's generic sound drivers as well as ASoC
ones.

In general it is a very bad idea to rely on get_maintainers, it is prone
to both false positives and missing relevant people.  It can be useful
to look at but you need to think about what it's telling you.  In this
case it should be fairly easy to tell that you ought to send the binding
documentation along with the driver.

--GNsO7fNsq+j2k5eo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwfq2AAoJECTWi3JdVIfQ8koH+wU5IMgymFjXkLokOTSnxd4i
SYCn6eMvkR+c9Co7q+fNh6OrAxOHRsBF3gW4Q+2096OHfVme9+lPgAy0Hu2vRVdo
BAZ/+c8V2bCeH35S96pDqNuqdxhKA1IfnqEtlUZJP5l7x+wA6x24S9nYLz2lOw8/
IdfO6diH13EaW5uBsonNDgC1+wES7kWIjzpuNyG/CNdbG6sYYvP+V4PG/Td7mr/H
hihKQeP/iPTovfesv8a1MxIXI1SF7xekHdIv5o+HkniXcyyld7PzPYl9wYcfiHmJ
5VjZWq9R7NyNfrQtkBjFzemsgrvpB/82NWQSmMUWMHA4XLbjMfNke1vLa1rYN0M=
=hBn1
-----END PGP SIGNATURE-----

--GNsO7fNsq+j2k5eo--
