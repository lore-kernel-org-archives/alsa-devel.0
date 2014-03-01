From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 2/3] ASoC: io: New signature for
 snd_soc_codec_set_cache_io()
Date: Sat, 1 Mar 2014 13:34:58 +0900
Message-ID: <20140301043458.GR29849@sirena.org.uk>
References: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
 <1393578267-18255-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8069212095115580802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8674626522D
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 05:35:03 +0100 (CET)
In-Reply-To: <1393578267-18255-3-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8069212095115580802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpDyejMaDGJhP2PU"
Content-Disposition: inline


--RpDyejMaDGJhP2PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2014 at 05:04:26PM +0800, Xiubo Li wrote:
> Now that all users have been converted to regmap and the config.reg_bits
> and config.val_bits can be setted by each user through regmap core API.
> So these two params are redundant here.

Actually, I think the way to fix the issue with CODECs doing I/O in
probe is to provide a way for drivers to specify a regmap when
registering the CODEC (rather than during probe) and then move the
initialisation of the regmap before the probe function is called.  That
would make set_cache_io() go away entirely.

--RpDyejMaDGJhP2PU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEWNqAAoJELSic+t+oim9c4QP/jL6yuE+Yh4zOeu80Y46621C
rd4gXZjXrXpNwYtKILLFQbiaMcRw8+Y4RM8fB2ysyOCYG5nadHOg7Oo81pP5AOVU
QQS6Z9cbsq6GGxeRfz9XDzGPUyHCEuDstGQBgodYC+fYRpthlvXafCeDWaxIYhqX
F5d4W7gKqGNWFcE2fmztCg2gLw3945Cn7wTjLzmftvb9yIpFcvJaqNV2sohe5Wo6
wQ69Ym73FN6fs+uQrjxxaC+lJe79K2xtrk8kzTCVHd1dMkSzp7/Pv18XtCMXBrin
BWGHUfQcgjzAoz3cx4gTNrllUsMG8jGRtdqx+NHjcE5dvhitD8MMk3JD/hHw/ANM
7HOcQeG8/h1eq/3nqMy+cP2IB96eKrWeLPi92/5YZpsWvd59vOOAOUNj5bYUW78Y
D84PbLBAcDUPpioRVLZEtDTLr0kc5Hf2AAGQoOGddjia8k3DEc3hNZCzUiQ2FZv2
b0cIvYvyU2HuWQenbb+GIjKgcAPFJHVVPVmbm0TjRAqPOkw0Hqd2hzZJCC/d6K4E
azYuzyptVmRAc4vcwYk5yq3YKxKojxvhh09sIiaCIP3ff2rV3tO2ra4NliHILxDs
05+sHFaK+IGXQ+3laL4nQI/7ACnitvWVue/L/H9o/vLvo+orNp9oSdsPzbEVqEik
6woyF/tasx+VsSw7vRms
=6X7Z
-----END PGP SIGNATURE-----

--RpDyejMaDGJhP2PU--

--===============8069212095115580802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8069212095115580802==--
