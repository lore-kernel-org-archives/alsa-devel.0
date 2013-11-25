From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 25 Nov 2013 23:07:09 +0800
Message-ID: <CAN8cciacG0fUyEuSOMF2iXp8CUzqyTAPDNpK1q6Lu0u+gtV6zQ@mail.gmail.com>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id B374C261A8F
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 16:07:10 +0100 (CET)
Received: by mail-ie0-f176.google.com with SMTP id at1so7164098iec.35
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 07:07:09 -0800 (PST)
In-Reply-To: <loom.20131122T215246-90@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> I have a Radeon 4670 (Sapphire
> branded) connected to a Yamaha RX-V773. I am running the sound/for-next
> kernel (82755ab) with your "missing PCM SAD" patch applied.
>
> The new kernel has allowed ALSA to recognise the card as multichannel and
I
> can issue the following speaker-test command but I still only hear "Front
> Left" and "Front Right" and the Yahama seems to report the signal as
stereo.
>
> # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav

Why do you use -c6 when your HDMI codec only support stereo

Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
   Converter: stream=1, channel=0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital

>
> I'm guessing the codec file may provide some useful information.
>
> /proc/asound/HDMI/codec#0:
> Codec: ATI R6xx HDMI
> Address: 0
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x1002aa01
> Subsystem Id: 0x00aa0100
> Revision Id: 0x100100
> No Modem Function Group found
> Default PCM:
>     rates [0x70]: 32000 44100 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D3
>   Power: setting=D0, actual=D0
> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
> Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
>   Converter: stream=1, channel=0
>   Digital: Enabled
>   Digital category: 0x0
>   IEC Coding Type: 0x0
> Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
>   Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
>   Control: name="IEC958 Playback Con Mask", index=0, device=0
>   Control: name="IEC958 Playback Pro Mask", index=0, device=0
>   Control: name="IEC958 Playback Default", index=0, device=0
>   Control: name="IEC958 Playback Switch", index=0, device=0
>   Control: name="ELD", index=0, device=3
>   Pincap 0x00000094: OUT Detect HDMI
>   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=01, enabled=1
>   Connection: 1
>      0x02
>
