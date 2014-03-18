From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - verify pin:cvt connection on
 preparing a stream for Intel HDMI codec
Date: Tue, 18 Mar 2014 14:53:07 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B319E23@SHSMSX151.ccr.corp.intel.com>
References: <c8336299f64f1fda9e0d0488fbef5e90a67e287b.1395135128.git.mengdong.lin@intel.com>
 <s5h7g7rsu8i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 35EB0260857
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 15:53:22 +0100 (CET)
In-Reply-To: <s5h7g7rsu8i.wl%tiwai@suse.de>
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
> Sent: Tuesday, March 18, 2014 5:59 PM

> > The pin:converter connection may get reset after S3 on Intel Broadwell
> > HDMI codec. And this can cause multiple pins share a same convertor
> > and mute control will affect each other. We observed a resumed audio
> > playback become silent after S3.
> >
> > This patch verifies pin:cvt connection on preparing a stream, to
> > assure the pin selects the right convetor and an assigned convertor is
> > not shared by other unused pins. Apply this fix-up on Haswell,
> Broadwell and Baytrail.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> Hm, it's still not clear to me why this happens.  The connections are
> recorded via snd_hda_codec_write_cache(), and these values should be
> restored in the resume.  Where the things went wrong?

I don't think it's the problem of snd_hda_codec_write_cache().

When the pcm stream is opened, the convertor to pin connection is configured by the driver, not interrupted by S3, 
and then playback start. But after S3, HW forgets this configuration and pin can select the default convertor. 
Thus a used pin and an unused pin can share a same convertor and a muted pin can make the other used pin no sound output.
As a result, a resumed playback after S3 can have no sound output.

The commit f82d7d16aee5eb4c2315ba11a90f2f3c662d45b8 (ALSA : hda - not use assigned converters for all unused pins) is to avoid convertor sharing when a pcm stream is opened.
Now this patch will verify pin:converter connection and avoid convertor sharing when preparing the stream, for resuming a stream after S3.

Although this issue after S3 is only observed on Broadwell, we want to apply it to Haswell and Baytrail (Valleyview) for safety consideration.

Thanks
Mengdong

 
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 3ab7063..6000ce9 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -68,6 +68,7 @@ struct hdmi_spec_per_pin {
> >  	hda_nid_t pin_nid;
> >  	int num_mux_nids;
> >  	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
> > +	int mux_idx;
> >  	hda_nid_t cvt_nid;
> >
> >  	struct hda_codec *codec;
> > @@ -1342,6 +1343,8 @@ static int hdmi_choose_cvt(struct hda_codec
> *codec,
> >  	if (cvt_idx == spec->num_cvts)
> >  		return -ENODEV;
> >
> > +	per_pin->mux_idx = mux_idx;
> > +
> >  	if (cvt_id)
> >  		*cvt_id = cvt_idx;
> >  	if (mux_id)
> > @@ -1350,6 +1353,22 @@ static int hdmi_choose_cvt(struct hda_codec
> *codec,
> >  	return 0;
> >  }
> >
> > +/* Assure the pin select the right convetor */ static void
> > +intel_verify_pin_cvt_connect(struct hda_codec *codec,
> > +			struct hdmi_spec_per_pin *per_pin) {
> > +	hda_nid_t pin_nid = per_pin->pin_nid;
> > +	int mux_idx, curr;
> > +
> > +	mux_idx = per_pin->mux_idx;
> > +	curr = snd_hda_codec_read(codec, pin_nid, 0,
> > +					  AC_VERB_GET_CONNECT_SEL, 0);
> > +	if (curr != mux_idx)
> > +		snd_hda_codec_write_cache(codec, pin_nid, 0,
> > +					    AC_VERB_SET_CONNECT_SEL,
> > +					    mux_idx);
> > +}
> > +
> >  /* Intel HDMI workaround to fix audio routing issue:
> >   * For some Intel display codecs, pins share the same connection list.
> >   * So a conveter can be selected by multiple pins and playback on any
> > of these @@ -1751,6 +1770,12 @@ static int
> generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> >  	bool non_pcm;
> >  	int pinctl;
> >
> > +	if (is_haswell_plus(codec) || is_valleyview(codec)) {
> > +		/* the pin:cvt connection may get reset after S3 */
> > +		intel_verify_pin_cvt_connect(codec, per_pin);
> > +		intel_not_share_assigned_cvt(codec, pin_nid,
> per_pin->mux_idx);
> > +	}
> > +
> >  	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
> >  	mutex_lock(&per_pin->lock);
> >  	per_pin->channels = substream->runtime->channels;
> > --
> > 1.8.1.2
> >
