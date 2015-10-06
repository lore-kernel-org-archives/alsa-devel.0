From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 6 Oct 2015 18:36:54 +0100
Message-ID: <20151006173654.GY12635@sirena.org.uk>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk>
 <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk>
 <1444144590.25504.27.camel@intel.com>
 <20151006162520.GB30592@sirena.org.uk>
 <5613F850.1040605@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7794164103682094145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3378B26574A
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 19:37:19 +0200 (CEST)
In-Reply-To: <5613F850.1040605@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7794164103682094145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V9quYs+BvGd8TtrI"
Content-Disposition: inline


--V9quYs+BvGd8TtrI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 06:35:28PM +0200, Lars-Peter Clausen wrote:
> On 10/06/2015 06:25 PM, Mark Brown wrote:

> > The problem isn't detecting the error, the point is that if someone
> > upgrades their kernel and someone changed the DAI link name then their
> > existing userspace will break.  We don't want that error to be there to
> > be detected in the first place.

> Another thing to consider is that the topology firmware might be developed
> against a non-upstream driver. And in order for the driver to go upstream it
> needs changes that breaks the ABI interface to the firmware which is already
> shipped and the vendor might not provide support for updating the firmware
> file. Having these kind of tightly coupled interdependencies between driver
> and firmware is quite risky business.

Yeah, I think we're kind of stuck with some degree of fairly tight
coupling at some point though - at some point we're going to need to
work out which link in the driver corresponds to which link in the
firmware file.

--V9quYs+BvGd8TtrI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFAaxAAoJECTWi3JdVIfQR4AH/iao/F4FnU35ZqZR8Od36PSG
BhVbSSNu4P2f1CSxqOtFUnxBS92qk/wH7G+zsFGe+7TMQMlitUvvBCjyo4jsc3sh
2PLK9Sdy9XZzpfWgpUZSLi+uhegdbDkiyt9m8qlekTjAn2LYvWp84actlUlYYyod
DWe2oWxDGCyXOdV2jnHTMt0QxbVsT8dH7ZcZ9IbbQdW3g3speQ2+WYKGYcXNdcrq
Cr0g7YTR+pCLRy8GDBHiSFI0gaKj7Og+59Czk3blPikAPgoNJdaGAIAv2sLSLNNu
B68gc8cHecWmMrhzTTmTbrax1RouGE/R3bukwwB9pW+d8KfxeFH0UGjPRGfGSns=
=jDXT
-----END PGP SIGNATURE-----

--V9quYs+BvGd8TtrI--

--===============7794164103682094145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7794164103682094145==--
