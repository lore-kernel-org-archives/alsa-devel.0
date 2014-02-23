From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 050/102] ASoC: wm8731: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:34:40 +0900
Message-ID: <20140223023440.GP25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-23-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784154355225980287=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E94B22650AB
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:35:18 +0100 (CET)
Received: from e0109-106-188-159-64.uqwimax.jp ([106.188.159.64]
 helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WHOuT-0008Pt-KB
 for alsa-devel@alsa-project.org; Sun, 23 Feb 2014 02:35:17 +0000
In-Reply-To: <1392723517-12772-23-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7784154355225980287==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYEXny2b0/vlBQCR"
Content-Disposition: inline


--xYEXny2b0/vlBQCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:06PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--xYEXny2b0/vlBQCR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV48AAoJELSic+t+oim9zm0QAIMrBWGAHVQF0FuZO4t08O0b
LrvWkE8fwYRXXppT7fyB7KZsmj53rWDcF9tzcuNYta71RgKlbJfCIH+QCCM20gn8
cwBLCNe3hcIDwX8wOUfnfhsGAIeJxxJpBlxUbB9wMU/0NXSOSiSUtVXSorEPXcw1
+Bk/kbI34s8+u5bjIX3oaqsnbv5mMqF0QbWZF99Vvvjp4I+mE9yCUsRxY+QRxQI6
XjgciFrXyMT2rAD0gy7lYuXchhegXedc4C5W4r+1hGp34MTDL4yiLUR3jlzMGFGO
G7EtfWM5nVdkkxjr0zax+mczAdhwOv9PaahjGyirlbl1QJLsY1iAXKlrEvGCvDwD
ITC5nhVZ0zMh58N9HkwclNw+N44ExVuc5uePtg9Pq+XpKG8ZLRqCi4HQ/nCds62A
KUl5qnQaS5gzE4ei0iy16XtSaHaYS1vpbmHbdOu028CUPMYOSFwgHMh8zRUMFdOc
/xdUp2u8jAJp/+1pS2FIY4xQka/jUWJNGzWyVSqp0L7xfXXyPw3S0ofqG6EVyodi
mb/2iKd67O3wDEIbEop8EYTBMR8maEp+Hdi+gc29YJY5/EpY8iTjXgRV16Vo6UtY
opm0u0u5fYQ8NXFqIBWF5vNuR4G3wrzsXrpUps7IkEbejzGykc7fVCFt2ILrg5ok
KSUz0F/dWU3rbWDGs3rH
=kcFd
-----END PGP SIGNATURE-----

--xYEXny2b0/vlBQCR--

--===============7784154355225980287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7784154355225980287==--
