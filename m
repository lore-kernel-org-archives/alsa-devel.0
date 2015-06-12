From: Arun Raghavan <arun@accosted.net>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Fri, 12 Jun 2015 18:02:00 +0530
Message-ID: <CACuU-+gmSj7rw8h6scpokXgMrL8QFr8a+xt2hH-4yLy=3POc5A@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A0B326681B
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:32:22 +0200 (CEST)
Received: by ykfl8 with SMTP id l8so16752089ykf.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 05:32:20 -0700 (PDT)
In-Reply-To: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 12 June 2015 at 17:59, Arun Raghavan <arun@accosted.net> wrote:
> Hi folks,
> I'd like to bring this one up again, since we are currently in the
> sub-optimal position of forcing ~100 ms latency on USB devices. The
> original thread is here --
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html

While we sort this out, though, is there an upper bound on the USB
transfer size (that we could then use a rewind safety margin)? We
might be able to use this as a workaround till this can be fixed
properly.

-- Arun
