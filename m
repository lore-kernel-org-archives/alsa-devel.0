From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC:rt5670:Add runtime PM support
Date: Fri, 7 Nov 2014 09:44:19 +0000
Message-ID: <20141107094419.GX8509@sirena.org.uk>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
 <20141106055525.GN8509@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B70D607@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0661624106993338036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D36BC2655A5
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 10:45:16 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B70D607@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "bardliao@realtek.com" <bardliao@realtek.com>, "flove@realtek.com" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0661624106993338036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dfd2vGAGWPaUxtUA"
Content-Disposition: inline


--dfd2vGAGWPaUxtUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2014 at 09:24:54AM +0000, Lin, Mengdong wrote:

> > > +static int rt5670_runtime_resume(struct device *dev) {
> > > +	return 0;
> > > +}

> > This should be undoing the change done on suspend otherwise we'll be stuck
> > on the internal clock after resuming.  Alternatively if something will undo that
> > elsewhere then presumably we don't need to use runtime PM to select the
> > internal clock anyway?

> Is it okay to restore default sysclock setting is runtime_resume ops?

Yes, that's fine of course - I'm just assuming that this works already
so presumably there is some restore code somewhere already that should
be removed?

--dfd2vGAGWPaUxtUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXJRyAAoJECTWi3JdVIfQDtsH/0vvZHnDtFNZ8ssduG1xAa14
JdcBsHYewR7py5ORRJDJWZgpPFgEL43mtI0zdchDSO3KrGeYzxAWPyc37Q53zKxT
S76AhnM1LsJDuWdeksaCrjTaGmLdpEEi2ESuqLmBlaAfGqv10qsiZFdqLKcTjn3R
qg0Y/fnrZjE5VsatC6v5mCkODnur4ZBsvm8aOzHIULcBDE3zKoMjBuGIbhN/k6eX
LW8R5w0g4ClaJe8nt43ojm5VivkxoeMZLsjdSzJoMID2FTtIcSG/ecYBC9D/8NZo
OKuknedlYEHM2Nfr7HpT1SzPhivab9oeq5FUoe4fm0iAAUCY7N0oASuPYtcH9mI=
=nsUw
-----END PGP SIGNATURE-----

--dfd2vGAGWPaUxtUA--

--===============0661624106993338036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0661624106993338036==--
