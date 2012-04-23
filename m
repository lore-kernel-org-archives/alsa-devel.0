From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix x86_64 build warning.
Date: Mon, 23 Apr 2012 17:10:41 +0100
Message-ID: <20120423161040.GP8318@opensource.wolfsonmicro.com>
References: <1335173475-5536-1-git-send-email-lrg@ti.com>
	<20120423121646.GE8318@opensource.wolfsonmicro.com>
	<1335183754.31825.109.camel@vkoul-udesk3>
	<20120423122844.GN8318@opensource.wolfsonmicro.com>
	<s5hbomi5unn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4450619397667763093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7353A243B6
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 20:06:04 +0200 (CEST)
In-Reply-To: <s5hbomi5unn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4450619397667763093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2012 at 05:34:36PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > We should do though we don't currently - see the recent discussion about
> > the ice drivers.  There are some PC sound cards (mostly high end or old
> > ones, or tuner cards) which have a setup like ASoC where there's a CODEC
> > on an I2C bus and a "platform" which in this case is a PCI type device.
> > At a high level they look the same as embedded hardware with several
> > chips glued together in software.

> Right.  In near future, we'd need to move up/down some ASoC code
> pieces into ALSA core so that people won't misunderstand.

I think from a code structure point of view we're probably mostly fine
as is (in that ASoC is sitting in parallel with more integrated sound
card architectures) - except for DAPM mostly ASoC is just thin wrappers
for the core which split things up for multiple devices.  We'd need to
deal with that layering somehow if we were merging stuff in.

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlX75AAoJEBus8iNuMP3daZEP/3ENAORYPXbF3bhqQOfZvP4E
M50FJ2X/E/FVM2XJGX9q7M2gD5VjRZU6+qoWLyjsCai6oLDGh1/krYCWKEBzV7Qz
oNvzpb0LJxt5mdsZcCF2azPXuw+Ct2G/X/GuPH/5iE/7c3G6xHfyBNo8VGbT2Zws
rwI5aHotM+s2wadYkfZ4rsqNNBYTUqjT5F4RQ2uNrsHjDOiottMlmOdZfHPTQOxM
Gb6E47Cri5xsGMyeHBvkuU/LK3ecPQPk1T+S8t5yPkFtC9dEYTZ+Okmd5jUHxl3M
pfWkIuvRjW7a+bmkUgfb3ZgrcNEAfUMAIZTPY5T3heXs0WrAs165Pfh2zlLE581u
cHv9UKwo6PNRnofWUYZ87x7+8/c6Kjxr8OL/rZWOpcgctfl0gdQ1kqminc+HHJCK
eJg1qKkXywU2KE+SzcmZNwV9v9lVvV+76aE3URiLMGrBX80mfJssvkkYj67TFt9Z
kCL3mnH5017twcxTM/ACSrtT79hI2jRXuinqGJY+UQcK28EfhEjQbADbY3YwlF3T
Hw0+BxqxXMlgobdWEtf/IV+hK/O0wOfY7APzYDZPyQQeOCHRfjxHfkrGBA+FT1wB
Pr8sn4V2PZ29btdgw9GQ/UGdQFOH4bDXNFkOU2R9qrDIgcZeJCL9cs6U/NluiJR3
HjcTJjTVutfkiGFt+7E1
=3Uzi
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--

--===============4450619397667763093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4450619397667763093==--
