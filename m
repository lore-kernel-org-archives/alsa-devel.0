From: Jerone Young <jerone.young@canonical.com>
Subject: Re: SPDIF out with HDA/Conexant 20561?
Date: Tue, 04 May 2010 21:14:13 -0700
Message-ID: <1273032853.1653.1333.camel@laptop>
References: <y2m6160a5131005041619wc625446dj652bc2f03c304118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A1724600
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 06:14:18 +0200 (CEST)
In-Reply-To: <y2m6160a5131005041619wc625446dj652bc2f03c304118@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Are you using the Thinkpad Docking station with the S/PDIF on the side?
The headphone jack on those doesn't have S/PDIF.

I have not been able to verify this so glad your email came.. but it
seems like the T400, T500, & W500 do not actually work with it.

Did you try under Windows & if so did it work?

				Thanks,
					Jerone

On Tue, 2010-05-04 at 18:19 -0500, pl bossart wrote:
> Has anyone had any luck enabling S/PDIF output with the Conexant 20561/ctx5051?
> 
> On my Lenovo W500 I see a digital output device, I can play on it but
> I can't hear any sound on my receiver. There was a patch by Takashi
> earlier this year to correct a wrong nodeID
> (03b515c45e2a93331d2ac9dc1c16440f7fa313ec, ALSA: hda - Fix SPDIF
> output widget for Cxt5051 codec), so I figure some amount of testing
> has been done already?
> 
> I wonder if this comes from a non-initialized pin configuration as
> reported in /proc/asound/card0/codec#0?
> Node 0x1c [Pin Complex] wcaps 0x400701: Stereo Digital
>   Pincap 0x00000010: OUT
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Power states:  D0 D1 D2 D3
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x12
> 
> Node 0x12 [Audio Output] wcaps 0x211: Stereo Digital
>   Control: name="IEC958 Playback Con Mask", index=0, device=0
>   Control: name="IEC958 Playback Pro Mask", index=0, device=0
>   Control: name="IEC958 Playback Default", index=0, device=0
>   Control: name="IEC958 Playback Switch", index=0, device=0
>   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
>   Device: name="Conexant Digital", type="SPDIF", device=1
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
> 
> 
> Thanks
> - Pierre
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
