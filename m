From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 23:27:02 +0100
Message-ID: <20150505222702.GJ15510@sirena.org.uk>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
 <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5586724608114528225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D4D2604A7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:27:09 +0200 (CEST)
In-Reply-To: <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srinivas.sripathi@intel.com, Yang Fang <yang.a.fang@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, Denny Iriawan <denny.iriawan@intel.com>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============5586724608114528225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mtfogggI1YmpIpmy"
Content-Disposition: inline


--mtfogggI1YmpIpmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:02:01PM -0700, Dylan Reid wrote:
> On Tue, May 5, 2015 at 2:49 PM, Mark Brown <broonie@kernel.org> wrote:

> > Now I'm wondering if the headphone and microphone are expected to be a
> > single jack here?

> At least the Chromebook version will have a single combo jack.  I
> would expect there to be a single jack created that reports all of hp,
> mic, and buttons.

OK, so that should probably be fixed then.  For modern laptops I guess
this is the most common case.

--mtfogggI1YmpIpmy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUOyAAoJELSic+t+oim9vsoP/1eKepxrTctLWMmhELBCzYOe
GA0JqEUxwT+mNmz77opSxbEJVHe3vEML6dcqHOfUFhmLT4nG7qHHWgYvKaGXG5r5
gO/rlCfoDbKW3e3mIJDBOeg3IkKBxOsEvuD4HvdbX+ClhpEGUE077pUeOxADsEVz
3qpMuH50FfUSwrxOk5y1szY9uMkAX/mXjOIbz+rfTd7FYQ4F1KFLwH2mCk0PYcdy
36Kb2qTDGJ9JIdM2c9//KOc5p1dfaMLqCoYAp03Ba25o+lyQ36uwGBJa1itKqZGy
6mF27tDhXHov8efGkMiHiAnRDYSMiCDCwsYP739ZMKcsWNfFTKFdtgIvdoRmNmUv
M2eW2UlxfdsaYgynU4xPsO5cf8geyS63007YHksrzg89WJSD4IsLOWiECzyNugBT
cgqpaYUoiFximD9I1o/kh7T2ycR9Vr0utYZOIT8qaUBzLR0M6hJuYOodi6mbYJar
7RyNkSQDAnMLYP+ffQ6JLwj9oU8uajbvBVkbIOl5gp9fjoCVdp0dsdCE9+N6PSj6
mCD34inyKIdvxVPA5NwwnXrJrxXmC3dInd/BeXUL0BiD3fiycgHkbJz22o0jnPNY
ah/QaxBQWJUWK3yI0/GiicIDU29lmXQ0YJvrw1EYUko3DneentuS6Vh+XGBwIbip
vZS94Bd0A22Q+4xzF/h7
=iYS0
-----END PGP SIGNATURE-----

--mtfogggI1YmpIpmy--

--===============5586724608114528225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5586724608114528225==--
