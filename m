From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Realtek ALC662 rev1 no sound over HDMI
Date: Mon, 27 Jun 2011 13:06:17 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EC34C@HQMAIL01.nvidia.com>
References: <BANLkTim2NwanrTtgsYGwHjkyW34fiHuuBQ@mail.gmail.com>
	<s5hr56f3abz.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049D2EC259@HQMAIL01.nvidia.com>
	<BANLkTingUSKSVBRW_Xnh4ALNJnt3FBMTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 46D1A2437F
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 22:06:35 +0200 (CEST)
In-Reply-To: <BANLkTingUSKSVBRW_Xnh4ALNJnt3FBMTww@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: crow <crow@linux.org.ba>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Crow wrote at Monday, June 27, 2011 11:49 AM:
> >> At Sun, 26 Jun 2011 18:45:30 +0200, crow wrote:
> >> >
> >> > I am trying to get sound working on kernel 2.6.39 (under archlinux
> >> > x86_64 bit distribution) over HDMI to my digital receiver but without
> >> > luck. Before this post i asked in #alsa for help, and everything we
> >> > tried over there didnt get the sound over HDMI.
> >> > I connected headphones to the green jack and ran speaker-test and
> >> > there is sound over jack, analog sound plays fine. But runing
> >> > alsamixer un-muting spdif/iec958/spdif (1) and trying to re run
> >> > speaker-test doesn't output sound over HDMI to my digital receiver.
...
> I dont have any GUI here, trough i installed xorg,nvidia,alsa and
> prepared for VDR/XBMC.

I don't quite understand that last sentence. Just to be clear, audio over
HDMI isn't expected to work unless the NVIDIA binary X driver is installed,
X is running, and X is being displayed over HDMI.

> SOLVED:
> Well I must mark this as solved. Inside .xine/config i have :hdmi as
> output device defined, and i get sound on my speakers using just HDMI
> as connection to my digital receiver.
>...
> I actualy didnt test it before with xine, and was trying just
> speaker-test which seems could not output sound over :hdmi (0,3).
> Maybe there is bug in speaker-test, but then after getting it work
> with xine i could test it with speaker-test to..
> Then i reboted my htpc and got it.. It seems HDMI output isnt
> activated, or speaker-test cant activate it somehow..
> $ speaker-test -c 2 -r 48000 -D hw:0,3
> $ speaker-test -c 2 -D hw:0,3
> Both above command dont work after first boot. And with aplay i get
> this (command from 13.7. Test Playback With ALSA Physical Devices (1):
> aplay -D hw:0,3 /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Mono
> aplay: set_params:1065: Channels count non available
> 
> But if i run xine, which connects to VDR i get sound, and after
> killing xine, and re-run speaker-test i got audio over HDMI just
> fine...
> $ speaker-test -c 2 -r 48000 -D hw:0,3
> $ speaker-test -c 2 -D hw:0,3

That's odd. I don't understand why running xine first would help.

Perhaps you could try compiling the very latest ALSA kernel driver code,
and seeing if that makes any difference? Recently, some changes were made
in the way the HDMI audio infoframes get set up for the chipset you're
using.

-- 
nvpublic
