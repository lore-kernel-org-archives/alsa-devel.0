From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Thu, 20 Feb 2014 09:50:24 -0600
Message-ID: <CADLC3L3jrnxvP5Ny_DQDy0GBVVOu5yzD4tje5HoknTN+Jq77tA@mail.gmail.com>
References: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
 <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
 <CAN8ccia-cja=_Qh1cwtpvwoxB21F1MVAWYD9reefOn5z7Z0szQ@mail.gmail.com>
 <CADLC3L0PEC_sVrw-+PpQkodvFKOFNicvdL3M5LbiO1Ok8yKkbQ@mail.gmail.com>
 <CAN8ccibdTiSp+-=C6TLPsAbwXmZ=iABAK4Hh9hXALsZAauArdg@mail.gmail.com>
 <CADLC3L3mOfpmAUhrDuo0esCvJ2_VYMyCU2dp_1c7vOcuyWxS2Q@mail.gmail.com>
 <CAN8ccia3a2_Eau4hoLAN6xXFogdXZZx8o=J=Z_1hYunn=8QzqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C99802657B2
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 16:50:24 +0100 (CET)
Received: by mail-wg0-f47.google.com with SMTP id k14so1576170wgh.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 07:50:24 -0800 (PST)
In-Reply-To: <CAN8ccia3a2_Eau4hoLAN6xXFogdXZZx8o=J=Z_1hYunn=8QzqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 19, 2014 at 7:41 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
>> That did give one more result: when plugging in the headphone-only
>> jack, 0x18 (Not connected) reports present. I'm not sure if node 0x18
>> is actually related to the headphone for anything other than the jack
>> sensing, though, as none of the settings for that node in hda_analyzer
>> have any effect on the audio output on that jack (even the mute).
>
>
> did you set pin ctl to OUT HP of node 0x18 ?

Setting OUT didn't seem to change anything. That node doesn't appear
to support HP mode.

>> As I mentioned in the Bugzilla report, as it turns out, with default
>> settings I can get audio to play out from the headphone jack with the
>> "Analog Output" mode selected in PulseAudio. The big problem is that
>> the audio is distorted with hiss and popping noises, which I haven't
>> been able to figure out at all. Any suggestions?
>
>
> do pulseaudio log show any path is removed since you don't have headphone
> playback volume or front playback volume , front playback switch?

Not sure quite what you mean. I've been doing most of my recent tests
with PulseAudio not running, to eliminate that variable.

>
> try hint jack_detect=0 to disable all jack detection of all jacks
>
> and use hda-analyzer to mute /unmute the pin complex of line out and
> headphone
>
> the other thing you can try is use hda-jack-retask to change internal
> speaker as [N/A] , this allow line out and headphone get it own volume
> control and audio output

I've tried all three of these now without any real success. Still that
noise on the output. Think I might need to try some tests with Windows
or other Linux versions to see if there is just some hardware problem
on this machine.
