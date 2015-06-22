From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 10:35:40 +0800
Message-ID: <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C3FC261552
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 04:35:42 +0200 (CEST)
Received: by oigb199 with SMTP id b199so71025363oig.3
 for <alsa-devel@alsa-project.org>; Sun, 21 Jun 2015 19:35:41 -0700 (PDT)
In-Reply-To: <557EDE22.7080808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> DMA_RESIDUE_GRANULARITY_BURST means it can report the position with a
granularity of a few samples. Typically half the audio FIFO size.
>
>

How many soc driver/platform dma engine support
DMA_RESIDUE_GRANULARITY_BURST ?

Are all soc audio driver use cyclic dma ?
