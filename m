From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Fri, 10 Jul 2015 15:49:47 +0800
Message-ID: <CAN8cciZG+ZmSzVh4v2giQh4vnJ1a7dbYvY6zcfeuQy0ephWUww@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
 <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
 <CALUcmUmR3XCaQFjEbPtsPYS6QcRdkWFdtry+x3uWP7qLE07ePg@mail.gmail.com>
 <CAN8cciZ6GAWoad8OMzJOFzUwAQkjJAUS86NV3EbJNpvC3WhPow@mail.gmail.com>
 <CALUcmUk6niiT2aU2e4FcPDk_rxOf54F-g10ePCjgTQg38zuP6g@mail.gmail.com>
 <CAN8cciajhQsvasRPJuBGp9Hsj5vaiaczczDPAz5dR03UAad2Sg@mail.gmail.com>
 <CALUcmU=vP4B=agrO6XDhsPiPOTCnqudtNsT0W49YheHn9ypzDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CDDB260499
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 09:49:50 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so206124294oiy.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 00:49:48 -0700 (PDT)
In-Reply-To: <CALUcmU=vP4B=agrO6XDhsPiPOTCnqudtNsT0W49YheHn9ypzDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>, lukasz.wojnilowicz@gmail.com
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> First I think I am going to split this mail into two topics, starting
with the easiest one, the External Base speaker.
>
> The code above added two new options: Surround 2.1 and Surround 4.0.
> After plugging in the base speaker:
>
> - The Base speaker plays without this code (but the previous code was
necessary) on the Speakers.
> - The Base speaker does not play on Surround 2.1
> - The Base speaker does play on Surround 4.0
> - The Base speaker does not switch automatically to any Surround when
plugged in.

How do you test ? Using sound preference or alsa speaker-test

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=8e38395360844806041ea69ab9690f5f174bc40c

Seem pulseaudio bug since driver only define stereo and 2.1 channel map
and  there is no surround 4.0 channel map

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=48f1b308cc66152eb6db66742dd0d08d888cda8d;hp=5c4cd46810cef8850b037fca9e38ffd43b0bff22

+       ttable.0.FL 1
+       ttable.1.FR 1
+       ttable.2.LFE 1

surround21 is supposed to be also used on 5.1 speaker since it only check

Do you mean it only work on 5.1 speaker since there are three combination
of 2.1 chmap ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound?id=ee81abb623cb5e03c182d16871bb4fb34fdc9b4f

1) hda default 2.1

{ .channels = 4,
  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
   SNDRV_CHMAP_LFE , SNDRV_CHMAP_LFE } },
{ }

2) acer aspire /* LFE only on left */

{ .channels = 4,
  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
   SNDRV_CHMAP_LFE, SNDRV_CHMAP_NA} }, /* LFE only on left */
{ }

3) LFE only on right on asus latop external sonic master subwoofer
{ .channels = 4,
  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
   SNDRV_CHMAP_NA, SNDRV_CHMAP_LFE } }, /* LFE only on right */
{ }

speaker-test  don't check channel map

Those asus n series laptop with alc663 seem use  node 0x1e to for the
detection of external subwoofer but node 0x1e pincap does not support
detect and unsol event

This mean those subwoofer need to use __snd_hda_jack_add_kctl() which does
not check pincap and unsol event

This require change of __snd_hda_jack_add_kctl() by adding new parameter
sense_nid to use another nid for jack sense without enable unsol event

However there is bug in hda_jack implementation , snd_hda_jack_detect() can
be called in patch_realtek.c before creation of the jacktbl entry (i.e.
before snd_hda_jack_add_kctls()

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1040873/comments/115

Did you found the message  " lfe filter activated (LR4 type)" in pulseaudio
verbose log ?
