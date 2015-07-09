From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/6] ASoC: Intel: fix kconfig,
	symbols and sparse
Date: Thu, 9 Jul 2015 10:17:03 +0530
Message-ID: <20150709044703.GJ836@localhost>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
 <20150708182423.GW11162@sirena.org.uk>
 <20150709044022.GH836@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9111502630567827389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 88EE9265CA8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:45:17 +0200 (CEST)
In-Reply-To: <20150709044022.GH836@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9111502630567827389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 10:10:22AM +0530, Vinod Koul wrote:
> On Wed, Jul 08, 2015 at 07:24:23PM +0100, Mark Brown wrote:
> > On Fri, Jun 19, 2015 at 11:55:25PM +0530, Vinod Koul wrote:
> >=20
> > > Vinod Koul (6):
> > >   ASoC: Intel: use CONFIG_SND_SOC for intel boards
> > >   ASoC: Intel: kconfig - Move DW_DMAC_CORE dependency to machines
> > >   ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
> > >   ASOC: intel - hsw: fix sparse unused varible warn
> > >   ASoC: intel - atom: statify sst_slot_enum_info
> > >   ASoC: Intel -atom: fix sst_platform_compr_ops declaration
> >=20
> > Please try to use commit message styles that are consistent with that
> > for the subsystem, these aren't even consistent within the series :(
> Sorry about that, will repost with these fixed
And you have applied this, Thanks a bunch. I will be extra careful on this
:)
Which also means either you have turned off your applied scripts or it borke

--=20
~Vinod

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfzHAAoJEHwUBw8lI4NHtBsQANMuKIxEPTtvP0JWaS07XmQo
rGTxEE6EXSOOka78ae5XuUSAzOi9BJHdeHQRjTO7ZjPKYm/Nsxu0RijWjwtwMpwI
tHoSwSVsXnG+O4/7gV8apzIBwMLTFPXNV7dkp7Q31aUsy9PPVNwmW4zyKq9OLinG
WMdo5C/J6C6SDZEecJXIjvGl3KcREP0lQ4FlK6oKrT/VDGEt5tz6Qcc+t4YjZNVU
2hh00Y6GjbHkSRxsUDDpZEJN/pMXwsllesaVhR06A3W3ThItpgSvPdTiZv7eV5Od
959zjd7OAV+wBJ5jgW9NJ6PN17AMzMDZlJCI9u78SiHT7R3E3S3nnPxuLPbbtXnb
jfFKTdEXDdb3LpznYK2NzN1DByj7mh4sSkCeo4yBaQVkSvzpWR17f9FdqUpcMxCR
2iR9BlICIwFggl/ODmUWq9HAz8wMnAdzo2ZKpWErK/PpXQ6YRyCkKS/aNYNj0KhN
XzYNoI6hnxp8cQhYvQqQBir/HGnbIm12vKBd7IlzqkLnG/B/IZyDd0kwg5pOY34y
ytjgUB5Zew1T7om3sHjetYyBGLnUr2WWohok4grVX09tC0+8UO5DyHtaHr42xVDF
XDViJJvvG8w0Ypd/O4o90CIJUdY/NbRGUXGiyXommPIHbJSFcltWunW+8komDp/L
04X99IVQbQoYAjA4jpTp
=LXwi
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--

--===============9111502630567827389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9111502630567827389==--
