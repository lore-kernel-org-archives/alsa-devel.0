From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Tue, 11 Apr 2017 22:10:40 +0100
Message-ID: <20170411211040.htrcedus3c57fbed@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9130808511986004486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C755B26684C
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 23:10:57 +0200 (CEST)
In-Reply-To: <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org


--===============9130808511986004486==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jh2nlyaixolfggcy"
Content-Disposition: inline


--jh2nlyaixolfggcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2017 at 03:44:52PM +0000, Olivier MOYSAN wrote:

> However, regarding STM32 I2S driver, I'm wondering if selecting DAI
> is the best way to configure interface as tx, rx or fd.

Why do you even need to configure this?

> Maybe, it is more relevant to configure DAI according to DMA
> configuration from I2S node.
> This would moreover avoid to allocate 2 dmas channels when not
> necessary (tx or rx only).
> If you agree with this, I will implement this change in a v2.

That sounds wrong, I'd expect this wiring to be done statically as part
of the .dtsi for the SoC (or just grabbed as needed at runtime if
things are flexbile enough) rather than being a configuration thing done
per board...  I had thought that this was configuration reflecting
different ways of taping out the IP with different feature sets, is that
not the case?

--jh2nlyaixolfggcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljtRk8ACgkQJNaLcl1U
h9CLDgf+M9DhYHfCGvepGUI42xmKuQfThWXEWGEqG3AWvay34FVJhdQzfBMwcYT3
/3OFaOyDM5EkfISPUZo0ZKpPqE6QHg5jlgodFbZD1rwX8kOl1FaFVDFq3k7d5d5/
5Y444c5D4/sfkUH9O3nANvyl2cBfYPys0UwzCU4S/+Nw/XvehvSF0mMOsz3a5dkh
CCdCWTjjcqOjQUDEnf2Enx866l+62vBbBWdYww23ijpgx6SUhRrsejDewuVEhUDb
jkBsF4dAp5675V2serc57020YmNRiM+Fu431FhJk7NGFocc7gFId3eksr0QRfQYg
mMPeywRQFdTFFdWEQfdfRMuCOWXeeA==
=C5cB
-----END PGP SIGNATURE-----

--jh2nlyaixolfggcy--

--===============9130808511986004486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9130808511986004486==--
