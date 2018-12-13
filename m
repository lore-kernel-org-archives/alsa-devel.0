From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
	Interface driver.
Date: Thu, 13 Dec 2018 14:33:51 +0000
Message-ID: <20181213143351.GI10669@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <1544696446.7700.31.camel@nxp.com>
 <1544709475.7700.35.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0431022702123899463=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F254B26789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 15:33:51 +0100 (CET)
In-Reply-To: <1544709475.7700.35.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0431022702123899463==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 01:57:56PM +0000, Cosmin Samoila wrote:

> > > > +	"Disabled", "Enabled",
> > > > +};
> > > Same here.

> > Will fix it.

> What do you mean by "regular controls" with "Switch"?
> I can add switch in the naming but we need to save the user
> configuration when doing the initialization (i.e. having custom put &
> get).

Not an enum, a normal number based control.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSbc4ACgkQJNaLcl1U
h9CZMgf+I0sDmvYGq8Ax7gEVK/RJYoedNVctPkrQPK+JqVaGdgWhCorrtEvWrxZs
pO4jVONeb3Z9o1j1+EZLUJf35LkzurrrIUmJIgsvd/jqsL7McG/5c6Lwf8mmD0Yr
WKpaWCgcHjAGkvYgoEIakP8wUWc5qlPD9BudWibGGpItRDlHwpZKtdxnFVlYmyxy
shLGSXQ/8gySMbY14NUF23ZZgKhQ6I3nlvXiUxM0qKDUFFIXDU/2owQ9+fWSvfHb
iClxvLnGqTkUzjFMoNzGV5raGCDaLBvsQ3aFVXdVlnScBhWbrwBYyWptFR56kThp
saxCbUJnCcFRMB8eCPy9OS9m+kAfcA==
=ET93
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

--===============0431022702123899463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0431022702123899463==--
