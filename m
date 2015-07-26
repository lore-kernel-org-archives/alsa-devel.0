From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Sun, 26 Jul 2015 09:28:32 +0800
Message-ID: <CAN8cciYszj_vC+g-O_KzDkhXSu81+dkk=gEZ-vJvXP6eVYJJ1Q@mail.gmail.com>
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
 <CALUcmUmCuj-BHWyW3rZk+iEk8Y6irq-oGT0vVU0Xcrno4hDCtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0032612DF
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 03:28:33 +0200 (CEST)
Received: by oibn4 with SMTP id n4so36233334oib.3
 for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2015 18:28:32 -0700 (PDT)
In-Reply-To: <CALUcmUmCuj-BHWyW3rZk+iEk8Y6irq-oGT0vVU0Xcrno4hDCtA@mail.gmail.com>
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
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> Alsa-info patched kernel:
http://www.alsa-project.org/db/?f=cd23a3f0bb72e38d73224620e3e8ab57a73aa441

Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Bass Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Surround Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 3
     0x0c 0x0d* 0x0e

"Speaker Surround Jack" should return true when you plugged the external
subwoofer as you didn't change the name of the jack detect kctl

>
> Chmap results:
>
> Type = FIXED, Channels = 2
>   FL FR
> Type = FIXED, Channels = 4
>   FL FR NA LFE
>
> When unplugging the subwoofer, then chmap gives this and stays like this.
>
> Cannot open PCM stream hw:1 for PLAYBACK
>
> [Pavucontrol] -> [Configuration] -> [Built-in Audio] gives
>
> Analog Stereo Duplex
> Analog Stereo Output
> Analog Surround 2.1 Output + Analog Stereo Input
> Analog Surround 2.1 Output
> Analog Surround 4.0 Output + Analog Stereo Input
> Analog Surround 4.0 Output
> Analog Stereo Input
> Off
>
> Pulseaudio verbose log while plugging in the subwoofer:
http://pastebin.com/Ya5u1qz6

Seem not probe surround21 profile
