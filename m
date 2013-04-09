From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Tue, 9 Apr 2013 08:18:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F837A47F@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
 <515AC6AC.8040504@canonical.com>	<s5hr4it6s7n.wl%tiwai@suse.de>
 <515AD3E4.2000208@canonical.com>	<s5hmwtd2ksk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837402E@SHSMSX101.ccr.corp.intel.com>
 <s5hk3og3o47.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
 <51629295.1000701@canonical.com>	<s5h4nfh1fsh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
 <5162AB7D.40103@canonical.com>	<s5hzjx9z10c.wl%tiwai@suse.de>
 <5162B60C.6000509@canonical.com>	<s5htxnhyzvu.wl%tiwai@suse.de>
 <5162C671.90405@canonical.com>	<s5hhajhyvww.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com> <s5hhajg175u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C2AC265D86
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 10:18:26 +0200 (CEST)
In-Reply-To: <s5hhajg175u.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, April 09, 2013 3:43 PM
> To: David Henningsson
> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
> in system resume

> > >> I've been answering the power_save questions a little bit uncertain
> > >> so far, and that's because I don't really know. I've not
> > >> investigated power management much.
> > >>
> > >> But the person with the hardware reports that this problem happens
> > >> when on AC power only. And that makes sense with your observations
> > >> about power_save - there could very well be something that turns
> > >> power_save off when on AC power and on when on battery power.
> > >>
> > >> So, if it's just a matter of re-initializing the pin, what do you
> > >> think about this solution:
> > >>
> > >>    - Resume as normal (this will enable unsol events)
> > >>    - Any time an unsol event comes in, have a haswell specific
> > >> function that checks relevant pins to see that is still in D0 and
> > >> mute state correct. If not, correct it.
> > >>    - This check could possibly also be done in the prepare hook for
> > >> extra safety.
> > >
> > > It won't work reliably.  The problem is that the codec might be set
> > > up wrongly if it's used before the unsol event comes up.  For
> > > example, a PCM resume may be performed immediately after the normal
> > > resume is finished.  Meanwhile the first unsol may arrive much later than
> that.
> >
> > Right, but if this will only mean a few samples (max 300 ms?) will
> > never reach the HDMI cable, it might be the least bad workaround.

I've tried enabling the unsol event on system resume, the unsol event will arrive in 70~80ms for HDMI and about 10ms for DP.

> It's not only about the missing few samples.  The whole setup isn't reliable at
> that point, and you don't know what to re-setup for the
> *running* stream.
> 
> > > Thus we need to delay the resume operation in anyway.  And if so,
> > > there is no merit to perform the normal resume operation at the
> > > first step.
> >
> > The normal resume operation enables unsol events, which is important,
> > otherwise we don't get the unsol notification from when the gfx
> > pipeline has finished.
> 
> It seems that the intrinsic unsol event is always issued once when the unsol
> event is enabled, according to Intel.  So, you won't miss it.
> 
> But heck, we need more test coverage, obviously.
> 
> > I guess the question here is how much of the codec setup is really
> > destroyed by the gfx driver? Is it just a pin in D3 and a right
> > channel mute, or is it much more that needs to be re-done after the
> > gfx driver has finished?
> 
> I'm afraid it's too native to assume that...

Actually, we're not sure how much setting are destroyed, although it seems only the pin power state and mute status are affected.

Thanks
Mengdong
