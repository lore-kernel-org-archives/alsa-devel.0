From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Mon, 27 Apr 2015 17:34:59 +0900
Message-ID: <CAJ0eYfWCoqBBLdXpfitc1KZczZmPYXVy9n4-3YEU2Fw0sTRMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f52.google.com (mail-vn0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A7CCC2650E7
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 10:35:02 +0200 (CEST)
Received: by vnbg1 with SMTP id g1so10977243vnb.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 01:35:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yet another experiment.

Orpheus operation manual says there are six modes
concerning Sync Source.

--------------------------------------
Sync         Source Master/Slave    Description
--------------------------------------
Local        Master    System is sync'ed to Orpheus' local clock
Wordclock Master    System is sync'ed to external wordclock applied to
Orpheus
DI             Master    System is sync'ed to external S/PDIF applied to
Orpheus
ADAT        Master    System is sync'ed to external ADAT (ADAT input must
be enabled)
PC DAW    Slave      Orpheus is slaved to system clock from host PC
CSP          Master    System is sync'ed to Orpheus' 1394 clock (not
recommended)
--------------------------------------

With each of the five modes mentioned above (ADAT input not available),
I tried to play music on Windows 7 using Audacity.

The results are:

-------------------
Local        OK
Wordclock NG
DI             NG
PC DAW    OK
CSP          OK
-------------------

So it seems that if there is no external clock applied,
when one is expected, Orpheus stops playing rather than
trying to continue operation by free-running its clock.

***

Takashi Sakamoto wrote:

> Not funny, but headache. It's a customization by hardware vendor, I
> mentioned. (in this case, by PrismSound Ltd.)

> BridgeCo AG (currently ArchWave AG) produced DM1000/DM1100/DM1500
> chipset with BeBoB firmware. PrismSound Ltd. utilized the chipset and
> firmware for streaming functionality of your Orpheus.

> BeBoB firmware gives common ways to control itself, while the hadware
> vendor added their own cusomization against it. I don't know exactly the
> reason because there're few information about your device.

I do not think I understand what you said here due to the lack of technical
background, but what do you suggest at this moment to a casual applications
programmer who wish to use snd-bebob with Orpheus?

------------
Answer 1
------------
It should work. I received many successful reports for my final call for
testing last year.

It must be a hardware problem with your PC, or Firewire Cable, or Orpheus,
or all of them.

------------
Answer 2
------------
It should work. Check your software environment.
Freshly installed Ubuntu 14.10 or later with the kernel
3.16 or later may not work.

Always download the latest sources from GitHub, etc.

------------
Answer 3
------------
Forget about snd-bebob, and fallback to libffado+jackd.

The combination is loosing many packets, but if you say you do not
notice any glitches, you should be completely happy with it.

***

Regards,
Mike Ood
