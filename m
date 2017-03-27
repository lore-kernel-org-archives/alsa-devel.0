From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Mon, 27 Mar 2017 12:30:05 +0100
Message-ID: <20170327113005.czudkmmsrgs6isgk@sirena.org.uk>
References: <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
 <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
 <20170327100126.osj3o2qtq4jwex3s@sirena.org.uk>
 <289fc02f-4bdc-4bb7-6827-39c644816b70@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7724948801649904586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E1A26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 13:30:41 +0200 (CEST)
In-Reply-To: <289fc02f-4bdc-4bb7-6827-39c644816b70@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: Emmanuel =?iso-8859-1?Q?Fust=E9?= <emmanuel.fuste@laposte.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7724948801649904586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqm47gsq42veieli"
Content-Disposition: inline


--gqm47gsq42veieli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 09:35:33PM +1100, Matt Flax wrote:

> In this case, there is the TDM (DSP mode) protocol on the Codec. The SoC
> however is communicating in channel pairs {{0, 1}, {2, 3}, {4, 5}, {6, 7}}.
> Each channel separated by the PCM_FS clk leading edge.

> As far as the codec is concerned it is DSP mode. As far as the SoC is
> concerned, it is not I2S, nor is it strictly DSP mode because there is more
> then one PCM_FS per frame !

> If we look at this from the perspective of the Codec, then it is DSP mode. I
> am just not sure what to call the SoC's protocol, other then multi-paired
> PCM.

This isn't DSP mode from anything's point of view, the extra frame syncs
mean it's a whole new format.  Off the top of my head I'd suggest just
running it as stereo DSP mode from a kernel point of view and fixing
things up in userspace.

--gqm47gsq42veieli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljY970ACgkQJNaLcl1U
h9AV6wf/WEv/n/f0x1vaoa9MYRTjriF6lF/lqfLD3EzmqT8UH6MvyNvlE6haHGOR
KhySEB4x0StHMpanLZdGdmYZfrGikOsBSPWz9xtAMZ0p/EC192TQkxCy3NFmwCia
WxF2bVzapp9bCznYX9SThcygbnbQ9ZX07nkIu+2jBEosF6AMBLmqasSuvHBPbRPT
zjPVbfZCmQEBJZ8DqltD8itFCK0xCuzDi42Vg8AADtyfNsYr2D03eDpgLK12vMyA
DQqi6ntZmR8DHW7iAzb34/ti09l6il5cTbVdMJ5mGhuRPcG1sExdTmgDB609Wpjd
AMRmL4TtMjd+oaELBgHrqqm+Nq8dYw==
=qSRL
-----END PGP SIGNATURE-----

--gqm47gsq42veieli--

--===============7724948801649904586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7724948801649904586==--
