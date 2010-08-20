From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: aplay -l vs. aplay -L: Missing PCMs?
Date: Fri, 20 Aug 2010 09:28:06 +0800
Message-ID: <AANLkTikdqWjE0AyAq5EE5+ousdXceYKuynPv2G6XLbBJ@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376614@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D97B243C8
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 03:28:07 +0200 (CEST)
Received: by eyd9 with SMTP id 9so1760191eyd.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 18:28:06 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE376614@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/20 Stephen Warren <swarren@nvidia.com>

> The Azalia controller on NVIDIA GPUs gives 4 ALSA hw devices:
>
> (on card 1):
>
> [swarren@swarren-lx2 ~]$ sudo aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 0: NVidia [HDA NVidia], device 3: ALC1200 Digital [ALC1200 Digital]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 7: NVIDIA HDMI [NVIDIA HDMI]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 8: NVIDIA HDMI [NVIDIA HDMI]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 9: NVIDIA HDMI [NVIDIA HDMI]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
>
> ... all of which appear to work OK.
>
> However, the list of available "PCMs" from aplay -L doesn't expose them
> all:
>
> [swarren@swarren-lx2 ~]$ sudo aplay -L
> front:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    Front speakers
> surround40:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    4.0 Surround output to Front and Rear speakers
> surround41:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Analog
>    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
> hdmi:CARD=NVidia,DEV=0
>    HDA NVidia, ALC1200 Digital
>    HDMI Audio Output
> null
>    Discard all samples (playback) or generate zero samples (capture)
> pulse
>    Playback/recording through the PulseAudio sound server
> hdmi:CARD=NVidia_1
>    HDA NVidia, NVIDIA HDMI
>    HDMI Audio Output
>
> Similarly, pulseaudio only shows one output for the GPU; I assume it uses
> the same enumeration mechanism for ALSA sinks as "aplay -L".
>

AFAIK , pulseaudio hardcoded the device name and you can see PA probe hdmi
even when the card is intel8x0  (e.g. using intel8x0 inside VirtualBox)


>
> Instead, I imagined that I'd see 4 PCMs listed by "aplay -L"; one for each
> converter. Is this an incorrect assumption? How would I make that happen?
>

Do you mean that you have 4 hdmi out on your motherboard ?
