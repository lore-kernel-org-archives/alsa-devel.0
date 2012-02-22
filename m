From: Stephen Warren <swarren@nvidia.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Wed, 22 Feb 2012 08:45:44 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id E9E67245B1
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 17:45:56 +0100 (CET)
In-Reply-To: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
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
To: Andres Cimmarusti <acimmarusti@gmail.com>, "David Henningsson
	(david.henningsson@canonical.com)" <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>
List-Id: alsa-devel@alsa-project.org

Andres Cimmarusti wrote at Tuesday, February 21, 2012 11:44 PM:
...
> Unfortunately with kernel 3.2.x and 3.1.x I get no sound out choosing the same
> configuration in pulseaudio. Device is advertised correctly but
> there's a bizarre multiplicity advertised:
> 
> $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC269VB Analog [ALC269VB Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 8: HDMI 2 [HDMI 2]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> Using aplay with device 3 says device is busy.

pulseaudio probably has that device open, hence aplay can't open it
again. To validate this, run the following:

pasuspender bash

Then, run your aplay within that bash. At least aplay should run now,
even if you still can't hear audio; it's possible you don't (or can't)
have anything hooked up to that audio output

> Device 7 works
> correctly (but is not available in pulseaudio unless forced by
> default, which then renders internal speakers disabled)

There are ways to configure pulseaudio to allow the user to select which
PCM device to use on a given sound card. David Henningsson made this work
for NVIDIA GPUs at least in Ubuntu, and I imagine the same technique
could be applied to Intel devices too.

In the meantime, the WAR that Takashi mentioned in his response sounds
like it'd work very well, albeit it's a bit manual to set up.

> and device 8 produces no sound out.

It's plausible that isn't connected, or is connected to a graphics port
you simply don't have hooked up to a monitor or audio-capable monitor.

As Takashi mentions, from a kernel perspective, this isn't really a
regression at all, but simply exposing all the features of the HW that
were previously hidden. Without that change, others can't use some HW
usefully at all. Unfortunately, pulseaudio makes some rather simplistic
assumptions about how HW works by default, and can be confused by the
additional features that are exposed.

Sorry this caused problems for you.

-- 
nvpublic
