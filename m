From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC V2 PATCH 3/5] ALSA: hda - hdmi dynamically
 bind PCM to pin when monitor hotplug
Date: Wed, 25 Nov 2015 06:53:27 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977F3C9@SHSMSX103.ccr.corp.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
 <1448287774-146673-5-git-send-email-libin.yang@linux.intel.com>
 <s5hwpt8zoyl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CF7402612AD
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 07:53:51 +0100 (CET)
In-Reply-To: <s5hwpt8zoyl.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, November 24, 2015 12:00 AM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC V2 PATCH 3/5] ALSA: hda - hdmi
> dynamically bind PCM to pin when monitor hotplug
> 
> On Mon, 23 Nov 2015 15:09:32 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Dynamically bind/unbind the PCM to pin when HDMI/DP monitor
> hotplug.
> >
> > When monitor is connected, find a proper PCM for the monitor.
> > When monitor is disconnected, unbind the PCM from the pin.
> 
> You must have some strategy about binding.  Please tell the story
> behind the scene, too.
> 
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 82
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index de22ac2..bcc2a90 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -72,6 +72,8 @@ struct hdmi_spec_per_cvt {
> >
> >  struct hdmi_spec_per_pin {
> >  	hda_nid_t pin_nid;
> > +	/* pin idx, different device entries on the same pin use the same
> idx */
> > +	int pin_nid_idx;
> >  	int num_mux_nids;
> >  	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
> >  	int mux_idx;
> > @@ -83,6 +85,7 @@ struct hdmi_spec_per_pin {
> >  	struct delayed_work work;
> >  	struct snd_kcontrol *eld_ctl;
> >  	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n]
> dynamically*/
> > +	int pcm_idx; /* which pcm is attached. -1 means no pcm is
> attached */
> >  	int repoll_count;
> >  	bool setup; /* the stream has been set up by prepare callback */
> >  	int channels; /* current number of channels */
> > @@ -136,6 +139,7 @@ struct hdmi_spec {
> >  	struct snd_array pins; /* struct hdmi_spec_per_pin */
> >  	struct hda_pcm *pcm_rec[16];
> >  	struct mutex pcm_lock;
> > +	unsigned long pcm_bitmap;
> >  	int pcm_used;	/* counter of pcm_rec[] */
> >  	unsigned int channels_max; /* max over all cvts */
> >
> > @@ -1663,6 +1667,70 @@ static int hdmi_read_pin_conn(struct
> hda_codec *codec, int pin_idx)
> >  	return 0;
> >  }
> >
> > +static int get_preferred_pcm_slot(struct hdmi_spec *spec,
> > +				struct hdmi_spec_per_pin *per_pin)
> > +{
> > +	if ((spec->pcm_bitmap & (1 << per_pin->pin_nid_idx)) == 0)
> 
> Use test_bit().

Get it.

> 
> > +		return per_pin->pin_nid_idx;
> > +	return -1;
> > +}
> > +
> > +static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
> > +				struct hdmi_spec_per_pin *per_pin)
> > +{
> > +	int slot;
> > +	int i;
> > +
> > +	/* try the prefer PCM */
> > +	slot = get_preferred_pcm_slot(spec, per_pin);
> > +	if (slot != -1)
> > +		return slot;
> > +
> > +	/* have a second try */
> > +	for (i = spec->num_pins; i < spec->pcm_used; i++) {
> > +		if ((spec->pcm_bitmap & (1 << i)) == 0)
> 
> Ditto.
> 
> > +			return i;
> > +	}
> > +
> > +	/* the last try */
> > +	for (i = 0; i < spec->pcm_used; i++) {
> > +		if ((spec->pcm_bitmap & (1 << i)) == 0)
> 
> Ditto.
> 
> > +			return i;
> > +	}
> > +	return -ENODEV;
> 
> I think you don't need to split get_preferred_pcm_slot().
> It's a function that is called only from here, and it's even better to
> be open-coded.  Then you can see the code flow more easily.
> (Also, you may notice that the last loop doesn't go all, but just up
>  to num_pins, by looking through the code closely.)
> 
> static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
> 				struct hdmi_spec_per_pin *per_pin)
> {
> 	int i;
> 
> 	/* try the prefer PCM */
> 	if (!test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
> 		return per_pin->pin_nid_idx;
> 
> 	/* have a second try; check the "reserved area" over num_pins
> */
> 	for (i = spec->num_pins; i < spec->pcm_used; i++)
> 		if (!test_bit(i, &spec->pcm_bitmap))
> 			return i;
> 
> 	/* the last try; check the empty slots in pins */
> 	for (i = 0; i < spec->num_pins; i++)
> 		if (!test_bit(i, &spec->pcm_bitmap))
> 			return i;
> 
> 	return -EBUSY;
> }

OK. I will use the new code.

Regards,
Libin


> 
> 
> 
> Takashi
