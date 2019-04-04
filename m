From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Date: Thu, 4 Apr 2019 12:47:04 +0700
Message-ID: <20190404054704.GN5748@sirena.org.uk>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
 <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114704039031081348=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, apatard@mandriva.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org


--===============0114704039031081348==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wwtQuX191/I956S7"
Content-Disposition: inline


--wwtQuX191/I956S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 03:23:35PM +0200, Olivier Moysan wrote:
> Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
> instead of deprecated SND_SOC_DAPM_MICBIAS.

There are existing users in mainline, have they all been updated to be
compatible with this, or verified that they don't need updates?

--wwtQuX191/I956S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylmlgACgkQJNaLcl1U
h9BOnAf+PPQFLLTsRJ7K59cQlzHC/KzeoMMsp5NZ8ya8aE9dR0f0Qsmdd9C2TBbv
7DQectXbqeSTHvK+lKeRDOaqLseOulblX5eioaayMSXrXgaQbSISOEp/jkonZI9Y
pc5qLhabKNKYGcYBFRwIUyTI/S/vBmbvQdbl9cTHiUmbTWpDmQi7rDzsB+XcM1RS
mYU7U1klquugB3orcCCoKe19wnOA75kfwKZVPFPv0QhUUJFU1qk35C/wjYKF6z8b
xXT+4cYj2YtSZ7O7Uoh5h0p+qSTSMfFToG2ry6qJ2UTKIg8Lp2TgU4epGz22uA0v
zwBJPJ0xTEqrG/a55i1+QI7I71w+MQ==
=GYiY
-----END PGP SIGNATURE-----

--wwtQuX191/I956S7--


--===============0114704039031081348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0114704039031081348==--
