From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Tue, 30 Sep 2014 12:45:35 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D05992E6BB@satlexdag05.amd.com>
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
 <A3397C8B8B789E45844E7EC5DEAD89D05992C6FA@satlexdag05.amd.com>
 <542AA10E.8090209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 854FF260693
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 14:45:40 +0200 (CEST)
In-Reply-To: <542AA10E.8090209@canonical.com>
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
> Sent: Tuesday, September 30, 2014 8:25 AM
> To: Deucher, Alexander; Takashi Iwai
> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280 kHz
> 
> 
> 
> On 2014-09-24 23:37, Deucher, Alexander wrote:
> >> But it makes sense that the audio is turned off when the video is, right?
> >
> > It's a bit complicated.  X effectively just blanks (dpms off) the display when
> you disconnect it or xrandr --off.  The resources are not actually reclaimed
> and "disabled" until the next modeset.  I don't think we really want to turn
> audio off when the display goes into dpms as that will be reported as a
> disconnect on the audio side even if the display has just gone to sleep.
> >
> >>
> >> Because if first unplug HDMI (nothing happens) and then run "xrandr"
> >> (without parameters), running that command causes a "re-detection" or
> >> whatever the correct term is - i e, my DVI screen goes black for a
> >> second, and afterwards the mouse pointer can no longer move to the
> other
> >> non-existent display.
> >> At that point, audio still remains in the "plugged in" state. Also,
> >> executing "xrandr --output HDMI-0 --off" has no effect in that state.
> >>
> >
> > The problem is, X just puts the display to sleep when you unplug or xrandr -
> -off.  The current KMS API doesn't really have a notion of "disable".  The
> actual disabling happens at the next modeset when displays that are no
> longer in use are disabled and their resources are freed for possible use in
> the upcoming modeset.  Forcing another modeset with the hdmi
> disconnected should get the status updated properly.
> 
> I'm not sure how to force a modeset, but just for comparison and for the
> desire of consistency, I did the same test with a laptop with an Intel
> built-in card.
> 
> In this case, both plug-in and unplug are responded to immediately on
> both sides, so when the cable is unplugged, the video does a
> "re-detection" which disables the HDMI display, and the audio side
> reports unplugged as well.
> 
> Also, executing "xrandr --output HDMI1 --off" while the cable is plugged
> causes the audio side to report unplugged.
> 
> I think this behaviour makes sense, but I'm not sure my rank is high
> enough to dictate behaviour. :-)

I agree.  It should be possible (barring figuring out what to do in the multiple-connected-HDMI case), but I don't have the cycles right now to do the necessary rework of the driver to move the audio enable/disable and speaker info fetch into the probe and hotplug code paths.

Alex
