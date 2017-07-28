From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 4/6] ASoC: codecs: msm8916-wcd-analog:
 set default micbias voltage to 1.8
Date: Fri, 28 Jul 2017 15:01:19 +0100
Message-ID: <20170728140108.ds5x4irfep4ss3lv@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-5-srinivas.kandagatla@linaro.org>
 <20170728134038.y5wnrurmwn4bxxsh@sirena.org.uk>
 <94765031-d840-bcae-11e3-16e1e55a7aa7@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0839600092994743958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6A92676F1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 16:01:30 +0200 (CEST)
In-Reply-To: <94765031-d840-bcae-11e3-16e1e55a7aa7@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0839600092994743958==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xfpokctsbphjubmh"
Content-Disposition: inline


--xfpokctsbphjubmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:54:59PM +0100, Srinivas Kandagatla wrote:
> On 28/07/17 14:40, Mark Brown wrote:
> > On Wed, Jul 26, 2017 at 02:35:10AM +0200, srinivas.kandagatla@linaro.or=
g wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> > > This patch sets the default internal micbias voltage to 1.8v. This
> > > default value is required for mbhc buttons to work. Also adds dt
> > > bindings to allow the board level file to specify the required default
> > > micbias value.

> > What was the default previously?

> This was set to 2.7v previously for special headsets which have high
> impedance.

So obviously this will break existing users.  That's not OK. =20

--xfpokctsbphjubmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7Q6MACgkQJNaLcl1U
h9Dbrwf/RWlYj3n4YHy6ZvgFkA0FCTaO/5vRTjuxzpDOYWf91wlPGSxpTnQ+Px8s
f3GVENFPWFU8rzNNmxjUuA/bIG4w7bqrOTVABaE5h1g17BEtPAR4ZtCkralsxsrg
FUOtCMmrYxxhqQL5qPg9kZzhE4D1eWXPgpMUYOengO+c0aNBdQqtTVICnai73QMX
fz443Ix9xnUcrJDyNdjLW+vO85+WUvUh0Fv5KAkH0byynA3ZSMrOS4IomiYEfZwO
/JhVStdUuzSU3z0sVD5yzf88I2/sa6JpOt8xQSIANA7ajqqri4S4YJB15PM95DsG
QFLXVXoOniclXvDLmAQ7LBhgmhMuZg==
=03T/
-----END PGP SIGNATURE-----

--xfpokctsbphjubmh--

--===============0839600092994743958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0839600092994743958==--
