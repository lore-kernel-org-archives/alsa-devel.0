From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Audio crackles with 4.1-rc1
Date: Thu, 30 Apr 2015 16:01:31 +0100
Message-ID: <20150430150131.GA10148@earth.li>
References: <20150428112156.GQ10148@earth.li>
 <s5hvbggv4xa.wl-tiwai@suse.de>
 <20150428123518.GU10148@earth.li>
 <s5hpp6ov1wv.wl-tiwai@suse.de>
 <s5ha8xsuxe3.wl-tiwai@suse.de>
 <20150429112859.GY10148@earth.li>
 <s5h4mnzgne6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h4mnzgne6.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 01:54:57PM +0200, Takashi Iwai wrote:
> At Wed, 29 Apr 2015 12:28:59 +0100,
> Jonathan McDowell wrote:
> > 
> > On Tue, Apr 28, 2015 at 04:43:00PM +0200, Takashi Iwai wrote:
> > > At Tue, 28 Apr 2015 15:05:20 +0200,
> > > Takashi Iwai wrote:
> > > > At Tue, 28 Apr 2015 13:35:18 +0100,
> > > > Jonathan McDowell wrote:
> > > > > On Tue, Apr 28, 2015 at 02:00:17PM +0200, Takashi Iwai wrote:
> > > > > > At Tue, 28 Apr 2015 12:21:57 +0100,
> > > > > > Jonathan McDowell wrote:
> > > > > >
> > > > > > > Having upgraded to 4.1-rc1 from 4.0 I'm now hearing audio
> > > > > > > crackles at regular intervals. I'm fairly sure this is due to
> > > > > > > the HDA power save as once audio is playing things are fine,
> > > > > > > it's just when starting to play audio that I hear the crackle.
> > > > > > > 
> > > > > > > System is a Dell Latitude E7240. I haven't tried a bisect yet
> > > > > > > but will attempt to find some time to do so in the next few
> > > > > > > days. It looks like there have been some changes in sound/hda/
> > > > > > > between 4.0 + 4.1-rc1 so I'll concentrate on those first.
> > > > > > > 
> > > > > > There are lots of code changes and enhancements wrt power saving
> > > > > > in 4.1, and bisection won't help so much, I'm afraid.
> > > > > > 
> > > > > > First off, check the device status while you hear crackles.  Is
> > > > > > the codec in runtime suspend (aka power save)?  This can be seen
> > > > > > in /sys/bus/hdaudio/devices/*/power/runtime_status.  Then check
> > > > > > the runtime status of the controller, too, found in
> > > > > > /sys/class/sound/card?/device/power/runtime_status.
> > > > > 
> > > > > The cracking is definitely happening with the transition from suspended
> > > > > to active:
> > > > > 
> > > > > /sys/class/sound/card0/device/power/runtime_status:suspended
> > > > > /sys/class/sound/card1/device/power/runtime_status:active
> > > > > /sys/bus/hdaudio/devices/hdaudioC0D0/power/runtime_status:suspended
> > > > > /sys/bus/hdaudio/devices/hdaudioC1D0/power/runtime_status:active
> > > > > 
> > > > > card1 + C1D0 were suspended, I hit delete in a terminal to force a
> > > > > terminal bell, got the crackle and the state changed to active as above.
> > > > 
> > > > Ah, so it's a click noise that happens only once per runtime PM
> > > > transition?  I thought it were constant crackling noises from your
> > > > description ("regular intervals").
> > > > 
> > > > In anyway, please give alsa-info.sh output on both 4.0 and 4.1.
> > > 
> > > Also, does the click noise occur only at powering up, and not at
> > > powering down?
> > 
> > The click is only on the transition from suspended to active; not
> > constantly during playback and not when transitioning from active to
> > suspended. It doesn't appear 4.0 is doing the suspending at all; there
> > are no /sys/bus/hdaudio/devices/*/power/runtime_status files and the
> > card runtime_status is always active. alsa-info for 4.0 + 4.1-rc1
> > attached.
> 
> OK, thanks for clarification.
> 
> One patch you can try (with or without power_save_node disablement) is
> below, it squashes the verb sequences at (runtime) PM resume as we did
> for 4.0.  Let me know if this changes the behavior.

Patch alone has no effect. Patch with power_save_node disablement solves
the problem. Didn't try power_save_node disablement without the patch.

J.

-- 
This .sig brought to you by the letter M and the number  7
Product of the Republic of HuggieTag
