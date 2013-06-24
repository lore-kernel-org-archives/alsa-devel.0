From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
Date: Mon, 24 Jun 2013 12:19:42 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011833BCC@SHSMSX104.ccr.corp.intel.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hobavvj4n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DC6261B16
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 14:19:52 +0200 (CEST)
In-Reply-To: <s5hobavvj4n.wl%tiwai@suse.de>
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
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 24, 2013 7:33 PM
> To: Wang Xingchao
> Cc: alsa-devel@alsa-project.org; Wang, Xingchao
> Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> 
> At Mon, 24 Jun 2013 07:45:23 -0400,
> Wang Xingchao wrote:
> >
> > Hdmi driver may not receive intrinsic event from gfx side when it's in
> > runtime suspend mode. There's no ELD info when exit from runtime
> > suspend. This patch avoid missing ELD info.
> 
> hda_call_codec_resume() sets the jack detection all dirty, thus each jack
> detection callback should be called at resume.  Didn't it work as expected?

I would double check that. In my test, it doesnot work as expected.

--xingchao
> 
> 
> Takashi
> 
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 7803ddd..cb8ac66 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1868,12 +1868,33 @@ static void generic_hdmi_free(struct hda_codec
> *codec)
> >  	kfree(spec);
> >  }
> >
> > +#ifdef CONFIG_PM
> > +static int generic_hdmi_resume(struct hda_codec *codec) {
> > +	struct hdmi_spec *spec = codec->spec;
> > +	int pin_idx;
> > +
> > +	generic_hdmi_init(codec);
> > +	snd_hda_codec_resume_amp(codec);
> > +	snd_hda_codec_resume_cache(codec);
> > +
> > +	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > +		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> > +		hdmi_present_sense(per_pin, 1);
> > +	}
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static const struct hda_codec_ops generic_hdmi_patch_ops = {
> >  	.init			= generic_hdmi_init,
> >  	.free			= generic_hdmi_free,
> >  	.build_pcms		= generic_hdmi_build_pcms,
> >  	.build_controls		= generic_hdmi_build_controls,
> >  	.unsol_event		= hdmi_unsol_event,
> > +#ifdef CONFIG_PM
> > +	.resume 		= generic_hdmi_resume,
> > +#endif
> >  };
> >
> >
> > --
> > 1.8.1.2
> >
