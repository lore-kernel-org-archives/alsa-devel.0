From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835: Increase channels_max to 8
Date: Sat, 4 Feb 2017 16:49:44 +0100
Message-ID: <20170204154944.timxhmmibc4kngly@sirena.org.uk>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3551148591226470024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16869266725
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 16:51:15 +0100 (CET)
In-Reply-To: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3551148591226470024==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a5ehrvmgb3dqpqga"
Content-Disposition: inline


--a5ehrvmgb3dqpqga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:

>  	switch (params_channels(params)) {
>  	case 2:
> +	case 8:
>  		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>  		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>  		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));

I can't understand how this works.  We're programming the hardware in an
identical fashion for both channel counts, that means that what we're
sending will be indistinguishable from a garbled stereo stream.  How
does this produce working clocks or manage to sync up reliably with
external clocks?

--a5ehrvmgb3dqpqga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliV+BcACgkQJNaLcl1U
h9B41wf/Us8iJqR4ICuVapsRof7NjBb9hp2eMCcu2bz7Y4wJUMDXVO5O7qbfiKgf
9riBFMc9v1wsdgDLT6fF89O7e/3YCdqACc+QrBMsdz56JXlBj7qCF4pQhFD9dIzE
JPx9hcSrtF8VZ3LBl9AD555KVpT1Xhi77qlB8isLBfryfD3PMflLG3dW9t/8lNmM
gEzLlw9OoMAyazp+GHkVDrJfdVeYQE6FgHghY/up5VgAFCbj83IkiYVl6FFSEFbk
FXPHzHuZ9d5ku3LsFmsl/DC4yjQzZ+hzWke+hA8rfAH2tFFamlENZNqG27qYedLt
4hzqSP4EKEgeHwuPzsuCeXK6VOt+kQ==
=b+tM
-----END PGP SIGNATURE-----

--a5ehrvmgb3dqpqga--

--===============3551148591226470024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3551148591226470024==--
