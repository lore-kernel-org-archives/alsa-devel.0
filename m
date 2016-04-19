From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Tue, 19 Apr 2016 10:46:29 +0100
Message-ID: <20160419094629.GP3217@sirena.org.uk>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
 <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8953424391775764720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF9226581B
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 11:46:36 +0200 (CEST)
In-Reply-To: <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8953424391775764720==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4TjKedF+bau4YbxU"
Content-Disposition: inline


--4TjKedF+bau4YbxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 01:20:35PM -0700, anish kumar wrote:
> On Mon, Apr 18, 2016 at 9:47 AM, Mark Brown <broonie@kernel.org> wrote:

> > As I said last time I would expect this to be a TLV control.  As far as
> > I can tell this is basically functioning as a maximum volume.  Otherwise
> > this looks good.

> I responded to your comment earlier but there was no reply so I thought
> it is accepted this way. Excuse my understanding. It is not actually a volume
> but described as such.

If it's measured in dB I'd still expect a TLV control.

> It is "Speaker No-Load Output Voltage Maximum". It is
> described here on page 50.
> https://datasheets.maximintegrated.com/en/ds/MAX98371.pdf

Hrm, that looks like the driver may be able to set it automatically
using the regulator API and just have a switch for the guaranteed.

--4TjKedF+bau4YbxU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFf50AAoJECTWi3JdVIfQgrkIAIHH02hW2VPkMVjQWMTTxVlW
8kpRETH+aCqrFzp6j0lHttnvNFM57o7beTEJZQP9agqjgTnxcHN8jQU1xteTNVid
s8oG/EMxatYlDrwVWvUenTZ4MlmggXDZ8T+X/nLsapOTeFrH4STOh4rPwQ5siFJ8
UQVHwWA+jGwzuBMF3978OdQzvryaKf4pnE6C2/fMwacWmgE0pyBOn/AICHRuypZm
UOYrmQNgvuVnl+41Bjh9Yx/mOAGxKAIKEXyvpTsCOw2Je7m9NbH74y+JS9RmvLCz
ffiVBeb5Ly6R7I6mB1i2C0tlVUtFMz2SNK9bDc0E4NGLCKrK/kFALv4HwfOQKpM=
=/UpX
-----END PGP SIGNATURE-----

--4TjKedF+bau4YbxU--

--===============8953424391775764720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8953424391775764720==--
