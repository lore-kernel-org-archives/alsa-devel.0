From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Fri, 19 Sep 2014 14:14:36 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>
 <541A5BCD.2040105@canonical.com> <s5hlhph8jt5.wl-tiwai@suse.de>
 <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 1520F26507D
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 16:14:43 +0200 (CEST)
In-Reply-To: <541C31EE.4020101@canonical.com>
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
> Sent: Friday, September 19, 2014 9:39 AM
> To: Deucher, Alexander; Takashi Iwai
> Cc: Anssi Hannula; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280 kHz
> 
> On 2014-09-19 00:29, Deucher, Alexander wrote:
> >>>> Well, if jack detection (get pin sense) works, there is.
> >>>
> >>> Does it react if we turn off the HDMI output via xrandr, too?
> >>> I'm not sure whether we need reprogram things in that case, though...
> >>
> >> xrandr correctly reports that "HDMI-0" is disconnected.
> >>
> >> I'm not sure how to turn the HDMI output via xrandr, but I tried "xrandr
> >> --output HDMI-0 --off" and it made no difference in either xrandr
> >> output, nor in codec/eld output.
> >>
> >> What I'm thinking is that it could be that the monitor_present is
> >> indicating the presence of my DVI monitor, as some cards are capable of
> >> outputting HDMI audio on their DVI outputs (through a passive DVI-
> >HDMI
> >> adapter). This is just a guess though.
> >
> > I'm not that familiar with the audio side, but on there are registers on the
> gpu side that will change what is reported to the audio side as far as I can tell.
> You might try the new hdmi patches I sent out today:
> > http://lists.freedesktop.org/archives/dri-devel/2014-
> September/068544.html
> > patch 5/5 is probably the most relevant for this discussion.  It explicitly
> clears the audio enable bit when the display is disabled which should cascade
> down to the audio side if I understand correctly.  If not, I think playing with
> the AZ_HOT_PLUG_CONTROL registers in that patch set can probably sort it
> out.
> 
> Thanks for the attention and the patches!
> 
> I compiled a 3.17-rc4 kernel plus the five patches. (I usually run the
> Ubuntu 3.13 kernel).

I've pushed an updated set to:
http://cgit.freedesktop.org/~agd5f/linux/log/?h=drm-next-3.18-wip

> 
> With this I saw that the jack reported "unplugged" when booting without
> an HDMI monitor, and that when the HDMI monitor was connected and got
> video output, the jack was now reported to be plugged in.
> However, when I unplugged the monitor, the jack was still reported to be
> plugged in.

Did you also run xrandr --output <output> --off?  The audio pins are not tied to a specific output (e.g., there can be multiple HDMI or DP ports on a system), so they are not directly tied to a hotplug pin.  I think the gpu driver has to set the appropriate bits in this register to have the changes reflected in the audio driver.

> 
> I also tried running a get_pin_sense verb manually and it still reported
> to be plugged in.
> 
> Also, I think it was the third time I plugged the monitor in, I got some
> type of GPU hang (see attached log). It never recovered by itself so I
> had to use SysRq to reboot the computer.
> 
> > I'm just not familiar enough with the azalia hw to know exactly how it's
> supposed to interact with the audio side.
> 
> Well, feel free to ask questions if you think we can answer them :-)
> 
> The bits that say PIN*_JACK_DETECTION_ENABLE and
> PIN*_UNSOLICITED_RESPONSE_ENABLE sounds like things that should be
> turned on all the time so we can properly get unsol jack detection
> events when the monitor is plugged or unplugged. Unless the
> PIN*_JACK_DETECTION_ENABLE actually represents the current state rather
> than the detection capability. But that's just guesses, as I assume the
> specs are not released?

I'm not familiar enough with the audio side, but here is some information about the bits in that register.  Hopefully someone more familiar with the audio side can help out.

PIN*_JACK_DETECTION_ENABLE
If PIN0_JACK_DETECTION_ENABLE is 1, changing PIN0_AUDIO_ENABLED will produce jack connection and disconnection status changes in pin0 accordingly. 

 POSSIBLE VALUES:
      00 - setting PIN0_AUDIO_ENABLED does not set pin0 PRESENCE_DETECT
      01 - setting PIN0_AUDIO_ENABLED sets pin0 PRESENCE_DETECT

PIN*_UNSOLICITED_RESPONSE_ENABLE 

For PIN0, If 1, when AUDIO_ENABLED changes, an unsolicited response with payload UNSOLICITED_RESPONSE_PAYLOAD will be sent. 
 POSSIBLE VALUES:
      00 - changing AUDIO_ENABLED does not produce an unsolicited response
      01 - changing AUDIO_ENABLED produces an unsolicited response

CODEC_HOT_PLUG_ENABLE 
If 1, changing AUDIO_ENABLED sets STATE_CHANGE_STATUS.

 POSSIBLE VALUES:
      00 - changing AUDIO_ENABLED does not set STATE_CHANGE_STATUS
      01 - changing AUDIO_ENABLED sets STATE_CHANGE_STATUS

PIN*_AUDIO_ENABLED 
Set to 1 by the driver if an HDMI TV able to take channel pair 0,1 for PIN0 (or 2,3 for PIN1, etc.) is connected, set to 0 if not.

 POSSIBLE VALUES:
      00 - disabled
      01 - enabled

AUDIO_ENABLED 
Set to 1 by the driver when an Audio Enabled HDMI TV is connected, set to 0 when it is disconnected. Zeroed by the driver during mode change to disable audio temporarily in order to avoid noise. The software changes on this bit are used by the CODEC hardware to emulate hot plugging-unplugging of the audio-enabled HDMI TV.

 POSSIBLE VALUES:
      00 - disabled
      01 - enabled

Alex
