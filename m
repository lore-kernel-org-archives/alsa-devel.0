From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Nvidia HDMI and four codecs
Date: Fri, 4 Feb 2011 15:25:20 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F5FB7D@HQMAIL01.nvidia.com>
References: <4D47BFEB.8040602@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E418@HQMAIL01.nvidia.com>
	<4D490FDE.9070900@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E9DE@HQMAIL01.nvidia.com>
	<4D4BAA76.20303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 458C3103B54
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2011 00:25:26 +0100 (CET)
In-Reply-To: <4D4BAA76.20303@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Wednesday, February 02, 2011 1:04 AM:
> As for PulseAudio, showing four HDMI devices is quite simple [1] but I
> still think it would be a little confusing to show four devices to
> choose from and would wish for something more intuitive.
> ...
> [1] I haven't tested it, but I guess the following addition to
> /usr/shared/pulseaudio/alsa-mixer/profile-sets/default.conf should do it:
>
> [Mapping hdmi-stereo-extra1]
> description = HDMI out extra 1
> device-strings = hdmi:%f,1
> channel-map = left,right
> priority = 2
> direction = output
>
> [Mapping hdmi-stereo-extra2]
> description = HDMI out extra 2
> device-strings = hdmi:%f,2
> channel-map = left,right
> priority = 2
> direction = output
>
> [Mapping hdmi-stereo-extra3]
> description = HDMI out extra 3
> device-strings = hdmi:%f,3
> channel-map = left,right
> priority = 2
> direction = output

This kinda works, but is pretty broken.

I tested on:
* Ubuntu Lucid with all updates
* Your audio PPA, so the latest ALSA kernel driver
* alsa-lib 1.0.24.1

I tested earlier on Karmic too, and saw the same behavior. Unfortunately,
Maverick is having issues on my test machine, so I didn't test it.

When I log in, there is only 1 display by default, and hence only one pin
complex with valid ELD information (eld#0.0 in my case).

In the Gnome volume applet, Hardware tab, I do see those extra sinks show
up. However, as soon as I select one of the new extra options, the entry on
the Output tab for the GPU gets removed, so I can't actually route audio
over HDMI anymore.

pavucontrol is similar; the Configuration tab shows the new profile, but the
Output Devices tab doesn't show any entry for the GPU.

Now, if I use nvidia-settings to light up another display, in TwinView
mode, there are now two pin complexes with valid ELD information (eld#0.0
and eld#3.0 in my case).

There is no immediate change to the Gnome volume applet or pavucontrol.

However, if I kill the PulseAudio daemon, and let it restart, then both
the Gnome volume applet and pavucontrol start behaving more as expected; I
can use either to change the GPU's profile selection, and audio will get
moved between the two monitors, or /dev/null if I select a non-connected
profile.

I assume this is an issue within PulseAudio. Unfortunately, I doubt I'll
be able to find time to look into this in detail.

--
nvpublic
