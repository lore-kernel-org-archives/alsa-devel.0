From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Fri, 30 Jan 2015 13:33:44 +0100
Message-ID: <20150130123344.GE26617@finisterre.sirena.org.uk>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
 <20150128200951.GS21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA81DE@SHSMSX101.ccr.corp.intel.com>
 <20150129105143.GT21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA82B2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5179803822211482728=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DAB2656F0
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 09:28:37 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BA82B2@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5179803822211482728==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 29, 2015 at 01:18:18PM +0000, Jie, Yang wrote:

> > > setting idle_bias_off to false is the easiest solution for us, it is
> > > also reasonable here, because rt286 don't need soc core to set BIAS
> > > OFF specially when in idle status, (BIAS_OFF and BIAS_STANDBY are same for
> > it), and seems no side effect here.

> > Currently.  And to be honest I would have expected that the behaviour would
> > be the same with widgets on regardless of the bias level so we probably want
> > to fix that which would cause the same problem resurface even if it were
> > bodged around for now.

> [Keyon] OK, then I will try disable jack detection in the machine driver before calling snd_soc_suspend(), can you share example about how to set a NULL jack?

Several of the Wolfson drivers support setting a NULL jack to disable
detection, I can't think of any boards that currently use it due to the
need to use detection in suspend on platforms.

Looks like word wrapping is still not working in your mailer BTW.

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUy3onAAoJECTWi3JdVIfQ/4UH/3PMcIGZq+Lnn3yI/RmNMjLr
cLV0ZlM57Vf5ZapxAp3L8kMwLfu/6GU2T33mYIuMIFEAvxLbAkev6fgp9TqXHhp/
qksj1pL7zuzoICQ59SZNhwlxFf20UBeBYcDoNzVwSxckykP7DNtbGRpBFvp6HvEB
ozjRWHufoAWGeyU76jd3jhs10AXSY/kjjHbeM4DOrh0f8a7dpSBs2KbYeEPQgwH2
uqaF/uXQsvEbptci+cZj7ygByvtzztKJpo5Ib54Wvciw2LY+7RVmAu9fgbGAXz/1
r4ELIThQW88Bx1wNN+66rD704r1JDKZWBqrcgKCshuAg0qAak0oYegfj50lomg8=
=phLD
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--

--===============5179803822211482728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5179803822211482728==--
