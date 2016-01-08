From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 3/4] ALSA: hda - hdmi jack created based on
 pcm
Date: Fri, 8 Jan 2016 03:15:03 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190464D1BC@SHSMSX103.ccr.corp.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
 <1451524942-17288-4-git-send-email-libin.yang@linux.intel.com>
 <s5hk2nlfpem.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4643C260483
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 04:15:09 +0100 (CET)
In-Reply-To: <s5hk2nlfpem.wl-tiwai@suse.de>
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



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, January 07, 2016 10:14 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [PATCH 3/4] ALSA: hda - hdmi jack created based
> on pcm
> 
> On Thu, 31 Dec 2015 02:22:21 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Jack is created based on pcm.
> >
> > For dyn_pcm_assign:
> >  Driver will not use hda_jack. It will operate snd_jack directly.
> 
> This is nothing new, it's already so for Intel codecs (via audio
> component).

Yes. And I'm try to use this new method to all codecs as an option. :)

> 
> >  snd_jack pointer will be stored in spec->pcm.jack.
> 
> .... instead of the current spec->acomp_jack.
> 
> 
> > When pcm is
> >  assigned to pin, jack will be assigned to pin automatically.
> >
> > For !dyn_pcm_assign:
> >  Driver will continue using hda_jack for less impact on the old cases.
> >  Pcm is statically assigned to pin. So is jack. spec->pcm.jack will
> >  save the snd_jack pointer created in hda_jack.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> (snip)
> 
> > -static int generic_hdmi_build_jack(struct hda_codec *codec, int
> pin_idx)
> > +static int generic_hdmi_build_jack(struct hda_codec *codec, int
> pcm_idx)
> >  {
> >  	char hdmi_str[32] = "HDMI/DP";
> >  	struct hdmi_spec *spec = codec->spec;
> > -	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> > -	int pcmdev = get_pcm_rec(spec, pin_idx).pcm->device;
> > +	struct hdmi_spec_per_pin *per_pin;
> > +	struct hda_jack_tbl *jack;
> > +	int pcmdev = get_pcm_rec(spec, pcm_idx).pcm->device;
> >  	bool phantom_jack;
> > +	int ret;
> >
> >  	if (pcmdev > 0)
> >  		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d",
> pcmdev);
> > -	if (codec_has_acomp(codec))
> > -		return add_acomp_jack_kctl(codec, per_pin, hdmi_str);
> > -	phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
> > -	if (phantom_jack)
> > -		strncat(hdmi_str, " Phantom",
> > -			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
> >
> > -	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid,
> hdmi_str,
> > -				     phantom_jack);
> > +	/* for !dyn_pcm_assign, we still use hda_jack for compatibility */
> > +	if (!spec->dyn_pcm_assign) {
> 
> Actually, the code changes become smaller with the following:
> 
> 	if (spec->dyn_pcm_assign)
> 		return add_hdmi_jack_kctl(codec, spec, pcm_idx,
> hdmi_str);

OK, I will change it. Anyway, we need enable unsol_event here
if !acomp. 

> 
> Then the rest is almost same as the original code, and you'd need to
> give a few more comments and assignment of pcm_rec[].jack in
> addition.
> 
> 
> > @@ -2626,18 +2659,23 @@ static void hdmi_array_free(struct
> hdmi_spec *spec)
> >  static void generic_hdmi_free(struct hda_codec *codec)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > -	int pin_idx;
> > +	int pin_idx, pcm_idx;
> >
> >  	if (codec_has_acomp(codec))
> >  		snd_hdac_i915_register_notifier(NULL);
> >
> >  	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> >  		struct hdmi_spec_per_pin *per_pin = get_pin(spec,
> pin_idx);
> > -
> >  		cancel_delayed_work_sync(&per_pin->work);
> >  		eld_proc_free(per_pin);
> > -		if (per_pin->acomp_jack)
> > -			snd_device_free(codec->card, per_pin-
> >acomp_jack);
> > +	}
> > +
> > +	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
> > +		if (spec->dyn_pcm_assign)
> > +			snd_device_free(codec->card,
> > +					spec->pcm_rec[pcm_idx].jack);
> > +		else
> > +			spec->pcm_rec[pcm_idx].jack = NULL;
> 
> Check whether spec->pcm_rec[pcm_idx].jack is NULL beforehand.
> 

Do you mean:
if (spec->pcm_rec[pcm_idx].jack)
    spec->pcm_rec[pcm_idx].jack = NULL;

Regards,
Libin
> 
> Takashi
