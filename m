From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Bind with i915 only when
 Intel graphics is present
Date: Thu, 31 Mar 2016 15:56:40 +0300
Message-ID: <20160331125640.GO4329@intel.com>
References: <1459352762-28681-1-git-send-email-tiwai@suse.de>
 <1459352762-28681-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE8D2667B3
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 14:56:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1459352762-28681-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2016 at 05:46:02PM +0200, Takashi Iwai wrote:
> On Skylake and onwards, the HD-audio controller driver needs to bind
> with i915 for having the control of power well audio domain before
> actually probing the codec.  This leads to the load of i915 driver
> from the audio driver side.  But, there are systems that have no Intel
> graphics but Nvidia or AMD GPU, although they still use HD-audio bus
> for the onboard audio codecs.  On these, loading the i915 driver is
> nothing but a useless memory and CPU consumption.
> =

> A simple way to avoid it is just to look for the Intel graphics PCI
> entry beforehand, and try to bind with i915 only when such an entry is
> found.  Currently, it assumes the PCI display class.  If another class
> appears, this needs to be extended (although it's very unlikely).
> =

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/hda/hdac_i915.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> =

> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index c62a9f830b84..3c8e6d93d4df 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -298,6 +298,17 @@ int snd_hdac_i915_register_notifier(const struct i91=
5_audio_component_audio_ops
>  }
>  EXPORT_SYMBOL_GPL(snd_hdac_i915_register_notifier);
>  =

> +/* check whether intel graphics is present */
> +static bool i915_gfx_present(void)
> +{
> +	static struct pci_device_id ids[] =3D {
> +		{ PCI_DEVICE_CLASS(PCI_BASE_CLASS_DISPLAY << 16, 0xff0000) },
> +		{}
> +	};
> +	return pci_dev_present(ids);
> +}

Should this be checking for at least the Intel vendor ID? External GPUs
should be display class devices too, no?

> +
> +
>  /**
>   * snd_hdac_i915_init - Initialize i915 audio component
>   * @bus: HDA core bus
> @@ -320,6 +331,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
>  	if (WARN_ON(hdac_acomp))
>  		return -EBUSY;
>  =

> +	if (!i915_gfx_present())
> +		return -ENODEV;
> +
>  	acomp =3D kzalloc(sizeof(*acomp), GFP_KERNEL);
>  	if (!acomp)
>  		return -ENOMEM;
> -- =

> 2.7.4
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

Ville Syrj=E4l=E4
Intel OTC
