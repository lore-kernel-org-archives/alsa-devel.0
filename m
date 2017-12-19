From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Tue, 19 Dec 2017 09:35:06 +0000
Message-ID: <20171219093506.GD8563@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
 <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4446897338263980712=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B93266D71
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:35:16 +0100 (CET)
In-Reply-To: <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
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
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org


--===============4446897338263980712==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 03:15:22PM +0000, Olivier MOYSAN wrote:

> You are right. wm8994 allows to select either MCLK for each AIF.
>  From this point of view, the current patch is too limiting.
> MCLK information in DT allows to enforce MCLK use, but an additionnal=20
> information is required to determine AIF MCLK assignment.
> Available properties in codec DAI node, such as clocks property, cannot=
=20
> help here.

> Maybe a DAPM linked to a control is a better way to select AIF source,
> When source is not provided by clk_id in wm8994_set_dai_sysclk().
> In this case, wm8994_set_dai_sysclk() would only have to check
> if clock source is not already set.

> Please let me know if this option sounds better to you.

What are you trying to accomplish here?  You appear to be trying to move
the system clocking configuration from the machine driver to the CODEC
which is not how things are supposed to work.

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo43UkACgkQJNaLcl1U
h9Dlewf46ijTmkCKiBVGv/obt7JOlmZ3tY4XH/F5R3/zhaCeWAtmDk4BwzgnOhBH
lRhoY8faPLPiu/yF98fpMeG7YeUa/E4PyPPUo0qtYiEkzXttep5XHNT3z9bRZA+R
RMelG28CyT2u99jmOYOldzwaMD7RDBAoPWJAk442mrsezas3IYMeDhBcGNLF2mIO
BZHeb3IIyaiv735VlvLIyoDFbrhqCEZmw+RW+8T/HTRD7lINpUFP1Hc6EsQEBimW
20VQ73GdbNYyNM4+D+MdczOphX7NGzzSbMpbId9w/1IcxokS1bknVAAI/NTBZONR
HiR6NG+R3ypuJJWuomFWubZDuBJ7
=aGKP
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--

--===============4446897338263980712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4446897338263980712==--
