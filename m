From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 08:43:03 +0200
Message-ID: <5587AE77.1020709@metafoo.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>	<557E86DD.8020709@metafoo.de>	<CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>	<557EBEAA.70004@metafoo.de>	<CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>	<557EDE22.7080808@metafoo.de>
 <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id C36E3261583
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 08:43:05 +0200 (CEST)
In-Reply-To: <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/22/2015 04:35 AM, Raymond Yau wrote:
>
>  >
>  > DMA_RESIDUE_GRANULARITY_BURST means it can report the position with a
> granularity of a few samples. Typically half the audio FIFO size.
>  >
>  >
>
> How many soc driver/platform dma engine support DMA_RESIDUE_GRANULARITY_BURST ?

Not sure, maybe half of them. But most of the time it is a software 
restriction rather than a hardware restriction and more and more drivers are 
supporting it.

>
> Are all soc audio driver use cyclic dma ?

I'm not sure I understand the question. All audio drivers use some kind of 
cyclic DMA. ASoC platforms which do not have a dedicated audio DMA typically 
use dmaengine for this, while others which have dedicated audio DMA do the 
DMA as part of the audio driver.
