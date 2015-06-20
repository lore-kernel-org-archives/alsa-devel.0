From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Sat, 20 Jun 2015 14:17:46 +0800
Message-ID: <CAN8ccibjbE=-Z+3Vwb0YOktiFyOXLPXRpzrNfxArt3CQdwOmsA@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
 <55812F5C.8010502@metafoo.de> <s5h4mm68zfm.wl-tiwai@suse.de>
 <55818DB5.6050007@canonical.com> <s5hmvzw9bn9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9EF26068A
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 08:17:47 +0200 (CEST)
Received: by obbsn1 with SMTP id sn1so86468837obb.1
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 23:17:46 -0700 (PDT)
In-Reply-To: <s5hmvzw9bn9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > Hmm...I was trying to understand this power save argument. I tried to
> > figure out a "typical" URB size by just plugging my headset in, and I
> > saw wMaxPacketSize being 96 and/or 192 bytes.
> > Then, MAX_PACKS is set to either 6 (or 48 for USB 2.0 devices, but this
> > is just a headset).
> >
> > Can this be correct? Does it mean that we are getting interrupts every
> > 192 * 6 bytes (i e, every 6 ms for a 48kHz/stereo/16bit stream)?
>
> The driver can build up a URB containing multiple packets, so the
> wakeups can be reduced in some level.  But, then the hwptr update also
> suffers, and more badly, the in-flight size also increases -- both are
> bad for sample mixing, obviously.
>
>
>

Do it mean that period_bytes_max is wMaxPacketSize * MAX_PACKS, driver only
support small period sizes ?
