From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Mon, 27 Jul 2015 20:59:59 +0800
Message-ID: <CAN8cciaZAv2sNOpsLvEAih1h34QGyVh9s4LByPzMWa+Y3iwPSg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7F72608BB
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 15:00:03 +0200 (CEST)
Received: by oibn4 with SMTP id n4so50553364oib.3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 06:00:00 -0700 (PDT)
In-Reply-To: <CALUcmUnhWJQL6TyQMsMEF9W03MitBVtRhAm-ROKO+jbgxKX6vA@mail.gmail.com>
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
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Alexander Patrakov <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> At this moment the headset works this way: I plugin the headset, I change
the input source from Internal Microphone to Microphone and I can start
using the headset. There is no popup.
>
> The sub woofer works on Pulseaudio setting "Stereo" and "Surround 4.0",
but not on "Surround 2.1".

Refer to your pulseaudio verbose log

(   6.509|   1.381) D: [pulseaudio] module-alsa-card.c: Jack 'Headphone Mic
Jack' is now plugged in
(   6.509|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-output-headphones to status yes

This look like pulseaudio use headphone mic jack to set the headphone to
available

(   6.509|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
Finding best profile
(   6.509|   0.000) D: [pulseaudio] module-switch-on-port-available.c: No
suitable profile found
(   6.509|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-input-headphone-mic to status unknown

(   6.509|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant
event due to change event.
(   6.509|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-input-headset-mic to status unknown

But I don't understand why pulseaudio set status of headphone mic and
headset mic to unknown

You did not use External Subwoofer Jack to change the status of external
subwoofer, there is no traces of external subwoofer jack in your log
