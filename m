From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Nvidia HDMI and four codecs
Date: Tue, 1 Feb 2011 08:36:04 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E418@HQMAIL01.nvidia.com>
References: <4D47BFEB.8040602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 570B22413A
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 17:36:09 +0100 (CET)
In-Reply-To: <4D47BFEB.8040602@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Tuesday, February 01, 2011 1:10 AM:
> I've seen a few Nvidia HDMI's recently which have four HDMI codecs
> connected to the same HDA controller.

This is the case for any NVIDIA GPU that supports HDA, and also our most
recent chipset.

> The problem is that we don't know
> which one(s) of these four that is the real one. So people will have to
> try devices "hdmi:Nvidia,0", "hdmi:Nvidia,1", "hdmi:Nvidia,2" and
> "hdmi:Nvidia,3" to figure out which one is the right one. (And by
> empirical testing we know that it isn't always the first one.)

/proc/asound/card<n>/eld* will tell you which one to use; the ELD file
numbering should match the hdmi: device numbering.

eld 0,1,2,3 also match hw:$card:$device with device=3,7,8,9.

I do have an audio document that's aimed at technical end-users to explain
all of this. However, I haven't quite finished it, and issues with the
publication mechanism have stopped me publishing it so far.
 
> Thinking PulseAudio and/or "Just Works", this is not good enough, so is
> there a way to know beforehand which one of these four that is actually
> physically connected?

I don't believe it's possible to determine which of the codecs are physically
connected to actual connectors on the graphics board. This would be a static
facet of the board design.

Beyond that, the ELD files will indicate which codecs/pins are routed to a
connector with an audio-capable display attached and that X is actually
sending a signal to. This can dynamically change as the X server is
reconfigured, either when X restarts, or dynamically through our management
protocol or application.

> I'd love BIOS to provide a good codec probe mask, a pin config default,
> or something similar, but given a codec-proc I can't see any difference
> between the real ones and the unconnected ones, so I don't know how to
> fix up the driver without hardcoding/quirking every one of them. Any
> hints?

ALSA now exposes a logical device (hdmi:Nvidia,n) for each pin complex[1]
(equivalently each codec since there's a 1:1 mapping in our GPUs right now).
However, PulseAudio still only offers the user the first of these devices,
thus causing users to resort to probe masks to select which ALSA device they
wish to use.

If PulseAudio were to offer all HDMI devices in its UI, at least the user
Could configure their system using the regular GUI tools. I did suggest this
on the PulseAudio list, and I think the maintainers agreed this would be a
good idea in principle. However, I haven't taken the time to drive this.

http://www.mail-archive.com/pulseaudio-discuss@mail.0pointer.de/msg07433.html

[1] Concentrating abstractions on pin complexes rather than codecs will
ensure ALSA etc. are more ready for other codec/converter/pin
combinations that may be seen on other or future GPUs.

-- 
nvpublic
