From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Fri, 3 Jul 2015 00:34:25 +0800
Message-ID: <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DEF26068D
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 18:34:27 +0200 (CEST)
Received: by obbkm3 with SMTP id km3so53146188obb.1
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2015 09:34:25 -0700 (PDT)
In-Reply-To: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> While being in the process of making my audio work on my new notebook, I
> noticed that the audio hardware is partially working
> out-of-the-Linux-kernel-box v4.0.7 Arch. The following two things seem not
> to work.
>
> --------------------------------
> 1. External base speaker
> --------------------------------
>
> The Asus N751JK notebook (ALC668) has a small external 'base' speaker
(jack
> 2,5mm 4 rings), which I only can get to work with the help of
hdajackretask
> with the following setting:
>
> * Override unconnected pin 0x1a and connect it to Internal Speaker (LFE).

Can the external subwoofer be detected by any pin complex jack sense  when
plug and unplugged ?

hdajacksensetest -a

Since you are not always carry the external subwoofer and  can save  cpu
power not to perform lfe filtering when subwoofer is not plugged

>
> In the sound kernel tree I have noticed PCI ID fixes which are more or
less
> equal to this situation.
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/hda/patch_realtek.c
>
> This SND_PCI_QUIRK definition looks a lot like it:
> SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A),
>
> The Vendor/PCI ID is different for this laptop and I guess a new line
> should be added something like this:
> SND_PCI_QUIRK(0x1043, 0x17bd, "Asus N751JK", ALC662_FIXUP_BASS_1A),
>
> --------------------------------
> 2. External microphone
> --------------------------------
>
> The Asus N751JK notebook (ALC668) has a 3,5mm 4-ring combo jack for
> headphones and microphone.
> The headphone is detected correct and auto-mute works good (jack
detection).
> The microphone is not detected and does not work.
>
> I was unable to get it to work with hdajackretask or any of the Asus model
> settings, such as:
> * options snd_hda_intel model=,asus-mode4
>
> I was able to get the microphone to work with the following setting:
> * options snd_hda_intel model=,dell-headset-multi
>
> This setting creates two new items in PulseAudio making a total of three:
> * Internal microphone (works out of the box)
> * Headset microphone (works indeed with a headset)
> * Microphone (don't know if this works, since I don't have a single
> microphone, but it does not work with the headset)

Seem user manual mention external mic is supported

If codec cannot differentitate headphone, headset or mic, you need manually
switch the role of the combo jack from default headphone to headset
everytime when you plugged your headset

http://voices.canonical.com/david.henningsson/2014/03/07/headset-jacks-on-newer-laptops/

Can user giveup some combo jack capability (remove the support of headphone
and mic jack and only support headset ) by early patching to reenable auto
mic selection ?

>
> Unfortunately the auto-input-device-switch to the Headset microphone does
> not seem to work.
> When I plugin a headset, the headphones get detected and the Internal
> speakers are muted.
> The Input device does not automatically switch from Internal microphone to
> Headset microphone.
> I have to do this manually, after which it works.
> I don't know if the microphone has a jack detection.
> If it does not, maybe it is possible to use the headphones jack detection?
>
> I have added the alsa-info without any snd_intel / alsa modifications
here:
> http://www.alsa-project.org/db/?f=0b5135bd12f28bb5cb182f83bfa21bc50022faa6
>
> I don't mind to help to test, for example module options, patches and/or
> compile kernels.
>
