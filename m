From: Arun Raghavan <arun@accosted.net>
Subject: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Fri, 12 Jun 2015 17:59:55 +0530
Message-ID: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f50.google.com (mail-yh0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 3187A2668DD
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:30:17 +0200 (CEST)
Received: by yhid80 with SMTP id d80so13310561yhi.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 05:30:16 -0700 (PDT)
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

Hi folks,
I'd like to bring this one up again, since we are currently in the
sub-optimal position of forcing ~100 ms latency on USB devices. The
original thread is here --
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html

I see two flags that are possibly of consequence here:
SNDRV_PCM_INFO_BATCH and SNDRV_PCM_INFO_BLOCK_TRANSFER. I'm not sure
what these mean -- the documentation mentions "double buffering" for
the batch flag, and just that the block transfer means "block
transfer". :-)

We've spoken about batch meaning either transfers in period size
chunks, or some fixed chunk size. It seems that it would make more
sense for it to mean the former, and block transfer to mean the
latter.

So I guess the first thing that would be nice to have is a clear
meaning of these two flags. With this done, we could potentially get
to the API to report the transfer size from the driver.

I did notice that there is a snd_pcm_hw_params_get_fifo_size(). Is
this something we could use for the purpose of transfer size
reporting, by any chance?

Cheers,
Arun
