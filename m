From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - chmap supports dynamic pcm
	assignment
Date: Tue, 2 Feb 2016 13:43:23 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190465D15C@SHSMSX103.ccr.corp.intel.com>
References: <1454396221-36610-1-git-send-email-libin.yang@linux.intel.com>
 <s5hy4b3ju68.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C74526147E
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 14:43:30 +0100 (CET)
In-Reply-To: <s5hy4b3ju68.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, February 02, 2016 6:14 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [PATCH] ALSA: hda - chmap supports dynamic pcm
> assignment
> 
> On Tue, 02 Feb 2016 07:57:01 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Bind chmap to pcm statically. chmap is now mapped to pin dynamically
> > based on mapping between pcm and pin.
> 
> The code changes look OK but the patch description doesn't follow it.
> Please elaborate / correct the texts a bit more.

Get it. I will change the description.

Regards,
Libin
> 
> 
> thanks,
> 
> Takashi
> 
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 40
> +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 275b68a..1a46f45 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -437,6 +437,20 @@ static int hinfo_to_pin_index(struct
> hda_codec *codec,
> >  	return -EINVAL;
> >  }
> >
> > +static struct hdmi_spec_per_pin *pcm_idx_to_pin(struct hdmi_spec
> *spec,
> > +						int pcm_idx)
> > +{
> > +	int i;
> > +	struct hdmi_spec_per_pin *per_pin;
> > +
> > +	for (i = 0; i < spec->num_pins; i++) {
> > +		per_pin = get_pin(spec, i);
> > +		if (per_pin->pcm_idx == pcm_idx)
> > +			return per_pin;
> > +	}
> > +	return NULL;
> > +}
> > +
> >  static int cvt_nid_to_cvt_index(struct hda_codec *codec, hda_nid_t
> cvt_nid)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > @@ -2398,10 +2412,16 @@ static int hdmi_chmap_ctl_get(struct
> snd_kcontrol *kcontrol,
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> >  	struct hda_codec *codec = info->private_data;
> >  	struct hdmi_spec *spec = codec->spec;
> > -	int pin_idx = kcontrol->private_value;
> > -	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> > +	int pcm_idx = kcontrol->private_value;
> > +	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec,
> pcm_idx);
> >  	int i;
> >
> > +	if (!per_pin) {
> > +		for (i = 0; i < spec->channels_max; i++)
> > +			ucontrol->value.integer.value[i] = 0;
> > +		return 0;
> > +	}
> > +
> >  	for (i = 0; i < ARRAY_SIZE(per_pin->chmap); i++)
> >  		ucontrol->value.integer.value[i] = per_pin->chmap[i];
> >  	return 0;
> > @@ -2413,13 +2433,19 @@ static int hdmi_chmap_ctl_put(struct
> snd_kcontrol *kcontrol,
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> >  	struct hda_codec *codec = info->private_data;
> >  	struct hdmi_spec *spec = codec->spec;
> > -	int pin_idx = kcontrol->private_value;
> > -	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> > +	int pcm_idx = kcontrol->private_value;
> > +	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec,
> pcm_idx);
> >  	unsigned int ctl_idx;
> >  	struct snd_pcm_substream *substream;
> >  	unsigned char chmap[8];
> >  	int i, err, ca, prepared = 0;
> >
> > +	/* No monitor is connected in dyn_pcm_assign.
> > +	 * It's invalid to setup the chmap
> > +	 */
> > +	if (!per_pin)
> > +		return 0;
> > +
> >  	ctl_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
> >  	substream = snd_pcm_chmap_substream(info, ctl_idx);
> >  	if (!substream || !substream->runtime)
> > @@ -2596,18 +2622,18 @@ static int
> generic_hdmi_build_controls(struct hda_codec *codec)
> >  	}
> >
> >  	/* add channel maps */
> > -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > +	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
> >  		struct hda_pcm *pcm;
> >  		struct snd_pcm_chmap *chmap;
> >  		struct snd_kcontrol *kctl;
> >  		int i;
> >
> > -		pcm = get_pcm_rec(spec, pin_idx);
> > +		pcm = get_pcm_rec(spec, pcm_idx);
> >  		if (!pcm || !pcm->pcm)
> >  			break;
> >  		err = snd_pcm_add_chmap_ctls(pcm->pcm,
> >
> SNDRV_PCM_STREAM_PLAYBACK,
> > -					     NULL, 0, pin_idx, &chmap);
> > +					     NULL, 0, pcm_idx, &chmap);
> >  		if (err < 0)
> >  			return err;
> >  		/* override handlers */
> > --
> > 1.9.1
> >
