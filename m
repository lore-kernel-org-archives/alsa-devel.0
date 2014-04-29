From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Wed, 30 Apr 2014 00:01:10 +0800
Message-ID: <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
 <535E908C.4030509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A6732260309
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 18:01:11 +0200 (CEST)
Received: by mail-qg0-f54.google.com with SMTP id q107so462027qgd.13
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 09:01:10 -0700 (PDT)
In-Reply-To: <535E908C.4030509@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
>
> On most sound cards, PulseAudio uses timer-based scheduling and thus is
not subject to any period-size limitations. As far as I can see, snd_ymfpci
does not include SNDRV_PCM_INFO_BATCH, and thus will be used in this mode.
In addition, it has an implementation of snd_ymfpci_playback_pointer that
seems to look at the hardware, which is good. So effective period times
less than 5 ms should work on this card.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/?qt=grep&q=period+wakeup

Is there any reason to use timer scheduling for the sound card which cannot
disable period wake up ?

The sound cards are still wake up by period and the timer

As the DSP of ymfpci can mix up to 32 voices of different sample rate,
mono/stereo , u8/s16 .

The driver just setup the card's timer to increase the fake hw_ptr  on 5ms
interval by (48000Hz * 5ms) 240 samples

Unlike most sound cards which  periods_min equal to 2,  the periods_min of
snd_ymfpci is 3

As the fake hw_ptr increase by 240 samples on 5 ms interval,  I  think it
is a bad idea to allow any application to perform rewind
