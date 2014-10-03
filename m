From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [BUG] Bad decibel data on C-Media USB sound card
Date: Fri, 3 Oct 2014 15:14:38 +0800
Message-ID: <CAN8ccibK2iJKboUc1wViJEW2VeMoPOemOrT6bNgbudJbJKUH5Q@mail.gmail.com>
References: <CAPMSj_H=voAxLzACtVkAzVxsA_QQf0rSE3qSjGVqTUO9c7d-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 44683260415
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 09:14:39 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id j7so528293qaq.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Oct 2014 00:14:38 -0700 (PDT)
In-Reply-To: <CAPMSj_H=voAxLzACtVkAzVxsA_QQf0rSE3qSjGVqTUO9c7d-=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Allen M." <ase1592@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> >Does this number of steps remain the same when your starting volume are
not at 151?
> >Your value 77 seem quite different from  alsamixertest
>
> recording a sine wave with an amplitude of 1 in Audacity at step 151
shows that the recorded
> value is amplitude 0.885. Does this indicates some loss? The loopback
cable I am using
> is 2 meters in length, is the resistance of the cable is too high?

Did you use mono or stereo in playback and capture?

Did your capture volume /boost set to 0dB?

Do your sound card support the sampling rate ?

It depends on frequency of sine wave, sampling rate, playback gain/atten
capture gain/atten

http://wiki.linuxaudio.org/apps/all/jaaa

Do the frequency response of your card look like a straight line at 0dB
similar to those cards loopback test ?

http://audio.rightmark.org/test_results.shtml

Refer to the datasheet and your alsamixertest result , the card seem not
has fixed gain for each step

> >You many need to change the name of the volume control to headphone
> >playback volume in alsamixertest
> > Done. alsamixertest output:http://ix.io/ezd

Are you using version 48.11?

Seem alsamixertest is not suitable for testing volume control with less
than 1dB per step or variable dB per step
