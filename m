From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
Date: Wed, 26 Jun 2013 04:28:43 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011834CF7@SHSMSX104.ccr.corp.intel.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hobavvj4n.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833BCC@SHSMSX104.ccr.corp.intel.com>
 <s5h61x3vfke.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901183434E@SHSMSX104.ccr.corp.intel.com>
 <s5h8v1y2076.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC4890118343CA@SHSMSX104.ccr.corp.intel.com>
 <s5hy59yzn2f.wl%tiwai@suse.de> <s5hwqpizmy8.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901183445F@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ACF1261AD5
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 06:28:49 +0200 (CEST)
In-Reply-To: <46B810F6945F7C4788E11DCE57EC48901183445F@SHSMSX104.ccr.corp.intel.com>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, 'Wang Xingchao' <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Wang, Xingchao
> Sent: Tuesday, June 25, 2013 4:30 PM
> To: Takashi Iwai
> Cc: alsa-devel@alsa-project.org; Wang Xingchao

[snip]

> > > >
> > > > Do you assume jackpoll_interval be non-zero? If so the
> > > > hda_jackpoll_work
> > will continue to run periodically.
> > > > IMO the callback just need be called only once at resume time.
> > >
> > > Hmm, the problem is that the callback updater isn't called in the
> > > resume path as default.  The oneliner below will fix it.
> >
> > Forgot to attach...
> 
> Yes, it works if call snd_hda_jack_poll_all(codec) directly, but sometimes read
> pin sense value is 0xc000,0000 even unplug monitor, and eld# will keep valid all
> the time.
> Although sometimes it works(the ELD info refreshed correctly), you have to
> wake up controller/codec before check eld info(cat codec# or play a piece of
> audio).

The fix is not enough.
When hotplug event happen and codec/controller in active state, hdmi_intrinsic_event() will be called.
In such scenario, jack event would be reported but not handled(hdmi_present_sense() was moved to callback).
So there's no eld info updated, have to trigger codec_resume to update the eld info.

If App depends on ELD# info to check external monitor status, it may cause confuse as eld# under /proc donot
Provide realtime information.

Thanks
--xingchao
> 
> Thanks
> --xingchao
> 
> >
> >
> > Takashi
> >
> > ---
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index
> > 35090b3..86d4709 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -3942,6 +3942,7 @@ static void hda_call_codec_resume(struct
> > hda_codec *codec)
> >  			codec->patch_ops.init(codec);
> >  		snd_hda_codec_resume_amp(codec);
> >  		snd_hda_codec_resume_cache(codec);
> > +		snd_hda_jack_poll_all(codec);
> >  	}
> >
> >  	if (codec->jackpoll_interval)
