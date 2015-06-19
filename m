From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Fri, 19 Jun 2015 09:17:08 +0800
Message-ID: <CAN8cciaFQ-fRi1RL-1pL3CBjxjvekFs6eU=n7xpinpxJBo8Zog@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
 <55812F5C.8010502@metafoo.de> <s5h4mm68zfm.wl-tiwai@suse.de>
 <55818DB5.6050007@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E3190260493
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 03:17:09 +0200 (CEST)
Received: by oigb199 with SMTP id b199so28440862oig.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 18:17:08 -0700 (PDT)
In-Reply-To: <55818DB5.6050007@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

> Hmm...I was trying to understand this power save argument. I tried to
figure out a "typical" URB size by just plugging my headset in, and I saw
wMaxPacketSize being 96 and/or 192 bytes.
> Then, MAX_PACKS is set to either 6 (or 48 for USB 2.0 devices, but this
is just a headset).
>
> Can this be correct? Does it mean that we are getting interrupts every
192 * 6 bytes (i e, every 6 ms for a 48kHz/stereo/16bit stream)?
>
>

Do this mean that the driver report exact one period only when period size
is multiple of wMaxPackerSize ?

Using other period size give bad result , the driver use variable  period
size

hw_ptr does not always at period boundary , seem more like DSP_CAP_BATCH

>From the result , minimum and maximum time difference bewteen hw_ptr change
can varies from 20% to 400%
