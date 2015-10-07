From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Wed, 7 Oct 2015 11:23:21 +0100
Message-ID: <20151007102321.GE12635@sirena.org.uk>
References: <20151002165907.GU12635@sirena.org.uk>
 <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk>
 <1444144590.25504.27.camel@intel.com>
 <20151006162520.GB30592@sirena.org.uk>
 <5613F850.1040605@metafoo.de>
 <20151006173654.GY12635@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F84B85136A@shsmsx102.ccr.corp.intel.com>
 <s5hy4ff8064.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0911031626682179641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3BDF265AFC
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:25:14 +0200 (CEST)
In-Reply-To: <s5hy4ff8064.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0911031626682179641==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uFTSkOzRR7IG1lTO"
Content-Disposition: inline


--uFTSkOzRR7IG1lTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 07, 2015 at 12:04:19PM +0200, Takashi Iwai wrote:

> How about to allow leaving this name empty as default?  Or better to
> ask: what's the exact merit of having strict binding to DAI link?

Well, if the topology is describing something like a phone at some point
you're going to need to work out what is connected to for example the
modem and the bluetooth, and you're probably going to want to have
different processing pipelines in front of each.

--uFTSkOzRR7IG1lTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFPKUAAoJECTWi3JdVIfQ7JEH/jeVjeLgL905nuQNYmT9RSzx
dxC7u9HtPzp36nfY8fX+LhwMNCklAGs3b83ndpcfjmfSjOrNgpu6gRd65UynxGSx
EqdGY3JS1Ym4e2djuTTr1+1Qi+dITJY3IsnBZK972ozpaRdednrPTfTcsyGjO/RO
Z6gt7Ih/jMZtATwOXG33C1jFDlElv29lA6O2z3beGf+dU0/Ccc1u9na1f4PmjQmV
HegpCQn301c8dUY2IcXAyRX5t97PWGcQJAEbQ3YlYSmPJFWLIZpfLvaFMGzrAROg
oHeA+HPk5pcNR7fUo9cwe1EeuNS3fpZ0alx9Hss8oAjeI8HnqNAQWXzS53kKbxA=
=J/ug
-----END PGP SIGNATURE-----

--uFTSkOzRR7IG1lTO--

--===============0911031626682179641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0911031626682179641==--
