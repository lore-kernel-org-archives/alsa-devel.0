From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 1/9] drm/i915: Remove superfluous NULL
	check
Date: Fri, 4 Dec 2015 15:07:03 +0200
Message-ID: <20151204130703.GX4437@intel.com>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
 <1448986198-3488-2-git-send-email-tiwai@suse.de>
 <20151204121646.GU4437@intel.com> <s5htwnyz84f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 296932614E3
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 14:07:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htwnyz84f.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 04, 2015 at 01:54:56PM +0100, Takashi Iwai wrote:
> On Fri, 04 Dec 2015 13:16:46 +0100,
> Ville Syrj=E4l=E4 wrote:
> > =

> > On Tue, Dec 01, 2015 at 05:09:50PM +0100, Takashi Iwai wrote:
> > > to_intel_crtc() always returns a non-NULL pointer.
> > =

> > Eh? to_intel_crtc(NULL) should return NULL or we might have tons of
> > breakage on our hands. Or maybe the atomic work has gotten rid of that
> > assumption, but at least we used to depend on that heavily.
> =

> Well, to_intel_crtc() has been always container_of() since the very
> beginning of universe:
> =

> commit 79e539453b34e35f39299a899d263b0a1f1670bd
> Author: Jesse Barnes <jbarnes@virtuousgeek.org>
> Date:   Fri Nov 7 14:24:08 2008 -0800
> =

>     DRM: i915: add mode setting support
>     =

> --- /dev/null
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> ....
> +#define to_intel_crtc(x) container_of(x, struct intel_crtc, base)
> ....

Yes, but =

struct intel_crtc {
	struct drm_crtc base;
	...
}

So offsetof(struct intel_crtc, base)=3D=3D0 and NULL-0 is still NULL.

I once suggested that someone should add a compile time assert to
make sure this always holds for us, but no one took the bait.

> =

> =

> Takashi
> =

> > =

> > > =

> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/gpu/drm/i915/intel_audio.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i91=
5/intel_audio.c
> > > index 4dccd9b003a1..0c38cc6c82ae 100644
> > > --- a/drivers/gpu/drm/i915/intel_audio.c
> > > +++ b/drivers/gpu/drm/i915/intel_audio.c
> > > @@ -656,10 +656,6 @@ static int i915_audio_component_sync_audio_rate(=
struct device *dev,
> > >  		intel_dig_port =3D enc_to_dig_port(&intel_encoder->base);
> > >  		if (port =3D=3D intel_dig_port->port) {
> > >  			crtc =3D to_intel_crtc(intel_encoder->base.crtc);
> > > -			if (!crtc) {
> > > -				DRM_DEBUG_KMS("%s: crtc is NULL\n", __func__);
> > > -				continue;
> > > -			}
> > >  			pipe =3D crtc->pipe;
> > >  			break;
> > >  		}
> > > -- =

> > > 2.6.3
> > =

> > -- =

> > Ville Syrj=E4l=E4
> > Intel OTC
> > =


-- =

Ville Syrj=E4l=E4
Intel OTC
