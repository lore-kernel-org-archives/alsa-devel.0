From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Wed, 6 May 2015 00:00:05 +0100
Message-ID: <20150505230005.GP15510@sirena.org.uk>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
 <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
 <20150505221415.GA109322@mocha>
 <20150505223028.GK15510@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718CCC12F@ORSMSX113.amr.corp.intel.com>
 <CAEUnVG5Kcht5wV-o1d+o4D3z0q-Xau1XSQ58_W=xWyUZHGQi1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0029938459455388296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F01792657FF
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 01:00:12 +0200 (CEST)
In-Reply-To: <CAEUnVG5Kcht5wV-o1d+o4D3z0q-Xau1XSQ58_W=xWyUZHGQi1w@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Fang,
 Yang A" <yang.a.fang@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, Bard Liao <bardliao@realtek.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0029938459455388296==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XGa1tAsZatFDHe4P"
Content-Disposition: inline


--XGa1tAsZatFDHe4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:42:52PM -0700, Dylan Reid wrote:
> On Tue, May 5, 2015 at 3:39 PM, Fang, Yang A <yang.a.fang@intel.com> wrote:

> >> It's fine to do that in the CODEC driver and actually good for the headphone
> >> and microphone - the board can always pass in the same jack for all of them
> >> but if it does have split headphone and mic jacks then it can do that.

> > Thanks. I will post v2 after Bard modifies the api

> If I'm interpreting Mark's comment correctly, he is suggesting that
> the API remain the same and have cht_bsw_rt5645.c pass the same jack
> to all three parameters.  I like this idea, as unlike the 227e driver
> the 5650 could be used with separate hp and mic jacks. I'd imagine
> there wouldn't be a button jack in that case since that is headset
> specific, but that shouldn't matter.

Yes, that's what I meant - I had originally interpreted the ability to
specify the buttons separately as the ability to turn button detection
on or off from the machine driver, either the same as mic or null.

--XGa1tAsZatFDHe4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUttAAoJELSic+t+oim9ZpAP/0Auqh8Bba/MXtw/R+TFgioe
SYSUoEFJU9pwN779eY8jNBjsmtZGfdwY7Cw6s8XHM8pKpUNmkMt4XsXOYxZngV79
IUS8x4nHT7VerWxZTxGuP+ZhuPDBtSY5G0j15T5ttmibOblIJ9tP6mNWjfJ8OhBP
fvPzbMP9WUIRAuac59u5+ReqNl/7BjrsK1W2vnhrcgJux2aQcU8lOaaklFLBetIG
B6INi+xcMWjV3JRvuwD5OM9+m0f8dCDKxIeGf8WepqijhC1ELvT876C0LQDvTOca
zaUaphKulnb0E84n6bPVkfhaAT23drngSL2wPwQpHWHgZVKuevApTNgknlenFaYr
Z79x7Tnt+33SeHDVjpLkDJKxa7hYLEH2q4LhCUQPZiWUFkRen/XmOyGxKWRKnQxC
viUzWr7LsCp6JFnyoXVfbRkhLXaZzqgDrH67rlUnkRb6iPn6I4NtkARupunNCzYh
20wTiChVeM3nAQxIfUSRJFPE9Mnj7yJTePTOyFe9ynUsqAlpzAjak1HPUSTT3YvI
gjlYnmuCJpgRxQdhB+L4r1qs6bKCT+cUHc8zP8nEyR44rcObILEU2vcf5sYSYWhN
lqYy/CAFUfIZURsYzsgAILQR4uW5w6tWFuh3yAh+xUm09S9vcVzOM/Yq5sbK3lEC
1slis/nCXATzNzNiFG6R
=kJDc
-----END PGP SIGNATURE-----

--XGa1tAsZatFDHe4P--

--===============0029938459455388296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0029938459455388296==--
