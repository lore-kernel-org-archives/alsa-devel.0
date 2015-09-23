From: Mark Brown <broonie@kernel.org>
Subject: Re: RT5640 jack detection
Date: Wed, 23 Sep 2015 09:37:46 -0700
Message-ID: <20150923163746.GR30445@sirena.org.uk>
References: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
 <1443025358.6977.71.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5002274322091787560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6759626057B
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 19:12:45 +0200 (CEST)
Received: from [70.35.39.2] (helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1ZfA4Z-0005jC-Nv
 for alsa-devel@alsa-project.org; Thu, 24 Sep 2015 17:12:43 +0000
In-Reply-To: <1443025358.6977.71.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org


--===============5002274322091787560==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y08JZfPv7c5uulCx"
Content-Disposition: inline


--y08JZfPv7c5uulCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2015 at 05:22:38PM +0100, Liam Girdwood wrote:
> + Realtek

And me.

> On Tue, 2015-09-22 at 11:18 +0200, Carlo Caione wrote:

> > The problem is that the jack sensing only works when the codec is
> > actively playing something, that is when the bias set for the codec is
> > not SND_SOC_BIAS_OFF. When the codec is suspended and it is powered
> > off I'm not able to detect anymore the presence of the jack. Because
> > of this issue actively switching the audio from HDMI to HP when the
> > jack is inserted is not working.

> > How this is usually supposed to be working?

> In situations like this it may be best to report jack status as removed
> when no BIAS is available for jack detection (since no one is using the
> codec anyway). The jack status could always be re-detected when BIAS is
> re-enabled.

That can upset userspaces - it means you get things like trying to play
a notification tone, starting, realising that a headphone is there and
trying to switch on the headphone in the middle of the notification
being played back which doesn't tend to work out so well.

What I'd expect the driver to be doing here is enabling whatever it
needs to do detection enabled while detection is enabled.  There's quite
a few examples of this in mainline - look for jack code that has DAPM
calls in it.

--y08JZfPv7c5uulCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAtVaAAoJECTWi3JdVIfQVtwH/2EkzI25irW/EQkhAqrasq80
84lYgRt9vFSfmdUeOpbYhw3RoK5btSf6qBoy4a5ogVB9ZtMGSF/vYMw/iLbTx/94
9gbOlFAlJWzwkTjj/EaFEvigprYmmDqPX0jyjF344A9O1FnG7u2fX30B5tCOZSLl
AoCO2/AHmSGlaZFmmTPjGbLvdQf8/CodBKeqr0bJ3gP32PXUk4QYHzm0Tg+t0s6c
JNXbXVawEO/6V6RiSsp4gwsaeVZdUw1QyVQsUYkKtPzDQb8d9fvUpGCjvic81Qg8
/l47EeLdmLMy9bnrLWW43pl6asNtLKf81DN3F0POjDktK5RJJWwU356c1GwcnJk=
=XlPj
-----END PGP SIGNATURE-----

--y08JZfPv7c5uulCx--

--===============5002274322091787560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5002274322091787560==--
