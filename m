From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Wed, 17 Jun 2015 17:09:41 +0200
Message-ID: <55818DB5.6050007@canonical.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
 <55812F5C.8010502@metafoo.de> <s5h4mm68zfm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 72550260499
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 17:09:46 +0200 (CEST)
In-Reply-To: <s5h4mm68zfm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org



On 2015-06-17 11:19, Takashi Iwai wrote:
> Well, USB-audio has another problem.  USB-audio uses the intermediate
> audio ring buffer, and the samples are copied to each URB buffer.  At
> each packet complete, the driver copies the rest of sample chunk
> again, and advances the hwptr when the packets.  So, the hwptr of
> USB-audio is in advance of the actual sample position.  But we provide
> the runtime delay information for user-space to correct to the more
> accurate sample position.  So far, so good.
>
> A missing piece in this picture is, however, the position of the
> not-yet-queued samples in ring buffer.  Basically you can rewrite /
> rewind the sample at most this point, but not farther -- such
> in-flight samples can't be modified any longer.  This can be seen a
> kind of hardware fifo with a pretty big and non-continuously variable
> size during operation.
>
> In that sense, get_fifo() looks like a candidate for giving such
> information, indeed.  But reviving the old (and rather bad working)
> API appears dangerous to me.  I'd prefer creating a new API function
> instead, if any.
>
> BTW, because of its design like above, a large (or no) period size
> doesn't help for saving power at all with USB-audio.  This should be
> considered before the further discussion...

Hmm...I was trying to understand this power save argument. I tried to 
figure out a "typical" URB size by just plugging my headset in, and I 
saw wMaxPacketSize being 96 and/or 192 bytes.
Then, MAX_PACKS is set to either 6 (or 48 for USB 2.0 devices, but this 
is just a headset).

Can this be correct? Does it mean that we are getting interrupts every 
192 * 6 bytes (i e, every 6 ms for a 48kHz/stereo/16bit stream)?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
