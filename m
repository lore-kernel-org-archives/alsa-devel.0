From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [v2 1/5] ASoC: Intel: mrfld - add the dsp sst
 driver
Date: Tue, 19 Aug 2014 21:32:23 +0530
Message-ID: <20140819160223.GR13288@intel.com>
References: <1408444627-28906-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408444627-28906-2-git-send-email-subhransu.s.prusty@intel.com>
 <20140819161117.GJ24407@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6002441975861643290=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BEF9F261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:17:40 +0200 (CEST)
In-Reply-To: <20140819161117.GJ24407@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6002441975861643290==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 11:11:17AM -0500, Mark Brown wrote:
> On Tue, Aug 19, 2014 at 04:07:03PM +0530, Subhransu S. Prusty wrote:
>=20
> >  sound/soc/intel/sst/sst.c                 | 443 ++++++++++++++
> >  sound/soc/intel/sst/sst.h                 | 654 ++++++++++++++++++++
> >  sound/soc/intel/sst/sst_drv_interface.c   | 475 +++++++++++++++
> >  sound/soc/intel/sst/sst_ipc.c             | 373 ++++++++++++
> >  sound/soc/intel/sst/sst_loader.c          | 975 ++++++++++++++++++++++=
++++++++
> >  sound/soc/intel/sst/sst_pvt.c             | 207 +++++++
> >  sound/soc/intel/sst/sst_stream.c          | 526 ++++++++++++++++
> >  11 files changed, 3696 insertions(+)
>=20
> As I indicated last time please split this up into smaller patches, for
> example one per file.  This is an enormous amount of code to look at in
> a single commit which is really going to slow down review.
Sorry looks like Shubranshu missed it. Yes we were supposed to do that so
you can ignore this series and we will resubmit with split of 1st patch :)

--=20
~Vinod

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJT83UPAAoJEHwUBw8lI4NHDLgP/i85zw6p6D5kQ+vTjm3XFoQ3
gNhVDypKf/dDKQqjuBXRcya+X39in07+cO6U/T9EDGKaqFAUPkkuP1OPlHtHOWjR
Xyg56zAXekOOketc7EOZc89xVjADusGnSrYSmUh82uXwVGPfSOHBYyAcLz9gLcyI
i62zx0wXipaALTMchoj46fqIEim8HtCgsmDjwurAI1luPlpAXzltjwr6OFX6OvlQ
Y3SJMGzB34IZ8uTBu7dzEeGqh5PUIBj+aPS+vNz/B7O83ErIOfptSY/4eIVylzb+
KezUtifV/m8kkxwfUQTvCakTXIabsMS4YtoDBxkrw4j0LD5eW6sqqMMHhA3lQP6Q
BzsZUX5ClhViaC15e9/7M8pnqPEVVU5Y3sdI137O3+E32w6vfxMjf+EXOEPzthHr
ycbGFIye2j9rrwdOiotAPn7lXSJjWVtSyxhRkyVb8IAG+0T9Hf3bfbkYqf9Jhixl
ehAHgzhGrAM4ggFirOeCxf1x65Q7ufatDfEFSX1/k+AHj5BvmMB+/hAHRJ+ZJB4e
mGQfLABdzk/Ixzf6ipttwhDBYKznoo/lQUeMi/ErgP7Ui4n0+VzkdD3q0VuFralS
ak3KhdEwywwN1EQEhtTRVwx8IN/ZHqfnDXI3gVcV3qTi3LpgJ2t/mzTMw1N24d8w
hR/IO46YqHOzN8uHtk3h
=8Pwx
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

--===============6002441975861643290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6002441975861643290==--
