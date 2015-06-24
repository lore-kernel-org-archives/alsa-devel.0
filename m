From: "Kaskinen, Tanu" <tanu.kaskinen@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Wed, 24 Jun 2015 20:47:24 +0000
Message-ID: <1435178842.7153.34.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de> <20150622125429.GW25769@phenom.ffwll.local>
 <s5h7fqv7u7s.wl-tiwai@suse.de> <1434979769.2503.32.camel@loki>
 <1434986474.6176.53.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hioafeoj4.wl-tiwai@suse.de>
 <1435045881.6176.76.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hmvzqyhk6.wl-tiwai@suse.de>
 <1435149708.23893.55.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1435151171.2655.67.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 20592260644
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 22:48:02 +0200 (CEST)
In-Reply-To: <1435151171.2655.67.camel@loki>
Content-Language: en-US
Content-ID: <26A47F7B9B7C7C4E9FBD64087E7D0A91@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Lu, Han" <han.lu@intel.com>, "airlied@gmail.com" <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-06-24 at 14:06 +0100, Liam Girdwood wrote:
> On Wed, 2015-06-24 at 12:41 +0000, Kaskinen, Tanu wrote:
> > On Tue, 2015-06-23 at 10:06 +0200, Takashi Iwai wrote:
> > > At Tue, 23 Jun 2015 07:51:22 +0000,
> > > Kaskinen, Tanu wrote:
> > > > 
> > > > (Added pulseaudio-discuss to CC.)
> > > > 
> > > > On Mon, 2015-06-22 at 17:44 +0200, Takashi Iwai wrote:
> > > > > At Mon, 22 Jun 2015 15:21:16 +0000,
> > > > > Kaskinen, Tanu wrote:
> > > > > > 
> > > > > > On Mon, 2015-06-22 at 14:29 +0100, Liam Girdwood wrote:
> > 
> > <snip>
> > 
> > > > > > > Tanu, what's your take on the effort for dynamically created PCMs
> > > > > > > support for pulseaudio ?
> > > > > > 
> > > > > > It's a significant amount of work, but I think PulseAudio should be
> > > > > > improved to support this in any case, if other approaches make life
> > > > > > miserable for driver developers.
> > > > > > 
> > > > > > What would be the interface for getting notifications about new and
> > > > > > removed PCM devices? udev?
> > > > > 
> > > > > In general, yes.
> > > > > 
> > > > > > PulseAudio (mostly) doesn't use the hw:X devices directly. Instead, it
> > > > > > uses logical names like "front", "hdmi", "iec958", etc. Speaking of HDMI
> > > > > > specifically, PulseAudio uses devices from "hdmi:X,0" to "hdmi:X,7".
> > > > > > With this new dynamic PCM system, do these logical names still work?
> > > > > 
> > > > > Unfortunately, this doesn't work for HDA as is, because of the
> > > > > terribly arcane secret.  For keeping the compatibility with the old
> > > > > config, there is a static mapping of the hdmi:x,y and hw:x,z.
> > > > > 
> > > > > Maybe we should introduce a new device class for dynamic HDMI/DP
> > > > > device, something like dhdmi:x,y, to make things straightforward.
> > > > > (Just a concept -- I'm not good at naming.)
> > > > > 
> > > > > Alternatively, we may introduce a new argument to hdmi PCM to access
> > > > > like "hdmi:CARD=x,SYSDEV=y".
> > > > 
> > > > What happens if PulseAudio tries to open "dhdmi:x,y" or
> > > > "hdmi:CARD=x,SYSDEV=y", when y points to a non-HDMI device? If it fails,
> > > > then PulseAudio can replace its current "hdmi:x,[0-7]" devices with
> > > > "hdmi:CARD=X,SYSDEV=[0-13]" and blindly try every hw PCM device. But if
> > > > opening a non-HDMI device through "hdmi:CARD=x,SYSDEV=y" succeeds, then
> > > > how is PulseAudio supposed to know which hw PCM devices are HDMI
> > > > devices?
> > > 
> > > It's a good question.  I think this is the core part of the missing
> > > pieces.
> > > 
> > > What I have in my mind is to extend SNDRV_PCM_CLASS_* definition for
> > > dedicated to HDMI/DP, e.g. SNDRV_PCM_CLASS_HDMI.  The difference
> > > between DP and HDMI can be specified in subclass optionally.
> > 
> > Sounds good. Knowing the difference between HDMI, DisplayPort and
> > Thunderbolt would be very nice too. It would enable better labelling in
> > UIs.
> > 
> > I have one minor concern, though: what if a PCM device isn't statically
> > assigned to one output connector? Is it possible that some DSP is able
> > to dynamically change the PCM routing between different outputs? In
> > those cases the PCM class would be useless information (unless there are
> > notifications when the class changes). I don't have any better ideas,
> > though.
> > 
> 
> This is possible atm, we can route from one PCM to multiple outputs
> depending on DSP and codec mixer settings. The outputs can even be on
> different physical interfaces. 

Hmm, my question was a bit silly. It has been possible forever to switch
between e.g. headphones and speakers using just the mixer. And in this
case that we're discussing, the question was irrelevant anyway, because
surely the dynamically created PCM would be dedicated to the plugged-in
HDMI port, otherwise the dynamic creation wouldn't really make sense.
So, setting the PCM class should work at least in this case.

If there are cases where the DSP may route the same PCM to either HDMI
or non-HDMI output depending on mixer settings, then that's when the PCM
class would be less useful.

In any case, PulseAudio needs to figure out whether it should ignore the
PCM class and use "hdmi:x,y" or whether it should check the PCM class
and use "hdmi:CARD=x,SYSDEV=y". How should that be done? Is checking the
kernel (and alsa-lib) version a good approach, or is some other
mechanism needed? Checking the versions should work, if all HDMI audio
drivers start to set the PCM class at the same time, but if some drivers
set it and some don't, then version checking isn't a reliable solution.

-- 
Tanu
