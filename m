From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8741: Allow master clock
 switching
Date: Fri, 5 Jun 2015 20:00:37 +0100
Message-ID: <20150605190037.GG14071@sirena.org.uk>
References: <1433505944-3961-1-git-send-email-ce3a@gmx.de>
 <20150605152219.GA32730@opensource.wolfsonmicro.com>
 <5571F0CA.4040405@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3871426459895998584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AF5A2668F8
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 21:00:50 +0200 (CEST)
In-Reply-To: <5571F0CA.4040405@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============3871426459895998584==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bmpniq+Thlljzm46"
Content-Disposition: inline


--Bmpniq+Thlljzm46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 08:56:10PM +0200, Sergej Sawazki wrote:
> On 2015-06-05 at 05:22PM, Charles Keepax wrote:

> >Then you can keep this error check here and fail if we reach
> >hw_params and still don't have a SYSCLK. You will probably need
> >to provide a way to clear the SYSCLK though set_dai_sysclk as
> >well.

> Is snd_soc_dai_set_sysclk( , , 0, ) the right way to clear the SYSCLK?

Yes.

--Bmpniq+Thlljzm46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcfHUAAoJECTWi3JdVIfQ28gH/i//SCL1sP80YmaF8vmEwolH
B8OzJa69YaLpRnw8rjk7q57OUdgp6mvIwDRxCa+xhAqMTa4ULNCmw8EVL9FXPKle
X3O+Y+Xqy4xDbA9UItYYEJNmVq0GoIYlU079mreMTeADS9WvYDSlSVvDrextdT6u
pendoCh4a1dv8OGCqc7j6ac5rC2QkVkbX9TDja2T13JWXGJr+ObYtytorwdNbufO
sF8r9nAlqyrxW8NP0dglUVE6vgF8x6C7WTlrluQc5+F61w+0En+Vyp86yitVtQnY
c79ZvILIrLgZcOql2T+hEvHvsDTTB0YPyOMuJ4vOaUX+f4Qz9Tn2Hqja+p+zs5g=
=1DII
-----END PGP SIGNATURE-----

--Bmpniq+Thlljzm46--

--===============3871426459895998584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3871426459895998584==--
