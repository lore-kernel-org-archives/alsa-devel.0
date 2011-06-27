From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Realtek ALC662 rev1 no sound over HDMI
Date: Mon, 27 Jun 2011 14:44:06 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EC3A6@HQMAIL01.nvidia.com>
References: <BANLkTim2NwanrTtgsYGwHjkyW34fiHuuBQ@mail.gmail.com>
	<s5hr56f3abz.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049D2EC259@HQMAIL01.nvidia.com>
	<BANLkTingUSKSVBRW_Xnh4ALNJnt3FBMTww@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049D2EC34C@HQMAIL01.nvidia.com>
	<BANLkTi=HHGjUjFix8gQYUu2RKBRZpY+NEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9482438A
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 23:44:37 +0200 (CEST)
In-Reply-To: <BANLkTi=HHGjUjFix8gQYUu2RKBRZpY+NEA@mail.gmail.com>
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

Crow wrote at Monday, June 27, 2011 2:44 PM:
> On Mon, Jun 27, 2011 at 10:06 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Crow wrote at Monday, June 27, 2011 11:49 AM:
> >> >> At Sun, 26 Jun 2011 18:45:30 +0200, crow wrote:
> >> >> >
> >> >> > I am trying to get sound working on kernel 2.6.39 (under archlinux
> >> >> > x86_64 bit distribution) over HDMI to my digital receiver but without
> >> >> > luck. Before this post i asked in #alsa for help, and everything we
> >> >> > tried over there didnt get the sound over HDMI.
> >> >> > I connected headphones to the green jack and ran speaker-test and
> >> >> > there is sound over jack, analog sound plays fine. But runing
> >> >> > alsamixer un-muting spdif/iec958/spdif (1) and trying to re run
> >> >> > speaker-test doesn't output sound over HDMI to my digital receiver.
> > ...
> >> I dont have any GUI here, trough i installed xorg,nvidia,alsa and
> >> prepared for VDR/XBMC.
> >
> > I don't quite understand that last sentence. Just to be clear, audio over
> > HDMI isn't expected to work unless the NVIDIA binary X driver is installed,
> > X is running, and X is being displayed over HDMI.
> >
> Well when I was using speaker-test command I was in command line
> interface. Nvidia binary X driver is installed and loaded, X isnt
> runing, nor is xine. They are started after, with vdrclient startup
> script. Trying speaker-test befor X and xine, does not give me any
> output to speakres (even, speaker-test plays, no error output just
> nothing on speakers). Now i start vdrclient script which do (1) and
> (2) and i get sound on speakers. Then i stop vdrclient, and i checked
> X isnt runing anymore nor is xine. Did speaker-test again and there is
> sound.

> Maybe loading X activated something in nvidia driver which activated
> then audio to, and even after stoping X, that audio thing is still
> activated and can be used??

Yes absolutely; X running is required for HDMI audio to work.

The fact that it appears to still work after X is stopped is a fluke,
and may or may not always be the case. You shouldn't rely on this.

> (1) X -nocursor -br -quiet -dpms -allowMouseOpenFail -ac -audit 0&
> (2) xine --no-gui --no-logo --no-splash --deinterlace -pq -f -A alsa
> -V vpdau --post vdr --post vdr_audio --post vdr_video --post
> tvtime:method=use_vo_driver netvdr:/127.0.0.1
> --config=/var/lib/vdr/.xine/config

...
> > That's odd. I don't understand why running xine first would help.

[well, it turns out it wasn't running xine, but X, that fixes this]

> > Perhaps you could try compiling the very latest ALSA kernel driver code,
> > and seeing if that makes any difference? Recently, some changes were made
> > in the way the HDMI audio infoframes get set up for the chipset you're
> > using.
> 
> I will try to compile latest ALSA kernel driver code, and will let you

There's no need now; everything is explained by X not being active.

-- 
nvpublic
