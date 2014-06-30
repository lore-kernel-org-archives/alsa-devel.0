From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: tas2552: Support TI TAS2552
	Amplifier
Date: Mon, 30 Jun 2014 22:43:42 +0100
Message-ID: <20140630214342.GI23300@sirena.org.uk>
References: <1404148259-17305-1-git-send-email-dmurphy@ti.com>
 <20140630172115.GE28740@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7970405064000207720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00252265668
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 23:43:52 +0200 (CEST)
In-Reply-To: <20140630172115.GE28740@leverpostej>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dan Murphy <dmurphy@ti.com>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============7970405064000207720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5zn77Mes2TPnoMqf"
Content-Disposition: inline


--5zn77Mes2TPnoMqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 06:21:15PM +0100, Mark Rutland wrote:
> On Mon, Jun 30, 2014 at 06:10:59PM +0100, Dan Murphy wrote:

> > +Optional properties:

> > +- power-gpio - gpio pin to enable/disable the device

> The code below seems to look for "enable-gpio". Searching for
> "power-gpio" only hits in the line above and the example below. I assume
> the code is in error?

It depends what this is for - if it's for an external regulator it
should be a regulator binding.  Also all GPIO properties
are supposed to be called -gpios because DT conventions.

--5zn77Mes2TPnoMqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsdoKAAoJELSic+t+oim9QYYP/25XMOhM1tgeLLHbHKljr2wm
NP1g6gvK7C7vE20dQXB4GP338bEIddOsr1tAmJz/u5S1undyVhYfN7pOmiPCJsdX
9HcMYsrLKmlGtlCX0Jy4ECmEMiFP9cJ5EW03LcdAAx92Go9xqprOCA9YhFGjUaB5
jVwuuhHnMAShFikW4axpknihUU89DDNJ28Rw4oocb91LhdJG4Y5au5f3rNug9kMC
jfxd4q5vZOZoP7o+WSn7MJceas8wmTWaFyRvboX0uu3gaY3lDobEQwdJ6ASg+gQL
Yvq9LRAMNuWLacXwrz9N8xJLKNI6/FHxF3xHqOzSsgxjaoDB0pgVMgHeSA6SjNbB
1VDb2hVVc4acT8ngGtmFoq93pwLZ7rmkVGTosJQ5KWT7Vqo4l5TWsVQxtRLvVBq9
BOYZoV6L2UdBkITSXnvpEKEH3Jqn3w2ca3SHt/Cqm45NYRm9zjqySfU/Zqbq+oBS
7BUgYrJ5UyuzTS5fJV2LQNasFnTFchRDxum3/ko8nWYSVDlcpfw5k1LJbDYuwOWj
3UgF47kMcF1iAaBrIy8CB6e+Dj76KY6zVINxgPX5jM2ZTnzZ7rVdoJlJDRNPtDvA
2pykkvMkYPaydMXpnn1Kj2OUF0AKtB7oHqn9hLOehefFNanLkaKbtth707Q0bTim
iGdxKMrrPYzxeO40Ku7s
=Nq8+
-----END PGP SIGNATURE-----

--5zn77Mes2TPnoMqf--

--===============7970405064000207720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7970405064000207720==--
