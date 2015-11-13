From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - hdmi begin to support
 dynamic PCM assignment
Date: Fri, 13 Nov 2015 15:33:22 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977A886@SHSMSX103.ccr.corp.intel.com>
References: <1447404990-145928-1-git-send-email-libin.yang@linux.intel.com>
 <s5h7flm2r24.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE4F265CA8
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 16:33:30 +0100 (CET)
In-Reply-To: <s5h7flm2r24.wl-tiwai@suse.de>
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
> Sent: Friday, November 13, 2015 5:21 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC PATCH] ALSA: hda - hdmi begin to support
> dynamic PCM assignment
> 
> On Fri, 13 Nov 2015 09:56:30 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Begin to support dynamic PCM assignment to pin in
> > hdmi audio driver.
> >
> > This means PCM will not be statically bound with pin.
> > When there is a monitor connected, the corresponding pin
> > will try to find a proper PCM to bind. When the monitor
> > is disconnected, the corresponding pin will unbind
> > the PCM. This helps to reduce the PCM number when there
> > are many pins (device entries in DP MST mode) and only
> > a few of them work at the same time.
> >
> > This patch adds the pcm member in struct hdmi_spec_per_pin.
> > When PCM is dynamically bound to the pin, the member pcm
> > will pointer to the corresponding pcm_rec[] in hdmi_spec,
> > which means the hda_pcm is bound to the pin.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index f503a88..f3363b8 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -82,6 +82,7 @@ struct hdmi_spec_per_pin {
> >  	struct mutex lock;
> >  	struct delayed_work work;
> >  	struct snd_kcontrol *eld_ctl;
> > +	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n]
> dynamically*/
> >  	int repoll_count;
> >  	bool setup; /* the stream has been set up by prepare callback */
> >  	int channels; /* current number of channels */
> > @@ -140,7 +141,8 @@ struct hdmi_spec {
> >  	struct hdmi_ops ops;
> >
> >  	bool dyn_pin_out;
> > -
> > +	bool dyn_pcm_assign;
> > +	struct mutex pcm_lock;
> >  	/*
> >  	 * Non-generic VIA/NVIDIA specific
> >  	 */
> > @@ -378,13 +380,26 @@ static int hinfo_to_pin_index(struct
> hda_codec *codec,
> >  			      struct hda_pcm_stream *hinfo)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_pin *per_pin;
> >  	int pin_idx;
> >
> > -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
> > -		if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
> > -			return pin_idx;
> > +	if (!spec->dyn_pcm_assign) {
> > +		for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
> > +			if (get_pcm_rec(spec, pin_idx)->stream == hinfo)
> > +				return pin_idx;
> > +	} else {
> > +		mutex_lock(&spec->pcm_lock);
> > +		for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > +			per_pin = get_pin(spec, pin_idx);
> > +			if (per_pin->pcm && per_pin->pcm->stream ==
> hinfo) {
> > +				mutex_unlock(&spec->pcm_lock);
> > +				return pin_idx;
> > +			}
> > +		}
> > +		mutex_unlock(&spec->pcm_lock);
> 
> You can assign per_pin->pcm statically at init time when
> dyn_pcm_assign=false.  Then the same code is used in the above.

Yes, I will change it.

> 
> The need of spec->pcm_lock isn't clear at this moment.  I guess you're
> trying to avoid the race of dynamic pin assignment and release.  But
> then the code above doesn't protect anything because you return the
> pin_idx as an available value after the unlock.  Then the pin release
> can happen after this point while you're accessing with the pin_idx.
> 
> So, better to consider the implementation of lock or other mechanism
> once when the whole picture is ready.

I add the lock to avoid:
 if (per_pin->pcm && per_pin->pcm->stream == hinfo)
per_pin->pcm is not null at first and when judge 
"per_pin->pcm->stream == hinfo" per_pin->pcm has been null.

I found it's very hard to protect the pin_idx in the whole process.
For example, pin is connected when open, but disconnected when
prepare or close, or vise verse. Or open is called twice at the same
time, but pin is assigned to 2 different PCMs (hotplug happens).

Maybe we can keep the lock now, and will refine it later? This lock 
can make sure when per_pin->pcm->stream == hinfo, it will never
access invalid memory.

Regards,
Libin

> 
> 
> Takashi
