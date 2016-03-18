From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Fri, 18 Mar 2016 19:49:19 +0200
Message-ID: <20160318174919.GR4329@intel.com>
References: <20160315160207.GY4329@intel.com> <s5hio0nejv3.wl-tiwai@suse.de>
 <20160316140420.GB4329@intel.com> <20160318135459.GF4329@intel.com>
 <s5hwpoz50iw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 453BD264FF6
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 18:49:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwpoz50iw.wl-tiwai@suse.de>
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

On Fri, Mar 18, 2016 at 03:22:15PM +0100, Takashi Iwai wrote:
> On Fri, 18 Mar 2016 14:54:59 +0100,
> Ville Syrj=E4l=E4 wrote:
> > =

> > On Wed, Mar 16, 2016 at 04:04:20PM +0200, Ville Syrj=E4l=E4 wrote:
> > > On Tue, Mar 15, 2016 at 06:22:56PM +0100, Takashi Iwai wrote:
> > > > On Tue, 15 Mar 2016 17:02:07 +0100,
> > > > Ville Syrj=E4l=E4 wrote:
> > > > > =

> > > > > We have a few new WARN spews from snd-hda causing some grief in i=
915 CI.
> > > > > =

> > > > > This one happens on ILK and BYT. Looks like it happens 100% of th=
e time on driver load:
> > > > > [   18.809850] ------------[ cut here ]------------
> > > > > [   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i915.c:1=
29 pin2port+0x25/0x30 [snd_hda_core]()
> > > > =

> > > > This is bad.  Basically we had a naive assumption of the fixed mapp=
ing
> > > > between the port number and the HD-audio widget, but it doesn't app=
ly
> > > > properly to pre-HSW models.
> > > > =

> > > > The patch attached below disables the audio binding for pre-HSW
> > > > models.  I'm going to queue to for-linus branch.
> > > =

> > > That seems to eliminate the warn on my ILK.
> > =

> > Apparently it was less effective on BYT. We still get this:
> =

> Ouch, I forgot that Baytrail had already i915 component binding in the
> controller side.  I assumed too naively that all old models have no
> binding.
> =

> Below is the additional fix patch.

Still getting blasted at least via snd_hdac_sync_audio_rate()

> =

> Thanks for reporting!
> =

> =

> Takashi
> =

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Really restrict i915 notifier to HSW+
> =

> The commit [b62232d429fa: ALSA: hda - Limit i915 HDMI binding only for
> HSW and later] tried to limit the usage of i915 audio notifier to the
> recent Intel models and switch to the old method on pre-Haswell
> models.  However, it assumed that the i915 component binding hasn't
> been done on such models, and the assumption was wrong: namely,
> Baytrail had already the i915 component binding due to powerwell
> control.  Thus, the workaround wasn't applied to Baytrail.
> =

> For fixing this properly, this patch introduces a new flag indicating
> the usage of audio notifier and codec_has_acomp() refers to this flag
> instead of checking the existence of audio component.
> =

> Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.5
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_hdmi.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> =

> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 49ee4e55dd16..8cdb804aa9cf 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -152,6 +152,7 @@ struct hdmi_spec {
>  	struct hda_pcm_stream pcm_playback;
>  =

>  	/* i915/powerwell (Haswell+/Valleyview+) specific */
> +	bool use_acomp_notifier; /* use i915 eld_notify callback for hotplug */
>  	struct i915_audio_component_audio_ops i915_audio_ops;
>  	bool i915_bound; /* was i915 bound in this driver? */
>  =

> @@ -159,8 +160,11 @@ struct hdmi_spec {
>  };
>  =

>  #ifdef CONFIG_SND_HDA_I915
> -#define codec_has_acomp(codec) \
> -	((codec)->bus->core.audio_component !=3D NULL)
> +static inline bool codec_has_acomp(struct hda_codec *codec)
> +{
> +	struct hdmi_spec *spec =3D codec->spec;
> +	return spec->use_acomp_notifier;
> +}
>  #else
>  #define codec_has_acomp(codec)	false
>  #endif
> @@ -2248,12 +2252,18 @@ static int patch_generic_hdmi(struct hda_codec *c=
odec)
>  	codec->spec =3D spec;
>  	hdmi_array_init(spec, 4);
>  =

> +#ifdef CONFIG_SND_HDA_I915
>  	/* Try to bind with i915 for Intel HSW+ codecs (if not done yet) */
> -	if (!codec_has_acomp(codec) &&
> -	    (codec->core.vendor_id >> 16) =3D=3D 0x8086 &&
> -	    is_haswell_plus(codec))
> -		if (!snd_hdac_i915_init(&codec->bus->core))
> -			spec->i915_bound =3D true;
> +	if ((codec->core.vendor_id >> 16) =3D=3D 0x8086 &&
> +	    is_haswell_plus(codec)) {
> +		if (!codec->bus->core.audio_component)
> +			if (!snd_hdac_i915_init(&codec->bus->core))
> +				spec->i915_bound =3D true;
> +		/* use i915 audio component notifier for hotplug */
> +		if (codec->bus->core.audio_component)
> +			spec->use_acomp_notifier =3D true;
> +	}
> +#endif
>  =

>  	if (is_haswell_plus(codec)) {
>  		intel_haswell_enable_all_pins(codec, true);
> -- =

> 2.7.4

-- =

Ville Syrj=E4l=E4
Intel OTC
