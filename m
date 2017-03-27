From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec
	driver
Date: Mon, 27 Mar 2017 12:59:20 +0100
Message-ID: <20170327115920.opbtui7mor5q6tch@sirena.org.uk>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
 <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6801548893965807654=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70F0E26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 14:00:26 +0200 (CEST)
In-Reply-To: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org


--===============6801548893965807654==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pe5njdkllemkgbb4"
Content-Disposition: inline


--pe5njdkllemkgbb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2017 at 09:46:03AM -0500, Rob Herring wrote:
> On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:

> > +Device-Tree bindings for dmic codec

> Please define what is and isn't a DMIC here. What's the interface?

Digital microphones are a well understood concept for anyone familiar
with the problem domain, they all provide a PDM output.

> > +
> > +Required properties:
> > +	- compatible: should be "dmic-codec".

> DMICs don't have part numbers?

Not meaningfully in this context any more than analogue microphones do -
they have no software visible interface.

--pe5njdkllemkgbb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljY/pcACgkQJNaLcl1U
h9AjgAf+JxDZOC2ncfYHSTbxJzxXceJREmXx466ytDR2JZj6LWiFlJiqjeM/3v3Z
TFzeM98xHgkX06G7VYOZ9YUFR9tai7IxR9fPXS5yiWLwvb2ZEw5rowCKmFIClWxL
E7CQRhqYzbJa94XUtfY6qYXMuNk7NZ56EQfEoM/nZ46bw7iZTstVWVZrcxQzmPpL
tmEhguZYZ8DN0BCRU6fu7u68UHrEEGOsWg+fmoK0JfkW//9xaVXRe1xq5DhHZG5A
DJkqa1U4ssmq70X9LF/6MSrs746d13PXq+aCu06t0XvEokVpY3dyOEg1X3qoLyIU
7U2s5OaUoflzOsMKHu6UBQVEl4T/Xw==
=W9ta
-----END PGP SIGNATURE-----

--pe5njdkllemkgbb4--

--===============6801548893965807654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6801548893965807654==--
