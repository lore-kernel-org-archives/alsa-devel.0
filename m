From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Sun, 26 Jul 2015 13:55:31 +0200
Message-ID: <CALUcmU=fh2O+8COLPv1GXneomk2=XS_ES+LDK8yoqaEWXDrszQ@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
 <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
 <CALUcmUmR3XCaQFjEbPtsPYS6QcRdkWFdtry+x3uWP7qLE07ePg@mail.gmail.com>
 <CAN8cciZ6GAWoad8OMzJOFzUwAQkjJAUS86NV3EbJNpvC3WhPow@mail.gmail.com>
 <CALUcmUk6niiT2aU2e4FcPDk_rxOf54F-g10ePCjgTQg38zuP6g@mail.gmail.com>
 <CAN8cciajhQsvasRPJuBGp9Hsj5vaiaczczDPAz5dR03UAad2Sg@mail.gmail.com>
 <CALUcmU=vP4B=agrO6XDhsPiPOTCnqudtNsT0W49YheHn9ypzDg@mail.gmail.com>
 <CAN8cciZG+ZmSzVh4v2giQh4vnJ1a7dbYvY6zcfeuQy0ephWUww@mail.gmail.com>
 <CALUcmUmdhehmMZZykw0SLsKRbswOq=mti6hfgGZrTryDtKc7MA@mail.gmail.com>
 <CAN8cciaGZkrHOsD7KDX7sfXTRdJEVwwGLi-G+XcwHUxeGsAVDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5C32614C8
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 13:55:52 +0200 (CEST)
Received: by oihq81 with SMTP id q81so39383586oih.2
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 04:55:51 -0700 (PDT)
In-Reply-To: <CAN8cciaGZkrHOsD7KDX7sfXTRdJEVwwGLi-G+XcwHUxeGsAVDw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

I have to apologize.

When you said Pulseaudio might have a bug, I rechecked my steps and I
believe I had only applied half of your patches.
I have applied all the patches this time, against the 4.2.0-rc3 kernel and
posted the requested info again.

alsa-info:
http://www.alsa-project.org/db/?f=ab56d544c53402fc7fdb96956299753de2708a6f

chmap-result (stable, does not change after plugging or unplugging jacks):

Type = FIXED, Channels = 2
  FL FR
Type = FIXED, Channels = 4
  FL FR NA LFE

[Pavucontrol] -> [Configuration] -> [Built-in Audio] gives

Analog Stereo Duplex
Analog Stereo Output
Analog Surround 2.1 Output + Analog Stereo Input
Analog Surround 2.1 Output
Analog Surround 4.0 Output + Analog Stereo Input
Analog Surround 4.0 Output
Analog Stereo Input
Off

Pulseaudio verbose log: http://pastebin.com/MwC3KQS5

Pulseaudio log is created by the following steps:

1. echo autospawn = no >> ~/.config/pulse/client.conf
2. killall pulseaudio
3. LANG=C pulseaudio -vvvv --log-time=1 > ~/pulseverbose.log 2>&1
4. Wait a couple of seconds
5. Plugin jack external subwoofer
6. Plugin jack headset
7. Press CTRL-C

Are the results the same, or is there more hope this time? :-)

On 13 July 2015 at 13:24, Raymond Yau <superquad.vortex2@gmail.com> wrote:

>
> >
> > Honestly some of the Alsa code talk is a bit over my head, so maybe I
> should just stick to providing PCI/Vendor ID's and test results. :)
> >
> > RY> How do you test ? Using sound preference or alsa speaker-test
> >
> > I apply some of your code by retyping this into the mainline kernel
> 4.2-rc1 code, compile and install the kernel, and then test the audio.
> > The subwoofer I test by playing music with my music player, Audacious.
> > When testing different configurations and output profiles I use
> pavucontrol.
> > For testing the microphone, I open pavucontrol, switch the input source
> between Internal Microphone and Microphone and look at the volumebar to see
> if the microphone works fine.
> >
> > Do you have suggestions how to apply and test the provided patches?
> >
>
> you have to provide alsa-info of patched driver
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/chmap.c;hb=HEAD
>
> ./chmap -Dhw:0 query
>
> Do chmap show the stereo and 2.1 channel map ?
>
> the "External Subwoofer Jack" detect kctl should return true when you plug
> the Sonic Master Subwoofer and false when you unplug
>
> after you add analog-output-subwoofer.conf and replace the output path
> analog-output-lineout and analog-output-speaker in 2.1 profiles in
> profile-sets/default.conf
>
> You have to provide pulseaudio verbsose log if pulseaudio did not
> automatically switch to 2.1 profile
>
> The dirty workaround for the headset mic when your codec cannot
> distinguish headphone and headset but you use only headset
>
> Change the headset.conf to use jsck headphone instead of headset mic jack
>
>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa/mixer/paths/analog-input-headset-mic.conf
>
> -[Jack Headset Mic]
> -required-any = any
>
> -[Jack Headset Mic Phantom]
> -state.plugged = unknown
> -state.unplugged = unknown
> -required-any = any
>
> [Jack Headphone]
> -state.plugged = unknown
> +required-any = any
>
>
>
>
>


-- 
Arthur Borsboom
Lieven de Keystraat 77
3067 KG, Rotterdam
The Netherlands
Mob: +31629089953
Email: arthurborsboom@gmail.com
Skype: Arthur Borsboom, The Hague, The Netherlands

[image: View Arthur's LinkedIn profile]
<http://uk.linkedin.com/in/arthurborsboom>
