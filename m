From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Mon, 27 Jul 2015 13:08:52 +0200
Message-ID: <CALUcmUnhWJQL6TyQMsMEF9W03MitBVtRhAm-ROKO+jbgxKX6vA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A11482614CD
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 13:09:12 +0200 (CEST)
Received: by oihq81 with SMTP id q81so49468376oih.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 04:09:11 -0700 (PDT)
In-Reply-To: <CAN8cciawckV75ZoRRCYyaF_h1WNvDqLqtYw8puKu2FoXS-=8RA@mail.gmail.com>
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
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Alexander Patrakov <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

At this moment the headset works this way: I plugin the headset, I change
the input source from Internal Microphone to Microphone and I can start
using the headset. There is no popup.

The sub woofer works on Pulseaudio setting "Stereo" and "Surround 4.0", but
not on "Surround 2.1".

pactl list sinks: http://pastebin.com/uZH1nwtE

On 27 July 2015 at 11:08, Raymond Yau <superquad.vortex2@gmail.com> wrote:

>
> >
> > I shall file a bug against Pulseaudio with the subject.
> >
> > Pulseaudio enables Surround 4.0, while chmap reports no RL and RR.
> >
> > While waiting for the Pulseaudio result, do you think it is a good idea
> to send your Alsa patches upstream, so at least some of the functionality
> start working soon?
> > If so, do you guess this patch will be available in v4.2 or v4.3?
>
> Do dell-headset-multi really work as expected ?
>
>
> http://voices.canonical.com/david.henningsson/2014/03/07/headset-jacks-on-newer-laptops/
>
> Seem need popup dialog to set the combo jack type correctly when you are
> using headset or conventional mic
>
> Do "pactl list sinks" show the headphone port since your alsa-info did not
> have any Headphone Jack kctl ?
>
> Your pulseaudio log only have surround21 profile but no message about lfe
> filter enabled
>
>      pa_log_debug("  lfe filter activated (LR4 type)");
>
>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=979f19a434733afba0480e2ba456cccc98362e05
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
