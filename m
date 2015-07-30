From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Thu, 30 Jul 2015 11:05:40 +0800
Message-ID: <CAN8cciYzDD1+MoDO+=P5Wt3xTU+m8MSQ+hVZOxXab-LooZ9ajw@mail.gmail.com>
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
 <CALUcmU=fh2O+8COLPv1GXneomk2=XS_ES+LDK8yoqaEWXDrszQ@mail.gmail.com>
 <CAN8ccibYUjoDUe+UhNesjEpD1t2rRg8TUbmtr-3kZuMGDXMoMA@mail.gmail.com>
 <CALUcmUn31z0g5R9s8rDbJCzHtvL9nqFeFWaHSG=DBBXTo3YkRg@mail.gmail.com>
 <CAN8cciawckV75ZoRRCYyaF_h1WNvDqLqtYw8puKu2FoXS-=8RA@mail.gmail.com>
 <CALUcmUnhWJQL6TyQMsMEF9W03MitBVtRhAm-ROKO+jbgxKX6vA@mail.gmail.com>
 <CAN8cciaZAv2sNOpsLvEAih1h34QGyVh9s4LByPzMWa+Y3iwPSg@mail.gmail.com>
 <CALUcmUnsMhwpRfWqak-bfoKvAXCLjY-59MZONLx7YC-B+9MqaQ@mail.gmail.com>
 <CAN8cciaXsrrd6oZbywz6Db2AZmuxkDTtwn2_t6s3Bor+R7bVng@mail.gmail.com>
 <CALUcmUk_D30V29YM3gHCXbC3zqiHwBKmGziJA8DkEDojQM8mLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 731EB260687
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 05:05:41 +0200 (CEST)
Received: by obdeg2 with SMTP id eg2so21814266obd.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 20:05:40 -0700 (PDT)
In-Reply-To: <CALUcmUk_D30V29YM3gHCXbC3zqiHwBKmGziJA8DkEDojQM8mLA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> "... after you replaced speakers.conf and lineout.conf by subwoofer.conf
..."
>
> I must have missed something again. I was under the impression that
changing the configuration files was a workaround when the patch would be
insufficient. Later today or tomorrow, I will reread this part and apply
changes to the configuration files and report back.

  Ports:
                analog-output-speaker: Speakers (priority: 10000)
                analog-output-headphones: Headphones (priority: 9000, not
available)
        Active Port: analog-output-speaker


When you select model=dell-headset-multi, the driver create "Headphone Mic
Jack" kctl with type 1 which is SND_JACK_HEADPHONE

type 2 is SND_JACK_MICROPHONE

type 3 is SND_JACK_HEADSET but hda jack does not use this type

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/sound/jack.h

JACK created Headphone Mic, type 1
CTRL: add: Headphone Mic Jack:0
JACK report Headphone Mic, status 0
JACK created Headset Mic Phantom, type 2
CTRL: add: Headset Mic Phantom Jack:0
JACK report Headset Mic Phantom, status 2
CTL Notify: Headset Mic Phantom Jack:0, mask=1
JACK created Internal Mic Phantom, type 2
CTRL: add: Internal Mic Phantom Jack:0
JACK report Internal Mic Phantom, status 2
CTL Notify: Internal Mic Phantom Jack:0, mask=1
JACK created Speaker Front Phantom, type 4
CTRL: add: Speaker Front Phantom Jack:0
JACK report Speaker Front Phantom, status 4
CTL Notify: Speaker Front Phantom Jack:0, mask=1
JACK created External Subwoofer, type 4
CTRL: add: External Subwoofer Jack:0

The problem of hda jack kctls are those retaskable I/O jack controls

1) multi io jacks in those 3 stack desktop
2) headphone/mic jack in asus netbook
3) dell-headset-multi combo jack

the role of the jack in 1) change from input to output when "Channel mode"
change from "2ch" to "4ch" or "6ch"

the role of the jack in 2) and 3) change from Output to Input when "Capture
Source" change from Internal Mic/Headset Mic to Headphone Mic

In your case, Headphone Mic Jack kctl return the presence of HP jack except
when the combo jack is set to support conventional mic (i.e. when the
driver change pin ctl of hp pin node 0x15 to zero and set pin ctl of mic
pin to IN),

The driver already unmute the internal speaker when you change capture
source to Headphone Mic

The only point is whether pulseaudio still regard this Headphone Mic Jack
as the availability of the headphone port when the capture source is
Headphone Mic

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=ca4942e89cf462e5f8c36ca9b8b689879083af6b
