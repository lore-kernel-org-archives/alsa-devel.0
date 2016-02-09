From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/7] ASoC: Intel: Skylake: Add MCLK
	configuration
Date: Tue, 9 Feb 2016 08:15:27 +0530
Message-ID: <20160209024526.GB19598@localhost>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
 <1454654950-23091-5-git-send-email-vinod.koul@intel.com>
 <20160208164304.GH7265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8400189880765756663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CD8462608B1
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 03:41:47 +0100 (CET)
In-Reply-To: <20160208164304.GH7265@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8400189880765756663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 04:43:04PM +0000, Mark Brown wrote:
> On Fri, Feb 05, 2016 at 12:19:07PM +0530, Vinod Koul wrote:
> > From: "Dharageswari.R" <dharageswari.r@intel.com>
> >=20
> > The SoC has MCLK output which is typically required by codecs.
> > The MCLK is controlled by DSP FW, so driver can configure that by
> > sending DMA_CONTROL IPC. The configuration for MCLK is present
> > in the endpoint blob.
>=20
> For integration with CODEC drivers this clock should really be exposed
> via the clock API too.

Ideally yes.

I think then the our driver should register as a clock provider too. I will
check and see how we can get this done

Thanks
--=20
~Vinod

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuVLGAAoJEHwUBw8lI4NHwG4QALg79oVdo5fpBWfFtP42SFu1
0Kh4OOXvZlNFzDnsU1+pvnsk7UnUD7mizmQqjIfU4maHAK8/Gh7f7SjHA2OCljr2
i4L0ZJIuab9IsvESHRbP8Y7DnFVH33SJ6KxEpcZqorB4Slt16TI1q7SwyItuEZji
T15GARNxP78NyHrfUWef6fL4cYtswYF5ls00urCWZ6QDDbKiSGDL2GhP/vMtFlLV
R2rORIck/308EcmfoZntbRr3NlMMPW4TbB/z8PU3E7d4C1x+aBJWfuyL16iQf2ib
k2Oa+YcOVgy+A77l7tcFLu5vKpxXd+aI1CtsgmxhvTob2kAIHqYC/yuXEV5p0NPh
oR/NxtdZvdbnjLzl6N0XMznGCGiL443hl2e2j4iWL4xck+muR1Ra+dzxJCggWiYz
gLXV5IqFd+PNgcNCw3SVx1RYe/G2LZ2z7HngC3QbwMGhy3B9CTWEmBETdDZU247O
7mwUzdCqeA7oWbSDeLmjiyKjwtgtuUnK6/X8i2E5SWjFLlkMDAb5kMwRXSnXgRbm
hrskv8gXh4GvE8tQz+aeiQwWUJwNzkkazTlLJb+fk7tpcPMTvqR1eJtQkz0rjmB2
Mqqwz0tZzO0lWKuE0dw/YU9xQgrqGSXfa4CExIUwsEL7tFQIOBO2TirRQTmvlL4E
AGxgRKIdgq3EJfG0y/UG
=OvuG
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============8400189880765756663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8400189880765756663==--
