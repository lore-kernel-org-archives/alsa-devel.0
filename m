From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
Date: Tue, 25 Jun 2013 06:15:05 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118343AD@SHSMSX104.ccr.corp.intel.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hobavvj4n.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833BCC@SHSMSX104.ccr.corp.intel.com>
 <s5h61x3vfke.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7292726552B
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 08:15:14 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Wang, Xingchao
> Sent: Tuesday, June 25, 2013 12:54 PM
> To: 'Takashi Iwai'
> Cc: alsa-devel@alsa-project.org; Wang Xingchao
> Subject: RE: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> 
> Hi Takashi,
> 
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Monday, June 24, 2013 8:50 PM
> > To: Wang, Xingchao
> > Cc: alsa-devel@alsa-project.org; Wang Xingchao
> > Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> >
> > At Mon, 24 Jun 2013 12:19:42 +0000,
> > Wang, Xingchao wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Monday, June 24, 2013 7:33 PM
> > > > To: Wang Xingchao
> > > > Cc: alsa-devel@alsa-project.org; Wang, Xingchao
> > > > Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> > > >
> > > > At Mon, 24 Jun 2013 07:45:23 -0400, Wang Xingchao wrote:
> > > > >
> > > > > Hdmi driver may not receive intrinsic event from gfx side when
> > > > > it's in runtime suspend mode. There's no ELD info when exit from
> > > > > runtime suspend. This patch avoid missing ELD info.
> > > >
> > > > hda_call_codec_resume() sets the jack detection all dirty, thus
> > > > each jack detection callback should be called at resume.  Didn't
> > > > it work as
> > expected?
> > >
> > > I would double check that. In my test, it doesnot work as expected.
> >
> > OK, I found the problem.  patch_hdmi.c enables the jack detection
> > stuff without the callback, so the resume code triggers the check of
> > jack detection but only updates the kcontrols.
> 
> You patch did not resolve the issue.
> I added some debug log, the callback wasnot called at all.
> I will continue to check it.
> 
Seems jackpoll_interval be 0 by default, and the callback was not called.
I think this would be a common issue not limited to Haswell, so what about call had_jackpoll_work()
in snd_hda_codec_resume()?

Thanks
--xingchao

> Thanks
> --xingchao
> >
> > How about the patch below instead?
> >
> >
> > Takashi
> >
> > ---
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index
> > 8428763..3059d69 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -950,14 +950,10 @@ static void hdmi_setup_audio_infoframe(struct
> > hda_codec *codec, int pin_idx,
> >   * Unsolicited events
> >   */
> >
> > -static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int
> > repoll);
> > -
> >  static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned
> > int res) {
> > -	struct hdmi_spec *spec = codec->spec;
> >  	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
> >  	int pin_nid;
> > -	int pin_idx;
> >  	struct hda_jack_tbl *jack;
> >
> >  	jack = snd_hda_jack_tbl_get_from_tag(codec, tag); @@ -970,12 +966,6
> > @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned
> > int
> > res)
> >  		"HDMI hot plug event: Codec=%d Pin=%d Presence_Detect=%d
> > ELD_Valid=%d\n",
> >  		codec->addr, pin_nid,
> >  		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
> > -
> > -	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
> > -	if (pin_idx < 0)
> > -		return;
> > -
> > -	hdmi_present_sense(get_pin(spec, pin_idx), 1);
> >  	snd_hda_jack_report_sync(codec);
> >  }
> >
> > @@ -1358,6 +1348,14 @@ static void hdmi_repoll_eld(struct work_struct
> > *work)
> >  	hdmi_present_sense(per_pin, per_pin->repoll_count);  }
> >
> > +static void hdmi_jack_detect_cb(struct hda_codec *codec, struct
> > +hda_jack_tbl *jack) {
> > +	struct hdmi_spec *spec = codec->spec;
> > +	int pin_idx = pin_nid_to_pin_index(spec, jack->nid);
> > +	if (pin_idx >= 0)
> > +		hdmi_present_sense(get_pin(spec, pin_idx), 1); }
> > +
> >  static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
> >  					     hda_nid_t nid);
> >
> > @@ -1827,7 +1825,8 @@ static int generic_hdmi_init(struct hda_codec
> > *codec)
> >  		hda_nid_t pin_nid = per_pin->pin_nid;
> >
> >  		hdmi_init_pin(codec, pin_nid);
> > -		snd_hda_jack_detect_enable(codec, pin_nid, pin_nid);
> > +		snd_hda_jack_detect_enable_callback(codec, pin_nid, pin_nid,
> > +						    hdmi_jack_detect_cb);
> >  	}
> >  	return 0;
> >  }
