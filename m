From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Wed, 24 Sep 2014 21:37:47 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D05992C6FA@satlexdag05.amd.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>
 <541A5BCD.2040105@canonical.com> <s5hlhph8jt5.wl-tiwai@suse.de>
 <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
 <541C6C23.1040403@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992AB48@satlexdag05.amd.com>
 <541CC506.601@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992B6A6@satlexdag05.amd.com>
 <54203495.60903@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992B76D@satlexdag05.amd.com>
 <542141C0.3010503@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992BD02@satlexdag05.amd.com>
 <54228E8A.5060209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 by alsa0.perex.cz (Postfix) with ESMTP id 047DA2650BA
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 23:37:53 +0200 (CEST)
In-Reply-To: <54228E8A.5060209@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Wednesday, September 24, 2014 5:28 AM
> To: Deucher, Alexander; Takashi Iwai
> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280 kHz
> 
> 
> 
> On 2014-09-23 16:07, Deucher, Alexander wrote:
> >> -----Original Message-----
> >> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >> Sent: Tuesday, September 23, 2014 5:48 AM
> >> To: Deucher, Alexander; Takashi Iwai
> >> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> >> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280
> kHz
> >>
> >>
> >>
> >> On 2014-09-22 16:52, Deucher, Alexander wrote:
> >>>> -----Original Message-----
> >>>> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >>>> Sent: Monday, September 22, 2014 10:39 AM
> >>>> To: Deucher, Alexander; Takashi Iwai
> >>>> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> >>>> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at
> 280
> >> kHz
> >>>>
> >>>> On 2014-09-22 14:46, Deucher, Alexander wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: David Henningsson
> [mailto:david.henningsson@canonical.com]
> >>>>>> Sent: Friday, September 19, 2014 8:07 PM
> >>>>>> To: Deucher, Alexander; Takashi Iwai
> >>>>>> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> >>>>>> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at
> >> 280
> >>>> kHz
> >>>>>>
> >>>>>> Btw, is there a register dump utility I could use to get the current
> >>>>>> register value, e g by reading sysfs or procfs? It could be interesting
> >>>>>> to see if anything we do on the audio side would affect this register.
> >>>>>
> >>>>> You can use the radeonreg tool to dump registers:
> >>>>> http://cgit.freedesktop.org/~airlied/radeontool
> >>>>
> >>>> Thanks, I have now tried this, together with the kernel from
> >>>> drm-next-3.18-wip.
> >>>>
> >>>>    From your patches it looks like I should look at the dumped register
> >>>> 0x7300, is that correct?
> >>>
> >>> What GPU do you have?  The offset of that register varies between
> >> generations.
> >>
> >> Not sure exactly what GPU info you need, but here's the lspci info:
> >>
> >> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
> >> [AMD/ATI] RV710 [Radeon HD 4550] [1002:9540] (prog-if 00 [VGA
> controller])
> >>           Subsystem: PC Partner Limited / Sapphire Technology Device
> >> [174b:e106]
> >>
> >
> > That's an R7xx, so 0x7300 is correct.
> >
> >>>> At boot up, this register is 001000f0. (Out of curiousity, I tried
> >>>> disabling unsol events from the audio side, but this did not change the
> >>>> register.)
> >>>> After HDMI plug in, the register changed to 0x8f1000f0, the jack
> >>>> reported being plugged in, and audio worked.
> >>>>
> >>>> After HDMI unplugged again, the register remained at 0x8f1000f0, and
> >>>> "xrandr --output HDMI-0 --off" did not help.
> >>>>
> >>>> However, when looking at your code, I also spotted something in the
> >>>> patch called "disable audio when we disable hdmi":
> >>>>
> >>>> if (!enable && dig->afmt->pin) {
> >>>>        r600_audio_enable(rdev, dig->afmt->pin, 0xf);
> >>>>                                                ^^^
> >>>> If enable is false, should we not set the last parameter to 0 instead of
> >>>> 0xf?
> >>>
> >>> Yup.  Good catch.  I've fixed that up and pushed a new drm-next-3.18-
> wip
> >> branch.
> >>
> >> Ok, I have tested this now, with mixed results. One time when I
> >> unplugged I believe it correctly switched back to unplugged on the audio
> >> side (after running "xrandr", with no parameters). But the next time it
> >> did not.
> >>
> >
> > Like I said, it's not tied to the physical unplug event.  You have to actually
> turn off the display with xrandr either explicitly or by your desktop
> environment as a response to a hotplug event.
> 
> But it makes sense that the audio is turned off when the video is, right?

It's a bit complicated.  X effectively just blanks (dpms off) the display when you disconnect it or xrandr --off.  The resources are not actually reclaimed and "disabled" until the next modeset.  I don't think we really want to turn audio off when the display goes into dpms as that will be reported as a disconnect on the audio side even if the display has just gone to sleep.

> 
> Because if first unplug HDMI (nothing happens) and then run "xrandr"
> (without parameters), running that command causes a "re-detection" or
> whatever the correct term is - i e, my DVI screen goes black for a
> second, and afterwards the mouse pointer can no longer move to the other
> non-existent display.
> At that point, audio still remains in the "plugged in" state. Also,
> executing "xrandr --output HDMI-0 --off" has no effect in that state.
> 

The problem is, X just puts the display to sleep when you unplug or xrandr --off.  The current KMS API doesn't really have a notion of "disable".  The actual disabling happens at the next modeset when displays that are no longer in use are disabled and their resources are freed for possible use in the upcoming modeset.  Forcing another modeset with the hdmi disconnected should get the status updated properly.

> >> So far, it looks like whenever the audio side reports presence, the
> >> 0x7300 register is set to 0x8f1000f0. So as long as we can get the video
> >> side to correctly turn off the right bits of that register when the
> >> monitor is disabled/disconnected, things should be working on the audio
> >> side.
> >
> > Can you confirm the value of 0x7300 matches what you expect in the audio
> driver?  E.g., does setting/clearing the appropriate bits reflect properly on
> the audio side?  I think the only bit that may matter is bit 31
> (AUDIO_ENABLED).
> 
> I've now tried these commands:
> 
> radeonreg regset 0x7300 0x001000f0 and
> radeonreg regset 0x7300 0x8f1000f0
> 
> Both commands update the audio side to report either unplugged or
> plugged in, so things seem to work as expected w r t the connection
> between this register and the audio side.

Great.  Looks like we got this one sorted out.

Alex
