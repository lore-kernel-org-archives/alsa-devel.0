From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Sat, 23 Nov 2013 03:29:28 +0200
Message-ID: <529004F8.7070801@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 504C12619D7
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 02:29:33 +0100 (CET)
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
To: James Le Cuirot <chewi@aura-online.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

23.11.2013 03:05, James Le Cuirot kirjoitti:
> Anssi Hannula <anssi.hannula <at> iki.fi> writes:
> 
>> Here's another revision of the ATI/AMD multichannel+HBR patchset.
> 
> Hi Anssi. Many thanks for your work on this. I am very keen to test this 
> new code but have so far been unsuccessful. I have a Radeon 4670 (Sapphire 
> branded) connected to a Yamaha RX-V773. I am running the sound/for-next 
> kernel (82755ab) with your "missing PCM SAD" patch applied.
> 
> The new kernel has allowed ALSA to recognise the card as multichannel and I 
> can issue the following speaker-test command but I still only hear "Front 
> Left" and "Front Right" and the Yahama seems to report the signal as stereo.
> 
> # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
> 
> speaker-test 1.0.27.2
> 
> Playback device is hdmi:CARD=HDMI,DEV=0
> Stream parameters are 48000Hz, S16_LE, 6 channels
> WAV file(s)
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 64 to 5440
> Period size range from 32 to 2720
> Using max buffer size 5440
> Periods = 4
> was set period_size = 1088
> was set buffer_size = 5440
>  0 - Front Left
>  4 - Center
>  1 - Front Right
>  3 - Rear Right
>  2 - Rear Left
>  5 - LFE

I guess it is the same without "-t wav"?

> I have tried various sample rates. I have the HDMI cable plugged into the 
> secondary output as my speakerless DVI monitor is plugged into the primary 
> but I have also tried the HDMI cable in the primary output by itself. I 
> even bought the "official" HIS HHDMI4071 adapter as the unbranded one that 
> came with my card looked quite different. None of these things have helped.

Hmm, I'm not sure what the behavior is supposed to be with multiple
video outputs when we have only a single audio output (HDA pin)...

What happens if you plug both of your outputs to the A/V receiver, will
only one output get audio?

In any case, I'd guess trying the HDMI cable by itself should've ruled
issues with that out...

> I must admit that I don't fully understand what this ELD stuff is about but 
> I can tell you that it's not looking too good on my system.
> 
> /proc/asound/HDMI/eld#0.0:
> monitor_present	    1
> eld_valid           0

ELD stuff is not necessary for playback, it is mostly for information
(and providing the necessary info for ELD is disabled on radeon DRI
drivers on some kernels on some GPUs ATM due to some issues).

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
> If it rules anything out, I have had the ALSA a52 plugin working but 
> obviously this isn't an ideal solution. Any help would be appreciated and 
> I'll gladly provide more information. I've done some light kernel hacking 
> but I'm no expert.

Is there anything interesting in "dmesg"?

-- 
Anssi Hannula
