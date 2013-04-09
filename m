From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda - delay resuming Haswell
 HDMI codec in system resume
Date: Tue, 9 Apr 2013 05:25:45 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8379261@SHSMSX101.ccr.corp.intel.com>
References: <1365443695-15695-1-git-send-email-mengdong.lin@intel.com>
 <s5h8v4tyu6c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B77BF265D51
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 07:25:49 +0200 (CEST)
In-Reply-To: <s5h8v4tyu6c.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, April 08, 2013 10:27 PM
> > +	wait_event_timeout(spec->resume_wq,
> > +			spec->ready_to_resume, msecs_to_jiffies(300));
> > +	if (!spec->ready_to_resume)
> > +		snd_printd(KERN_WARNING "HDMI: Haswell not ready to
> resume\n"); }
> 
> IMO, this should be shown no matter whether with or w/o debug option, i.e.
> use snd_printk().

Yes. Time out would be a serious error.

> > +static void intel_haswell_set_power_state(struct hda_codec *codec,
> hda_nid_t fg,
> > +				 unsigned int power_state)
> > +{
> > +	if (codec->resume_delayed && power_state ==  AC_PWRST_D0) {
> 
> A superfluous space after '=='
> 
> > +		intel_haswell_wait_ready_to_resume(codec);
> > +		codec->resume_delayed = 0;
> > +	}
> > +
> > +	snd_hda_codec_read(codec, fg, 0,
> > +			AC_VERB_SET_POWER_STATE,
> > +			power_state);
> > +
> > +	snd_hda_codec_set_power_to_all(codec, fg, power_state); }
> > +
> > +static inline void intel_haswell_allow_delay_resume(struct hda_codec
> > +*codec)
> 
> You don't have to put inline for such a case.
> Rely more on the compiler.  It shall do that anyway.
> 
> > +{
> > +	struct hdmi_spec *spec = codec->spec;
> > +
> > +	init_waitqueue_head(&spec->resume_wq);
> > +	codec->support_delay_resume = 1;
> > +
> > +	codec->patch_ops.set_power_state =
> > +				intel_haswell_set_power_state;
> 
> No need for a new line...
> 
> > +}
> > +#else
> > +define intel_haswell_allow_delay_resume NULL
> 
> This should be an empty function instead
> 
> #define intel_haswell_allow_delay_resume() do { } while (0)

I made an mistake here. Sorry! 

I've revised the 1st patch comments and 3rd patch as you suggested. Please have a review.

Many thanks
Mengdong
