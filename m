From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Realtek ALC662 rev1 no sound over HDMI
Date: Mon, 27 Jun 2011 08:40:03 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EC259@HQMAIL01.nvidia.com>
References: <BANLkTim2NwanrTtgsYGwHjkyW34fiHuuBQ@mail.gmail.com>
	<s5hr56f3abz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F8252441A
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 17:40:12 +0200 (CEST)
In-Reply-To: <s5hr56f3abz.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, crow <crow@linux.org.ba>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Monday, June 27, 2011 3:14 AM:
> At Sun, 26 Jun 2011 18:45:30 +0200, crow wrote:
> >
> > I am trying to get sound working on kernel 2.6.39 (under archlinux
> > x86_64 bit distribution) over HDMI to my digital receiver but without
> > luck. Before this post i asked in #alsa for help, and everything we
> > tried over there didnt get the sound over HDMI.
> > I connected headphones to the green jack and ran speaker-test and
> > there is sound over jack, analog sound plays fine. But runing
> > alsamixer un-muting spdif/iec958/spdif (1) and trying to re run
> > speaker-test doesn't output sound over HDMI to my digital receiver.
> 
> Note that on your device HDMI goes through Nvidia HDMI codec, thus
> it's irrelevant with ALC262 at all.  The machine shows an SPDIF
> output connected to ALC262, but this must be different from the HDMI
> output.  So, the first SPDIF/IEC958 setup is also irrelevant.
> The second IEC958 setup is for HDMI.

Crow, you might find the following document helpful:

ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html

> > I tried to use /etc/asound.conf for global settings (tooked from
> > 2.6.35 archlinux i686 installation) but does not work with 2.6.39
> > installation, even I am not able to play analog sound:
> > speaker-test -c2 -twav -l1
> > This above works without asound.conf, and it plays analog sound on headphones.
> >
> > This is how i tried to play sound over HDMI:
> > speaker-test -c2 -D plughw:0,3 -twav -l1
> >
> > The above command does output sound on 2.6.35 (but just over Fron Right)
> 
> So, something was wrong even on 2.6.35?

Crow, please try a more default command:

speaker-test -c 2 -D hw:0,3

> > I run alsa-info.sh script on both installation and it can be found on
> > (2) kernel 2.6.39 and (3) kernel 2.6.35.
> >
> > I was hoping to get sound working with 2.6.39 (current official
> > archlinux kernel) over HDMI by just un-muting spdif with alsamixer,
> > but it seems not to be that easy.
> >
> > (1) http://www.abload.de/img/alsa01ji6j.png
> > (2) http://www.alsa-project.org/db/?f=7bf61ad34a4bb51b615773aab69ae904693a07d7
> > (3) http://www.alsa-project.org/db/?f=3694c9052c2b8f5d78f8a9e2a465a7c94885449b
> 
> It's Nvidia, so make sure that the video-driver side supports HDMI
> audio properly.  You can check /proc/asound/card0/eld#* file to see
> whether the monitor is properly detected and what ELD values are
> read.

ELD data isn't supported on the MCP7x chipset, so the ELD files won't
appear.

Crow, which NVIDIA video driver are you using? Can you please try
upgrading to the latest release from:

ftp://download.nvidia.com/XFree86/Linux-x86/275.09.07/

--
nvpublic
