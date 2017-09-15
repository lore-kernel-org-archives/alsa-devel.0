From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Revert Hotword Model control
Date: Fri, 15 Sep 2017 09:36:14 -0700
Message-ID: <20170915163614.u3nxpay4w43g3dv6@sirena.org.uk>
References: <20170915043200.9373-1-hychao@chromium.org>
 <0125c9d5-fcc0-d936-5368-43a75b1228b9@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8598504959608258393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F521266B20
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 18:36:18 +0200 (CEST)
In-Reply-To: <0125c9d5-fcc0-d936-5368-43a75b1228b9@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Hsin-Yu Chao <hychao@chromium.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8598504959608258393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fk35ho6dp5zexuw6"
Content-Disposition: inline


--fk35ho6dp5zexuw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 15, 2017 at 01:59:09PM +0900, Takashi Sakamoto wrote:

> I note that ALSA hwdep interface for userspace includes
> 'SNDRV_HWDEP_IOCTL_DSP_LOAD' ioctl(2) command to load binary blob from
> userspace.

The problem I see with that is that these things are generally settings
that people might want to change dynamically at runtime so you really
want to be able to change these things via controls like everything else
about the configuration.  If they were just fixed and unchanging in a
system then request_firmware() would be a good mechanism that's a bit
more modern than the ioctl.

--fk35ho6dp5zexuw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm8AX0ACgkQJNaLcl1U
h9CY2wf+LGZUfFANRDnISIUO0r+lrkBkDafOaBS+hq1p7fEbQ340/5apjt2WUUb2
tH6ONYDxt5rS+W29IBVKARucYb1/YQ0A2QKYtSMhjUHrbpUuniTfjkevI2liLdIq
/flWdjx7en6c7ggutFGGVsUuelpFn9RfRDGvqnd+Zfq+yGmAVCozOLpIDjolHjup
wPXKEW89+uuqx4jSyH2gNS2Lf9mnvAIpRkkENCc3AuBNHcqcrxULDC1wNQN4Dy/o
QxiRSuyHBGP6zD2X5sIQVvd8r+1mMlw7ujY5c9+rT0yMjePSC5+Go37yVVRepSdy
X41a2rzf+0rhehfGKZlJpilZwrOYXw==
=kLlk
-----END PGP SIGNATURE-----

--fk35ho6dp5zexuw6--

--===============8598504959608258393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8598504959608258393==--
