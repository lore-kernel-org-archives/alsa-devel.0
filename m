From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add DT bindings for generic ASoC AC97
	CODEC driver
Date: Sat, 7 Mar 2015 14:34:34 +0000
Message-ID: <20150307143434.GL28806@sirena.org.uk>
References: <54F9F81E.8080105@maciej.szmigiero.name>
 <20150307105201.GB28806@sirena.org.uk>
 <54FB041D.8010102@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9038488810078120263=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8590B2605CB
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 15:34:51 +0100 (CET)
In-Reply-To: <54FB041D.8010102@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Mark Rutland <mark.rutland@arm.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============9038488810078120263==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+278g007AL/ykmV8"
Content-Disposition: inline


--+278g007AL/ykmV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 02:58:53PM +0100, Maciej S. Szmigiero wrote:
> W dniu 07.03.2015 11:52, Mark Brown pisze:
> > On Fri, Mar 06, 2015 at 07:55:26PM +0100, Maciej S. Szmigiero wrote:

> > AC'97 shouldn't need DT bindings for the CODEC, it's an enumerable bus.

> What this driver did / does is essentially to allow attaching AC'97 bus
> to ASoC AC'97 controllers which don't do it on its own (from what I can
> see only board files do it).

That's true, and it's something it's easy to get away with with board
files, but that doesn't mean it's something we should be doing for
device tree where we're not just finding an expedient way to load things
but rather defining an ABI.

> This driver originally constrained rates to 8000, 11025, 22050, 44100,
> 48000.

> An alternative would be to remove this constraint at all from this
> driver and leave such constraining for controller and AC'97 bus code.

That's a much better approach.

> But since this driver was originally limited to these rates I think it
> would be safer to do it only when instantiated via OF.

Again, DT is defining an ABI.

--+278g007AL/ykmV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+wx5AAoJECTWi3JdVIfQkKIH/1m9xSCDcLm1T19DFx9j4/t2
MC2zbugpd567aqpzuVvXdnN7XE3AgZGljTmjC3fJzZD22crr+ewoLXRqdPCLEh0g
ILgDTuO3dTcy2EgS1ALNkKH9hbf0pgV5ImVmcCOk8BfuP3ELylb3dxwnJ+ewL4b5
ysBtVTtLK8WXQ34gd7YMjUZZvrYsyh32G3rCI7F6sog66C7EiYRLU5bDpB0maanP
sedn3rIFPxdUcy0DzxxolFJS5qUdutJ/8Kqn8k0GjCFTBSmmnIFnjJFbl+PuQU15
PiBY3gWAzs9IoOiDZG3qgZnfmxwqxEa4YFd5zWlnmlpC/kfGx11D9J23qTIx0Wo=
=/qlL
-----END PGP SIGNATURE-----

--+278g007AL/ykmV8--

--===============9038488810078120263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9038488810078120263==--
