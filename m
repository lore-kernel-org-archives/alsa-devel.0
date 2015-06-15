From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 15 Jun 2015 11:42:59 +0800
Message-ID: <CAN8ccia_Dy+WBD4NOi3ot4o9v0rbzG2CL3qEA+h1ZwQX_H5Ebw@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <CACuU-+gmSj7rw8h6scpokXgMrL8QFr8a+xt2hH-4yLy=3POc5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 91B4E26067A
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 05:43:00 +0200 (CEST)
Received: by oial131 with SMTP id l131so17635285oia.3
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 20:42:59 -0700 (PDT)
In-Reply-To: <CACuU-+gmSj7rw8h6scpokXgMrL8QFr8a+xt2hH-4yLy=3POc5A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@accosted.net>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > I'd like to bring this one up again, since we are currently in the
> > sub-optimal position of forcing ~100 ms latency on USB devices. The
> > original thread is here --
> >
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html
>
> While we sort this out, though, is there an upper bound on the USB
> transfer size (that we could then use a rewind safety margin)? We
> might be able to use this as a workaround till this can be fixed
> properly.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb?id=976b6c064a957445eb0573b270f2d0282630e9b9

Seem there are differences between high speed devices and others

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb?id=a93455e1c301ce2a4cae11682359fd2067a8fd30

Do usb wireless audio different from others ?
