From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/15] drm/edid: Add API to help find connection type
Date: Wed, 2 Dec 2015 18:07:01 +0100
Message-ID: <20151202170701.GB14019@ulmo>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-12-git-send-email-subhransu.s.prusty@intel.com>
 <87y4dd2n41.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1313798914=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87y4dd2n41.fsf@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1313798914==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 11:53:02AM +0200, Jani Nikula wrote:
> On Tue, 01 Dec 2015, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>=
 wrote:
> > To fill the audio infoframe it is required to identify the connection t=
ype
> > as DP or HDMI. So parse the required bits in ELD to find the connection
> > type.
> >
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  include/drm/drm_edid.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 2af9769..c7595a5 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -403,6 +403,16 @@ static inline int drm_eld_size(const uint8_t *eld)
> >  	return DRM_ELD_HEADER_BLOCK_SIZE + eld[DRM_ELD_BASELINE_ELD_LEN] * 4;
> >  }
> > =20
> > +/**
> > + * drm_eld_get_conn_type - Get device type hdmi/dp connected
> > + * @eld: pointer to an eld memory structure
> > + */
> > +static inline int drm_eld_get_conn_type(const uint8_t *eld)
> > +{
> > +	return (eld[DRM_ELD_SAD_COUNT_CONN_TYPE] & DRM_ELD_CONN_TYPE_MASK) >>
> > +		DRM_ELD_CONN_TYPE_SHIFT;
> > +}
>=20
> I'm not sure how much this helps when the caller still needs to
> magically know what the return value means...  Indeed the next patch
> with /* 0 is hdmi and 1 is DP */ and "conn_type =3D=3D 0" is a bit ugly.
>=20
> How about just not shifting the return value, and using
> DRM_ELD_CONN_TYPE_HDMI and DRM_ELD_CONN_TYPE_DP in the caller? Bonus
> points for referencing those in the kernel-doc above.

We already have a similar function for detecting HDMI vs. DVI (see the
drm_detect_hdmi_monitor()), so perhaps adhering to that convention might
be preferable. This could be:

	static inline bool drm_eld_detect_dp(const u8 *eld)
	{
		u8 type =3D eld[DRM_ELD_SAD_COUNT_CONN_TYPE] & DRM_ELD_CONN_TYPE_MASK;

		return type =3D=3D DRM_ELD_CONN_TYPE_DP;
	}

Thierry

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWXyUyAAoJEN0jrNd/PrOhoB8P/RJwTOJ6L4xarJe/37LB+LGQ
czKph9sYt5Mn/SsN7uMb8iSFS4UiGRD7KiCLX31wmijT4adN7upSgy59KSURoo79
JNVhghsDqCVwJjVXCry6kqVyJqwTjqwKIKOwJlH7o+N2kx605OkmoCITeD9AgQ23
uPf5CI8r1KhBGjEx8EItr9I2foZKmZE8HSwLp1Gbl8DM1WX5M+5KAf0A6bpLkL2u
WXfEIICB/tZl1AjvSEeCuKrBivTRnnwxORyOV3Ozx3rYh+YjzeeWXkBXcaftAsDB
pliVi2owMnXW9SZPia+7hjytr/kzc2rQRScvlbCZMTAE2zQUn2V10f5EXGMjAKMy
Ktz1NwgzH7hCayWywTBU29yJH9DLhfl0KWK1OUGs6iysQDjyoTSYZf4hDhueuC/E
S0PhsJCFCTqX/W/y1M4cNYGSE9w0K9hp5iO1ZjFl1KvPug/kvClzKxlPqEnfd/Pd
Q0nqw7MfY1oi9WaraetitToMLKdrcEEp5JDJCLcwvOiyRPzyd+sO80iB+x9jNiwU
6FeMbQ6J7syyUDDIBzRFtc0ukJM5KwKKsSRjCpTmIx7M9yn8Jzk6zDS+z/UvGyc2
JkYXUFGRTtx3BpnpH/p41cfcJ17YQb/2GGix6rcpxwNr1ZAeHUEUwxUXM4WSM1oS
eUT4/dcbMCuEC54CjVxe
=hyru
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

--===============1313798914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1313798914==--
