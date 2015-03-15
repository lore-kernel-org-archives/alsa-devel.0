From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Sun, 15 Mar 2015 08:25:09 +0800
Message-ID: <CAN8ccia6RDXPJxbQoTCexoNAch3y29PjReQTsrPOG2LmJAeLbw@mail.gmail.com>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
 <54FC9CB0.2030003@ladisch.de>
 <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
 <CAN8cciZcnD4zPbL-jD8+t5AHaugWvbrbo33_iuVBktHnpKpRuw@mail.gmail.com>
 <CAHti5NEfeguhQTZANNg=QnBZXRjDJZV0DAd3H1i+p4nCsmkQmQ@mail.gmail.com>
 <CAN8cciaMGdGtqTJrHV8q1_5vgpM2qXRK7XRAdiiqR7SKhVCb8Q@mail.gmail.com>
 <CAHti5NGTMPUwQ-sczhoAQ09A94mheq3rHORCocZzy3WxQjL0gQ@mail.gmail.com>
 <CAN8ccibuXoLWHi7rZX8bSUHvE9wdGGXyFVRwovVLb7UOemZhUA@mail.gmail.com>
 <CAHti5NF8G7iArtC_cN_WA2EFRpwGe8rMmVRHvKtrKNHpuEK46A@mail.gmail.com>
 <CAN8ccibUrZVFk5P2rdHhMYznQ8M2WJkL-NTm7WxRY99bwDZZ2g@mail.gmail.com>
 <CAHti5NGuDA=A_-BF4-EXD07O+h-JGK085_hjsYDqxa6h7TMJyQ@mail.gmail.com>
 <CAN8cciYNonxGix1u=OfcfwL_K2p4kLd5qA2U5o2jRr1AnZaGeQ@mail.gmail.com>
 <CAHti5NHLVE-=XtM70+JwTZD-jADTj5kEkQVdQu0GXnjQhEdagQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DB3372606A8
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 01:25:10 +0100 (CET)
Received: by oiag65 with SMTP id g65so12721443oia.2
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2015 17:25:09 -0700 (PDT)
In-Reply-To: <CAHti5NHLVE-=XtM70+JwTZD-jADTj5kEkQVdQu0GXnjQhEdagQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel <dferradal@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>
>
> The device has 3 inputs as you will see in the picture I attach.
>
> Two analog inputs and 1 digital:
>
> * Analog micro
> * Analog headphones
> * USB input <-- This is how the headphones are plugged to have dolby
surround enabled and some of illuminations settings (the headphones can
have multiple illumination colors, I mention this as means to be able to
identify possible unknown switches the device may have).

Seem two inputs of Mixer Unit are USB streaming (Terminal 1) and
Microphone(Terminal 8),

output is Speaker (Terminal 3) through Feature Unit (UnitID 2) with
"Speaker Playback Volume"

This look like control in MU is "Microphone Playback Switch"

bDescriptorType 36
bDescriptorSubtype 2 (INPUT_TERMINAL)
bTerminalID 1
wTerminalType 0x0101 USB Streaming

bDescriptorType 36
bDescriptorSubtype 6 (FEATURE_UNIT)
bUnitID 2
bSourceID 10

bDescriptorType 36
bDescriptorSubtype 3 (OUTPUT_TERMINAL)
bTerminalID 3
wTerminalType 0x0301 Speaker
bAssocTerminal 0
bSourceID 2

bDescriptorType 36
bDescriptorSubtype 3 (OUTPUT_TERMINAL)
bTerminalID 4
wTerminalType 0x0101 USB Streaming

bDescriptorType 36
bDescriptorSubtype 5 (SELECTOR_UNIT)
bUnitID 5
bNrInPins 1
baSource( 0) 6

bDescriptorType 36
bDescriptorSubtype 6 (FEATURE_UNIT)
bUnitID 6
bSourceID 7

bDescriptorType 36
bDescriptorSubtype 2 (INPUT_TERMINAL)
bTerminalID 7
wTerminalType 0x0201 Microphone

bDescriptorType 36
bDescriptorSubtype 2 (INPUT_TERMINAL)
bTerminalID 8
wTerminalType 0x0201 Microphone

bDescriptorType 36
bDescriptorSubtype 6 (FEATURE_UNIT)
bUnitID 9
bSourceID 8

bDescriptorType 36
bDescriptorSubtype 4 (MIXER_UNIT) Warning: Descriptor too short
bUnitID 10
bNrInPins 2
baSourceID( 0) 9
baSourceID( 1) 1
