From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add DT bindings for generic ASoC AC97
	CODEC driver
Date: Sat, 7 Mar 2015 10:52:01 +0000
Message-ID: <20150307105201.GB28806@sirena.org.uk>
References: <54F9F81E.8080105@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516018868289455571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0936B2605FA
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 11:52:16 +0100 (CET)
In-Reply-To: <54F9F81E.8080105@maciej.szmigiero.name>
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


--===============0516018868289455571==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 07:55:26PM +0100, Maciej S. Szmigiero wrote:

> Add and document DT bindings for generic ASoC AC97 CODEC driver,
> make it selectable in config.

AC'97 shouldn't need DT bindings for the CODEC, it's an enumerable bus.

> +  - playback-rates : A list of supported playback rates.
> +
> +  - capture-rates : A list of supported capture rates.

Why would we need these properties - the sample rate support is defined
by the standard, and any extensions can be enumerated from the device.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+thRAAoJECTWi3JdVIfQL8AH/3ZzZ9qFl6o71I5/Bsa3TQ2/
FMfNDvLv1RmlGrI3rH5W/kQBSzU8C4IQMChSmPOtcZf4RDGgHnpfYKAcQ2AlOaLG
GS9JfqOouZbbQBO/NAcwh6XWp1RxEVQpoX8mS64XRsi9TEnYssxVf6IK3HITJ5N0
Lyj7vzg7doCwr1jd2+YD1vRRHLZfGJu7cYTsTjzAlQ6oukLgsWm5I5QR6i+mAVfN
W7zfNU7zuIDxZH+a54Co1dP10Z68XSRBKfSQ5fDQW0wtwnlJ98P8TS2p8/Er6pzB
Vto1EqUw6V/2FYada4e4XMQwr+PFr9I+anxAuL0fEsffe6DCx+I47CeRgd4ZBqg=
=y93h
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============0516018868289455571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0516018868289455571==--
