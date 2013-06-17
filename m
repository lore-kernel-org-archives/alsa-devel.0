From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/4] ALSA: hda - Haswell converter power
	state D0 verify
Date: Mon, 17 Jun 2013 11:55:29 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011830676@SHSMSX104.ccr.corp.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
 <1371223229-8236-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5ha9mpnmbb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id AEBA72625C2
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 13:55:33 +0200 (CEST)
In-Reply-To: <s5ha9mpnmbb.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 17, 2013 5:01 PM
> To: Wang Xingchao
> Cc: daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> intel-gfx@lists.freedesktop.org; david.henningsson@canonical.com; Wang,
> Xingchao
> Subject: Re: [PATCH 1/4] ALSA: hda - Haswell converter power state D0 verify
> 
> At Fri, 14 Jun 2013 23:20:26 +0800,
> Wang Xingchao wrote:
> >
> > Haswell converters maybe in wrong power state before usage.
> > i.e. only converter 0 is in D0, converter 1/2 are in D3.
> > When pin choose converter 1/2, there's no audio output.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> 
> Isn't this needed in hdmi_setup_stream() instead of open, like
> haswell_verify_pin_D0() does?  Note that the open callback won't be called at
> PM resume.  Also, if it's just a matter of the connected converter from the
> specific pin, you can check the power state of the specific converter, instead of
> checking the all converters at each time.
> 
> If my guess above is correct, the better code would be to merge the power
> check of converter into haswell_verify_pin_D0().

Good point, will merge it into haswell_verify_pin_D0(), should the API name change accordingly?

Thanks
--xingchao
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > ---
> >  sound/pci/hda/patch_hdmi.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index e12f7a0..8db5eb6 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1053,6 +1053,23 @@ static void haswell_verify_pin_D0(struct
> hda_codec *codec, hda_nid_t nid)
> >  	}
> >  }
> >
> > +static void hsw_verify_cvt_D0(struct hdmi_spec *spec,
> > +			 struct hda_codec *codec)
> > +{
> > +	struct hdmi_spec_per_cvt *per_cvt;
> > +	int pwr, cvt_idx;
> > +
> > +	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> > +		per_cvt = get_cvt(spec, cvt_idx);
> > +		pwr = snd_hda_codec_read(codec, per_cvt->cvt_nid, 0,
> > +				AC_VERB_GET_POWER_STATE, 0);
> > +		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
> > +		if (pwr != AC_PWRST_D0)
> > +			snd_hda_codec_write(codec, per_cvt->cvt_nid, 0,
> AC_VERB_SET_POWER_STATE,
> > +					    AC_PWRST_D0);
> > +	}
> > +}
> > +
> >  /*
> >   * Callbacks
> >   */
> > @@ -1122,6 +1139,9 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  	per_pin = get_pin(spec, pin_idx);
> >  	eld = &per_pin->sink_eld;
> >
> > +	if (codec->vendor_id == 0x80862807)
> > +		hsw_verify_cvt_D0(spec, codec);
> > +
> >  	/* Dynamically assign converter to stream */
> >  	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> >  		per_cvt = get_cvt(spec, cvt_idx);
> > --
> > 1.8.1.2
> >
