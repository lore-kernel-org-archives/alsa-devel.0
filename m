From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/4] ALSA: hda - Return error when open
	empty hdmi device
Date: Mon, 17 Jun 2013 12:25:55 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118306B9@SHSMSX104.ccr.corp.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
	<1371223229-8236-3-git-send-email-xingchao.wang@linux.intel.com>
	<51BEC789.1060408@canonical.com>
	<46B810F6945F7C4788E11DCE57EC48901183065E@SHSMSX104.ccr.corp.intel.com>
	<51BEFDC8.4070309@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <51BEFDC8.4070309@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Monday, June 17, 2013 8:15 PM
> To: Wang, Xingchao
> Cc: Wang Xingchao; tiwai@suse.de; daniel.vetter@ffwll.ch;
> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/4] ALSA: hda - Return error when open empty hdmi
> device
> 
> On 06/17/2013 01:54 PM, Wang, Xingchao wrote:
> >
> >> -----Original Message-----
> >> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >> Sent: Monday, June 17, 2013 4:24 PM
> >> To: Wang Xingchao
> >> Cc: tiwai@suse.de; daniel.vetter@ffwll.ch;
> >> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org; Wang,
> >> Xingchao
> >> Subject: Re: [PATCH 2/4] ALSA: hda - Return error when open empty
> >> hdmi device
> >>
> >> On 06/14/2013 05:20 PM, Wang Xingchao wrote:
> >>> when user open HDMI device 3/7/8, if it has no physical device
> >>> connected, return error.
> >>
> >> This patch will cause regressions in two big use cases:
> >>
> >>    1) Older chipsets (at least from non-Intel vendors) might not
> >> support correct ELD reporting. Thus this will cause HDMI audio to stop
> working there.
> >
> > Thanks for pointing this out. It's a good case I missed. :) I thought
> > ELD info was monitor specific, and reported on common platforms.
> 
> We have a generation of Nvidia cards that does not support presence detect
> (and no ELD) for the audio codec at all.
> 
> I'm not sure if we also have cards where presence detect works, but there
> never comes any ELD. Or if this can potentially vary depending on the
> connected monitor. But I think this should also be handled in the best way.
> 
> > But sometimes user get confused when opening a hdmi device and started
> > to play audio,but hear nothing, even there's no error message. Is
> > there any way for old chipset which has no correct ELD reporting but do have
> audio functionality? App should check before really play audio on the device.
> 
> PulseAudio (with support from some of the GUIs) support looking at the
> Presence Detect, and "hiding" the device if nothing is currently connected.
> 

That's good if pulseaudio can hide the devices. But "aplay -L" still show the full HDMI devices.
I get complains from QA when they test audio playback in cmdline with "aplay" or "speaker-test",
they are confused that the device exists but cannot hear sounds.

Thanks
--xingchao

> I agree in principle with that you should be given some warning if you try to play
> back to unconnected things, but for me it's not a high priority to improve.
> E g, the situation is the same for analog audio - imagine a small desktop with
> only a headphone output: you can still play audio to the headphone output even
> when there's no headphone connected in the jack.
> >>    2) In PulseAudio's current design, PulseAudio probes the device at
> >> startup and caches the result. Unfortunately, there is no reprobing
> >> at plug/unplug, so if the monitor is hotplugged, it will not work
> >> unless PulseAudio is restarted afterwards.
> >
> > For haswell ult board only,  DDI port D is not supported, this results in
> screen flicker when playing on third pin.
> > But for other haswell boards, the DDI port D is normal. So at first
> > glance my idea is to disable opening device without physical device
> connecting.
> 
> Maybe it's possible to fix on the gfx side? It sounds like a graphic driver bug if
> the screen flickers due to anything happening on the audio side.
> 
> >
> > Thanks
> > --xingchao
> >
> >>
> >>
> >>> The bug is from Haswell platform, All pins choose converter 0 by
> >>> default in hardware level, maybe only pin 1 had valid monitor
> >>> connected. if user play audio on pin 0/2, pin 1 can get audio data too.
> >>>
> >>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> >>> ---
> >>>    sound/pci/hda/patch_hdmi.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> >>> index 8db5eb6..d766f40 100644
> >>> --- a/sound/pci/hda/patch_hdmi.c
> >>> +++ b/sound/pci/hda/patch_hdmi.c
> >>> @@ -1139,6 +1139,9 @@ static int hdmi_pcm_open(struct
> >> hda_pcm_stream *hinfo,
> >>>    	per_pin = get_pin(spec, pin_idx);
> >>>    	eld = &per_pin->sink_eld;
> >>>
> >>> +	if (!eld->monitor_present || !eld->eld_valid)
> >>> +		return -EIO;
> >>> +
> >>>    	if (codec->vendor_id == 0x80862807)
> >>>    		hsw_verify_cvt_D0(spec, codec);
> >>>
> >>>
> >>
> >>
> >>
> >> --
> >> David Henningsson, Canonical Ltd.
> >> https://launchpad.net/~diwic
> >
> 
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
