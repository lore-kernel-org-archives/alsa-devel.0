From: "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Intel G45 8-Channel LPCM over HDMI
Date: Wed, 5 Nov 2008 13:16:30 +0800
Message-ID: <20081105051630.GA2751@zhen-devel.sh.intel.com>
References: <8D978A35-5424-4BB5-980A-8F74EE529876@lambda-audiosystems.de>
	<s5hfxm9wap9.wl%tiwai@suse.de> <1225792266.708657.30943@de>
	<C804A129-7BFB-4F0B-BE64-CCAE549FB895@lambda-audiosystems.de>
	<1225860387.293695.26980@de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0108011854023554211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id A80C524395
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 06:17:44 +0100 (CET)
In-Reply-To: <1225860387.293695.26980@de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "Ma, Ling" <ling.ma@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Werner <alexander.werner@lambda-audiosystems.de>
List-Id: alsa-devel@alsa-project.org


--===============0108011854023554211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2008.11.05 12:46:25 +0800, Wu, Fengguang wrote:
> On Tue, Nov 04, 2008 at 10:36:35PM +0800, Alexander Werner wrote:
> > > It's ready now!
> > >
> > > We did a lot of code refactor, testing and bug fixes in the last ten
> > > days, and now it's ready for release :-)
> > >
> > > Note that X.org intel video patches are also necessary for HDMI =20
> > > sound output.
> > >
> > > However our 3 HDMI monitors have only 2-channel audio support, so
> > > 8-channel LPCM audio may not work for now.
> > >
> > > Thank you,
> > > Fengguang
> > >
> > That's great news! I'll test the patch as soon as my replacement board =
=20
> > arrives.
>=20
> Thank you. The G45 HDMI audio can be enabled by the submitted ALSA
> kernel patch together with this X.org intel driver patch:
>=20

Looks mostly fine to me. But we can only enable HDMI audio
to one port at one time, so should we handle that case in two HDMI
ports case? And note that as DVI is compatible with HDMI, we've seen
many boards that using HDMI port for DVI output. So we might also check
in that case to not enable audio (recent added xserver xf86MonitorIsHDMI()
API might help here).=20

> ---
>=20
> [PATCH] enable HDMI audio output
>=20
> Set the SDVO_AUDIO_ENABLE bit to enable audio output for
>         - integrated HDMI (e.g. G45)
>         - SDVO HDMI (e.g. G35)
>=20
> Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
> Signed-off-by: Ma Ling <ling.ma@intel.com>
> ---
>  src/i810_reg.h  |    1 +
>  src/i830_hdmi.c |    1 +
>  src/i830_sdvo.c |   10 ++++++----
>  3 files changed, 8 insertions(+), 4 deletions(-)
>=20
> --- xf86-video-intel.orig/src/i810_reg.h
> +++ xf86-video-intel/src/i810_reg.h
> @@ -1281,6 +1281,7 @@ SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  /** Requird for HDMI operation */
>  #define SDVO_NULL_PACKETS_DURING_VSYNC		(1 << 9)
>  #define SDVO_BORDER_ENABLE			(1 << 7)
> +#define SDVO_AUDIO_ENABLE			(1 << 6)
>  /** New with 965, default is to be set */
>  #define SDVO_VSYNC_ACTIVE_HIGH			(1 << 4)
>  /** New with 965, default is to be set */
> --- xf86-video-intel.orig/src/i830_hdmi.c
> +++ xf86-video-intel/src/i830_hdmi.c
> @@ -75,6 +75,7 @@ i830_hdmi_mode_set(xf86OutputPtr output,
>      uint32_t sdvox;
> =20
>      sdvox =3D SDVO_ENCODING_HDMI |
> +	SDVO_AUDIO_ENABLE |
>  	SDVO_BORDER_ENABLE |
>  	SDVO_VSYNC_ACTIVE_HIGH |
>  	SDVO_HSYNC_ACTIVE_HIGH;
> --- xf86-video-intel.orig/src/i830_sdvo.c
> +++ xf86-video-intel/src/i830_sdvo.c
> @@ -1017,7 +1017,7 @@ i830_sdvo_mode_set(xf86OutputPtr output,
>      struct i830_sdvo_priv   *dev_priv =3D intel_output->dev_priv;
>      xf86CrtcPtr	    crtc =3D output->crtc;
>      I830CrtcPrivatePtr	    intel_crtc =3D crtc->driver_private;
> -    uint32_t sdvox;
> +    uint32_t sdvox =3D 0;
>      int sdvo_pixel_multiply;
>      struct i830_sdvo_in_out_map in_out;
>      struct i830_sdvo_dtd input_dtd;
> @@ -1039,8 +1039,10 @@ i830_sdvo_mode_set(xf86OutputPtr output,
>  			&in_out, sizeof(in_out));
>      status =3D i830_sdvo_read_response(output, NULL, 0);
> =20
> -    if (dev_priv->is_hdmi)
> +    if (dev_priv->is_hdmi){
>  	i830_sdvo_set_avi_infoframe(output, mode);
> +	sdvox |=3D SDVO_AUDIO_ENABLE;
> +    }
> =20
>      i830_sdvo_get_dtd_from_mode(&input_dtd, mode);
> =20
> @@ -1088,11 +1090,11 @@ i830_sdvo_mode_set(xf86OutputPtr output,
> =20
>      /* Set the SDVO control regs. */
>      if (IS_I965G(pI830)) {
> -	sdvox =3D SDVO_BORDER_ENABLE |
> +	sdvox |=3D SDVO_BORDER_ENABLE |
>  		SDVO_VSYNC_ACTIVE_HIGH |
>  		SDVO_HSYNC_ACTIVE_HIGH;
>      } else {
> -	sdvox =3D INREG(dev_priv->output_device);
> +	sdvox |=3D INREG(dev_priv->output_device);
>  	switch (dev_priv->output_device) {
>  	case SDVOB:
>  	    sdvox &=3D SDVOB_PRESERVE_MASK;

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkRLC4ACgkQsQQaM014GCeqPACggD0Jio8eGmECgYf+ZejZcRJN
v5YAn07MPwqqeebIMFI/fHf/1nELD4fV
=QPIX
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============0108011854023554211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0108011854023554211==--
