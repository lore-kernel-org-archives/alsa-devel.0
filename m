From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Enable i915 binding for
 gen3/4 HDMI/DP
Date: Thu, 31 Mar 2016 15:30:26 +0300
Message-ID: <20160331123026.GN4329@intel.com>
References: <1459352762-28681-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B869C2612CC
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 14:30:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1459352762-28681-1-git-send-email-tiwai@suse.de>
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

On Wed, Mar 30, 2016 at 05:46:01PM +0200, Takashi Iwai wrote:
> This patch fills the holes and now all i915 HDMI/DP codecs are managed
> over the audio ELD notifier, finally.  The old gen3/gen4 chips have
> usually only a single pin/converter pair, and the digital port mapping
> is fixed.
> =

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/hda/hdac_i915.c      | 11 +++++++++++
>  sound/pci/hda/patch_hdmi.c | 21 +++++++++++++++------
>  2 files changed, 26 insertions(+), 6 deletions(-)
> =

> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index d0da2508823e..c62a9f830b84 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -128,6 +128,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_get_display_clk);
>   * Pin Widget 4 - PORT B (port =3D 1 in i915 driver)
>   * Pin Widget 5 - PORT C (port =3D 2 in i915 driver)
>   * Pin Widget 6 - PORT D (port =3D 3 in i915 driver)
> + *
> + * on earlier models:
> + * Pin Widget 3 - PORT B

Hmm. ctg/elk have potentially multiple HDMI ports. Although they only
have one video DIP block so can send infoframes only to one of the ports
at a time. I wonder how this relates to the audio part, as in does the
pin widget 3 always map to the port that is getting infoframes
currently? I do have one elk with two HDMI ports here so I could do some
experiments if needed.

>   */
>  static int pin2port(struct hdac_device *codec, hda_nid_t pin_nid)
>  {
> @@ -139,6 +142,14 @@ static int pin2port(struct hdac_device *codec, hda_n=
id_t pin_nid)
>  	case 0x80862882: /* VLV */
>  		base_nid =3D 3;
>  		break;
> +	case 0x80862801: /* Bearlake */

Hmm. I wonder if this is bearlake-C or something earlier. BLC doesn't
actually exist AFAIK, and earlier bearlake is gen3 and doesn't even
support native HDMI output so not sure what this is doing here.

> +	case 0x80862802: /* Cantiga */
> +	case 0x80862803: /* Eaglelake */
> +	case 0x80862880: /* CedarTrail */

Cedartrail is some powervr atom thing. Should have nothing to do with i915.

> +	case 0x808629fb: /* Crestline HDMI */

CL is gen4 and we don't support native HDMI output on those. Strangely
enough our spec says CL/BW do support TMDS encoding on the SDVO/HDMI
ports and that CL also has the video DIP block and the HDA registers.
Not sure what to make of that really.

> +		if (WARN_ON(pin_nid !=3D 0x03))
> +			return -1;
> +		return 1; /* only port B */
>  	default:
>  		base_nid =3D 4;
>  		break;
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 4833c7bdd1e8..2a3bf1584f3b 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2286,6 +2286,15 @@ static void intel_pin_eld_notify(void *audio_ptr, =
int port)
>  	case 0x80862882: /* VLV */
>  		pin_nid =3D port + 0x03;
>  		break;
> +	case 0x80862801: /* Bearlake */
> +	case 0x80862802: /* Cantiga */
> +	case 0x80862803: /* Eaglelake */
> +	case 0x80862880: /* CedarTrail */
> +	case 0x808629fb: /* Crestline HDMI */
> +		if (WARN_ON(port !=3D 1)) /* assume only port B */
> +			return;
> +		pin_nid =3D 0x03;
> +		break;
>  	default:
>  		pin_nid =3D port + 0x04;
>  		break;
> @@ -2424,7 +2433,7 @@ static int patch_i915_byt_hdmi(struct hda_codec *co=
dec)
>  	return 0;
>  }
>  =

> -/* Intel IronLake, SandyBridge and IvyBridge; with eld notifier */
> +/* Intel Gen3/Gen4, IronLake, SandyBridge and IvyBridge; with eld notifi=
er */
>  static int patch_i915_cpt_hdmi(struct hda_codec *codec)
>  {
>  	struct hdmi_spec *spec;
> @@ -3627,9 +3636,9 @@ HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_=
via_hdmi),
>  HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
>  HDA_CODEC_ENTRY(0x11069f85, "VX11 HDMI/DP",	patch_generic_hdmi),
>  HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
> -HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
> -HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_generic_hdmi),
> -HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_generic_hdmi),
> +HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_i915_cpt_hdmi),
> +HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_i915_cpt_hdmi),
> +HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_i915_cpt_hdmi),
>  HDA_CODEC_ENTRY(0x80862804, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
>  HDA_CODEC_ENTRY(0x80862805, "CougarPoint HDMI",	patch_i915_cpt_hdmi),
>  HDA_CODEC_ENTRY(0x80862806, "PantherPoint HDMI", patch_i915_cpt_hdmi),
> @@ -3638,10 +3647,10 @@ HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	pat=
ch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
> -HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
> +HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_i915_cpt_hdmi),
>  HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
>  HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
> -HDA_CODEC_ENTRY(0x808629fb, "Crestline HDMI",	patch_generic_hdmi),
> +HDA_CODEC_ENTRY(0x808629fb, "Crestline HDMI",	patch_i915_cpt_hdmi),
>  /* special ID for generic HDMI */
>  HDA_CODEC_ENTRY(HDA_CODEC_ID_GENERIC_HDMI, "Generic HDMI", patch_generic=
_hdmi),
>  {} /* terminator */
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
