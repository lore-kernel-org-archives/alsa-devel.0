From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH V1] ALSA: hda - Avoid choose same converter
 for unused pins
Date: Tue, 18 Jun 2013 14:16:56 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901183119D@SHSMSX104.ccr.corp.intel.com>
References: <1371562934-28859-1-git-send-email-xingchao.wang@linux.intel.com>
	<s5h4ncvld5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5h4ncvld5m.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, June 18, 2013 10:14 PM
> To: Wang Xingchao
> Cc: daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> intel-gfx@lists.freedesktop.org; Wang, Xingchao
> Subject: Re: [PATCH V1] ALSA: hda - Avoid choose same converter for unused
> pins
> 
> At Tue, 18 Jun 2013 21:42:14 +0800,
> Wang Xingchao wrote:
> >
> > For Intel Haswell HDMI codecs, the pins choose converter 0 by default.
> > This would cause conflict when playing audio on unused pins,the pin
> > with physical device connected would get audio data too.
> > i.e. Pin 0/1/2 default choose converter 0, pin 1 has HDMI monitor connected.
> > when play audio on Pin 0 or pin 2, pin 1 could get audio data too.
> >
> > This patch configure unused pins to choose different converter.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c |   91
> ++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 76 insertions(+), 15 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 8983747..43f8b76 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1110,26 +1110,15 @@ static int hdmi_setup_stream(struct hda_codec
> *codec, hda_nid_t cvt_nid,
> >  	return 0;
> >  }
> >
> > -/*
> > - * HDA PCM callbacks
> > - */
> > -static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> > -			 struct hda_codec *codec,
> > -			 struct snd_pcm_substream *substream)
> > +static int hdmi_choose_cvt(struct hda_codec *codec,
> > +			int pin_idx, int *cvt_id, int *mux_id)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > -	struct snd_pcm_runtime *runtime = substream->runtime;
> > -	int pin_idx, cvt_idx, mux_idx = 0;
> >  	struct hdmi_spec_per_pin *per_pin;
> > -	struct hdmi_eld *eld;
> >  	struct hdmi_spec_per_cvt *per_cvt = NULL;
> > +	int cvt_idx, mux_idx = 0;
> >
> > -	/* Validate hinfo */
> > -	pin_idx = hinfo_to_pin_index(spec, hinfo);
> > -	if (snd_BUG_ON(pin_idx < 0))
> > -		return -EINVAL;
> >  	per_pin = get_pin(spec, pin_idx);
> > -	eld = &per_pin->sink_eld;
> >
> >  	/* Dynamically assign converter to stream */
> >  	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) { @@ -1147,17
> > +1136,89 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> >  			continue;
> >  		break;
> >  	}
> > +
> >  	/* No free converters */
> >  	if (cvt_idx == spec->num_cvts)
> >  		return -ENODEV;
> >
> > +	if (cvt_id)
> > +		*cvt_id = cvt_idx;
> > +	if (mux_id)
> > +		*mux_id = mux_idx;
> > +
> > +	return 0;
> > +}
> > +
> > +static void haswell_config_cvts(struct hda_codec *codec,
> > +			int pin_id, int mux_id)
> > +{
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_pin *per_pin;
> > +	int pin_idx, mux_idx;
> > +	int curr;
> > +	int err;
> > +
> > +	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > +		per_pin = get_pin(spec, pin_idx);
> > +
> > +		if (pin_idx == pin_id)
> > +			continue;
> > +
> > +		curr = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
> > +					  AC_VERB_GET_CONNECT_SEL, 0);
> > +
> > +		/* Choose another unused converter */
> > +		if (curr == mux_id) {
> > +			err = hdmi_choose_cvt(codec, pin_idx, NULL, &mux_idx);
> > +			if (err < 0)
> > +				return;
> > +			snd_printdd("HDMI: choose converter %d for pin %d\n",
> mux_idx, pin_idx);
> > +			snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
> > +					    AC_VERB_SET_CONNECT_SEL,
> > +					    mux_idx);
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * HDA PCM callbacks
> > + */
> > +static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> > +			 struct hda_codec *codec,
> > +			 struct snd_pcm_substream *substream) {
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	int pin_idx, cvt_idx, mux_idx = 0;
> > +	struct hdmi_spec_per_pin *per_pin;
> > +	struct hdmi_eld *eld;
> > +	struct hdmi_spec_per_cvt *per_cvt = NULL;
> > +	int err;
> > +
> > +	/* Validate hinfo */
> > +	pin_idx = hinfo_to_pin_index(spec, hinfo);
> > +	if (snd_BUG_ON(pin_idx < 0))
> > +		return -EINVAL;
> > +	per_pin = get_pin(spec, pin_idx);
> > +	eld = &per_pin->sink_eld;
> > +
> > +	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx, &mux_idx);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	per_cvt = get_cvt(spec, cvt_idx);
> >  	/* Claim converter */
> >  	per_cvt->assigned = 1;
> >  	hinfo->nid = per_cvt->cvt_nid;
> >
> > -	snd_hda_codec_write(codec, per_pin->pin_nid, 0,
> > +	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
> >  			    AC_VERB_SET_CONNECT_SEL,
> >  			    mux_idx);
> 
> You shouldn't mix this fix into your patch.
> This change should be applied as a separate patch and go to stable kernel.
> 
> I'll cook up your patch to remove that chunk and apply the rest as is.
> 
Okay, thanks a lot. :)

Thanks
--xingchao
> 
> thanks,
> 
> Takashi
