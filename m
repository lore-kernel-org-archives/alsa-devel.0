From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Fri, 18 Mar 2016 21:07:53 +0200
Message-ID: <20160318190753.GT4329@intel.com>
References: <20160315160207.GY4329@intel.com> <s5hio0nejv3.wl-tiwai@suse.de>
 <20160316140420.GB4329@intel.com> <20160318135459.GF4329@intel.com>
 <s5hwpoz50iw.wl-tiwai@suse.de> <20160318174919.GR4329@intel.com>
 <s5ha8lvvcu8.wl-tiwai@suse.de> <s5h8u1fvcm3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AB62650F5
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 20:08:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8u1fvcm3.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 07:56:36PM +0100, Takashi Iwai wrote:
> On Fri, 18 Mar 2016 19:51:43 +0100,
> Takashi Iwai wrote:
> > =

> > On Fri, 18 Mar 2016 18:49:19 +0100,
> > Ville Syrj=E4l=E4 wrote:
> > > =

> > > On Fri, Mar 18, 2016 at 03:22:15PM +0100, Takashi Iwai wrote:
> > > > On Fri, 18 Mar 2016 14:54:59 +0100,
> > > > Ville Syrj=E4l=E4 wrote:
> > > > > =

> > > > > On Wed, Mar 16, 2016 at 04:04:20PM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > > On Tue, Mar 15, 2016 at 06:22:56PM +0100, Takashi Iwai wrote:
> > > > > > > On Tue, 15 Mar 2016 17:02:07 +0100,
> > > > > > > Ville Syrj=E4l=E4 wrote:
> > > > > > > > =

> > > > > > > > We have a few new WARN spews from snd-hda causing some grie=
f in i915 CI.
> > > > > > > > =

> > > > > > > > This one happens on ILK and BYT. Looks like it happens 100%=
 of the time on driver load:
> > > > > > > > [   18.809850] ------------[ cut here ]------------
> > > > > > > > [   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i9=
15.c:129 pin2port+0x25/0x30 [snd_hda_core]()
> > > > > > > =

> > > > > > > This is bad.  Basically we had a naive assumption of the fixe=
d mapping
> > > > > > > between the port number and the HD-audio widget, but it doesn=
't apply
> > > > > > > properly to pre-HSW models.
> > > > > > > =

> > > > > > > The patch attached below disables the audio binding for pre-H=
SW
> > > > > > > models.  I'm going to queue to for-linus branch.
> > > > > > =

> > > > > > That seems to eliminate the warn on my ILK.
> > > > > =

> > > > > Apparently it was less effective on BYT. We still get this:
> > > > =

> > > > Ouch, I forgot that Baytrail had already i915 component binding in =
the
> > > > controller side.  I assumed too naively that all old models have no
> > > > binding.
> > > > =

> > > > Below is the additional fix patch.
> > > =

> > > Still getting blasted at least via snd_hdac_sync_audio_rate()
> > =

> > That code path is a slightly different.  This is a kind of false
> > positive, but now the function checks the validity of the passed
> > argument more strictly, and starts grumbling.
> > =

> > The fix is attached below.
> > =

> > =

> > Takashi
> =

> BTW, while writing this patch, I noticed that i915/intel_audio.c
> doesn't have the check for Broxton.
> =

> Don't we need a patch like below?

I have no clue.

> (Or maybe checking like gen >=3D 9
> is better?)

If BXT needs this stuff, a gen check would seem nicer.

> =

> =

> Takashi
> =

> ---
> diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/in=
tel_audio.c
> index 31f6d212fb1b..8105691ff299 100644
> --- a/drivers/gpu/drm/i915/intel_audio.c
> +++ b/drivers/gpu/drm/i915/intel_audio.c
> @@ -599,7 +599,7 @@ static void i915_audio_component_codec_wake_override(=
struct device *dev,
>  	struct drm_i915_private *dev_priv =3D dev_to_i915(dev);
>  	u32 tmp;
>  =

> -	if (!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv))
> +	if (!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv) && !IS_BROXTON(dev_=
priv))
>  		return;
>  =

>  	/*
> @@ -651,6 +651,7 @@ static int i915_audio_component_sync_audio_rate(struc=
t device *dev,
>  =

>  	/* HSW, BDW, SKL, KBL need this fix */
>  	if (!IS_SKYLAKE(dev_priv) &&
> +	    !IS_BROXTON(dev_priv) &&
>  	    !IS_KABYLAKE(dev_priv) &&
>  	    !IS_BROADWELL(dev_priv) &&
>  	    !IS_HASWELL(dev_priv))

-- =

Ville Syrj=E4l=E4
Intel OTC
