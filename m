From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97
	audio complex
Date: Thu, 14 Jun 2018 14:48:01 +0100
Message-ID: <20180614134801.GB9660@sirena.org.uk>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
 <20180612221359.GA26741@rob-hp-laptop>
 <87y3fiqzp8.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2269405716902198881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6087F2675D2
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 15:48:13 +0200 (CEST)
In-Reply-To: <87y3fiqzp8.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============2269405716902198881==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2018 at 09:00:19PM +0200, Robert Jarzmik wrote:
> Rob Herring <robh@kernel.org> writes:
> > On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:

> >> +Required properties:
> >> +  - compatible: "marvell,pxa2xx-ac97"

> > Don't use wildcards in compatible strings. Though this is so old...

> Yes, I could use pxa270-ac97.

If you're going to do that then probably best to put in a compatible
string for each SoC since they are actually meaningfully different, they
seemed to manage to break something with each new revision.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsichAACgkQJNaLcl1U
h9CZ2wf2P8RJc94KqSk0E9cc7WOEzkM/bBC3w1dEkqBlm9nNNSmsUj81RlRFHpR2
BQztdPntC3jxepVMpyTIOGOJEhoYiIcT9yAbgoujIkaSSERjxKFyoDb00tTStjtg
6SQhPUnFDga+eXUiUhmfv8oFr4dP4PlEup43xoVnHhwLY6oo31MOVhQPrzHPb1uA
OgbYVEG8RqatEsuk649UQ8KBEHKkWE3QCmb6vL0yGcZ8GVuaUrRh19gDEpX1ea3P
ydTB/0L4gd7kMsk7LH1iwzcaD/mv1ztkw8m3NcQq9+i6hd0CGOp1G+T7YINvtism
GESrxQk8QMvL13owbaCShtGsg15A
=gAJc
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--===============2269405716902198881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2269405716902198881==--
