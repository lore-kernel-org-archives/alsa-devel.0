From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 17 Aug 2015 13:05:02 -0700
Message-ID: <20150817200502.GZ10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de>
 <20150815155035.GG10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
 <1439807999.2420.25.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5553998937000008511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B54E26042F
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 22:05:06 +0200 (CEST)
In-Reply-To: <1439807999.2420.25.camel@loki>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============5553998937000008511==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R/QHK6DDZDf/Yghh"
Content-Disposition: inline


--R/QHK6DDZDf/Yghh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 11:39:59AM +0100, Liam Girdwood wrote:

> The intention is that the topology data for BE and codec style links is
> not to define the link (as this should come from DT or ACPI) but to
> define the links config/capabilities for a given FW. e.g. we have two
> different FWs that run BE0 (SSP0) with different number of channels (one
> is stereo, the other is 4 channel TDM). Currently the link definitions
> will be hard coded until the ACPI data is ready.

> The FE uses the above too for config/capabilities but it can also be
> defined and created by the topology data (since it's a FW entity).

So this is actually for adding further constraints to the existing
physical links, not just for defining new virtual links.  That is
definitely a reasonable application but it seems like what we should be
doing here is adding constraints to a fully defined link rather than
just having a dummy link.  The link is real and there, it's just that we
want to further restrict how it can be used.  Something that says "this
is a dummy link" definitely feels wrong.

--R/QHK6DDZDf/Yghh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0j5uAAoJECTWi3JdVIfQ6fkH/3quOzi2+tKy/bEp9VOz1bTn
ToOpQ1segTF4CoIixVwrl93BZik6+Of/2T6O2PbktWMsJe1bylOYh7vPpcA+6G37
bLhOMqXn4QG3TsmhrcMcJepU0SI3MwcbGjklXK652rcYLXW7zW98J9SXFe/tv2xA
msdhz4PXSYyhShrtiJv39ohlOtXzuTFM8z6uzN08+jWv6exryuss+tDlIgb/r672
ODehkFGP5pbmQpx0L3Xwib0HCU4cdv4busR0fx0lb9vnWeZGGuxK+rUv+ASYDBLw
6DYB6lausBgKOAEFTUVlk9ls15HIhfhUxM4m5Z11N1a76dFDehcP0Q8Q8aWmAnk=
=8jET
-----END PGP SIGNATURE-----

--R/QHK6DDZDf/Yghh--

--===============5553998937000008511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5553998937000008511==--
