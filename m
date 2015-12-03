From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [alsa-devel] [PATCH 12/15] drm/edid: Add API to help find
 connection type
Date: Thu, 3 Dec 2015 12:21:42 +0100
Message-ID: <20151203112142.GB22213@ulmo.nvidia.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-12-git-send-email-subhransu.s.prusty@intel.com>
 <87y4dd2n41.fsf@intel.com> <20151202170701.GB14019@ulmo>
 <20151203160824.GA26240@subhransu-desktop>
 <87zixr23hf.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939479766=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87zixr23hf.fsf@intel.com>
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


--===============1939479766==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2015 at 01:09:16PM +0200, Jani Nikula wrote:
> On Thu, 03 Dec 2015, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>=
 wrote:
> > On Wed, Dec 02, 2015 at 06:07:01PM +0100, Thierry Reding wrote:
> >> On Wed, Dec 02, 2015 at 11:53:02AM +0200, Jani Nikula wrote:
> >> > On Tue, 01 Dec 2015, "Subhransu S. Prusty" <subhransu.s.prusty@intel=
=2Ecom> wrote:
> >> > > To fill the audio infoframe it is required to identify the connect=
ion type
> >> > > as DP or HDMI. So parse the required bits in ELD to find the conne=
ction
> >> > > type.
> >> > >
> >> > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >> > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >> > > Cc: David Airlie <airlied@linux.ie>
> >> > > Cc: dri-devel@lists.freedesktop.org
> >> > > Cc: Daniel Vetter <daniel.vetter@intel.com>
> >> > > ---
> >> > >  include/drm/drm_edid.h | 10 ++++++++++
> >> > >  1 file changed, 10 insertions(+)
> >> > >
> >> > > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> >> > > index 2af9769..c7595a5 100644
> >> > > --- a/include/drm/drm_edid.h
> >> > > +++ b/include/drm/drm_edid.h
> >> > > @@ -403,6 +403,16 @@ static inline int drm_eld_size(const uint8_t =
*eld)
> >> > >  	return DRM_ELD_HEADER_BLOCK_SIZE + eld[DRM_ELD_BASELINE_ELD_LEN]=
 * 4;
> >> > >  }
> >> > > =20
> >> > > +/**
> >> > > + * drm_eld_get_conn_type - Get device type hdmi/dp connected
> >> > > + * @eld: pointer to an eld memory structure
> >> > > + */
> >> > > +static inline int drm_eld_get_conn_type(const uint8_t *eld)
> >> > > +{
> >> > > +	return (eld[DRM_ELD_SAD_COUNT_CONN_TYPE] & DRM_ELD_CONN_TYPE_MAS=
K) >>
> >> > > +		DRM_ELD_CONN_TYPE_SHIFT;
> >> > > +}
> >> >=20
> >> > I'm not sure how much this helps when the caller still needs to
> >> > magically know what the return value means...  Indeed the next patch
> >> > with /* 0 is hdmi and 1 is DP */ and "conn_type =3D=3D 0" is a bit u=
gly.
> >> >=20
> >> > How about just not shifting the return value, and using
> >> > DRM_ELD_CONN_TYPE_HDMI and DRM_ELD_CONN_TYPE_DP in the caller? Bonus
> >> > points for referencing those in the kernel-doc above.
> >>=20
> >> We already have a similar function for detecting HDMI vs. DVI (see the
> >> drm_detect_hdmi_monitor()), so perhaps adhering to that convention mig=
ht
> >> be preferable. This could be:
> >>=20
> >> 	static inline bool drm_eld_detect_dp(const u8 *eld)
> >> 	{
> >> 		u8 type =3D eld[DRM_ELD_SAD_COUNT_CONN_TYPE] & DRM_ELD_CONN_TYPE_MAS=
K;
> >>=20
> >> 		return type =3D=3D DRM_ELD_CONN_TYPE_DP;
> >> 	}
> >
> > With this approach it needs two APIs to be added for HDMI or DP
> > detection. So I prefer what Jani suggested and caller compares
> > whether it is HDMI/DP connection type. Will updae the kernel doc
> > for the same as well.
>=20
> I presume Thierry means you'd assume HDMI if drm_eld_detect_dp() returns
> false.

Yes, that's what I was implying. This is probably highly subjective, but
I personally find boolean return values much easier to deal with because
of the limited set of values. With drm_eld_get_conn_type() you'd need to
explicitly check =3D=3D DRM_ELD_CONN_TYPE_HDMI and =3D=3D DRM_ELD_CONN_TYPE=
_DP
and then still have special code to reject all other values. Unless of
course if you consider !=3D DRM_ELD_CONN_TYPE_DP as being HDMI, in which
case a boolean is much more concise.

But like I said, this is just my opinion, and I don't feel strongly
enough to object to the current patch.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWYCXDAAoJEN0jrNd/PrOhVeMQAIWkKD2pqcb0fFkfXdeZgR3/
3RVfQ4trC85mshqvDw7s1qoCLVsO38kR8y7Ryr20ohvVKKk7sN24FxVj7JzBP0xz
noulTBds6yl0ZyCBJoHap3g50APSjpZcUF17qOENU6wPuPSqqfufMR/QgcJsa9pq
pJ9sXAenwqBtSHqBsOAK3ymXuUWDJa3wgpRsTdbhms/SV89m7KhWucPsWOzDuO9w
CbNeEbSJn8KIcklQveRnCLCmkQsaCFhD5bvaFlfzdLx/F79hHU2ry3i6Il83MHGr
bEzOVoS4cYoFyqTqCpKysXQ9KGsHR5epoqGhUFJsZkp8T6WZpHTXWEFZjPW1O92F
dONXy2vOc1a2zoKX5qmo7dbcIlAn3tX0WmpIcNEuCCxVDOt898V9Bc566GHqi0pK
MmZH//G5ncUnhFeDjLDcxcRL0z91plR2KqJ954LxLrd1hBlnt8cDG61Oyxu11TeC
UkuzeV5Nypip4+57bfqP6ZZdXyF9S52Ki82mLXgtuATimMRSvoxet4XYIKEcq1sZ
jtGcIyjOKBTkw8RWuR9Lz/qVuS2pb1V49ro1WvPm3Nk301Ick0oB7rR+l0433pmO
sHxY+kkDsEKPIfPBZvYFvIhF0X/Z12TIt4mnUYJNJK5pT4WaDWKtAhE9P3o5BqaH
Cj0anLCM1XQBeLAgLAJi
=hZlF
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--===============1939479766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1939479766==--
