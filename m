From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Thu, 18 Jun 2015 11:15:32 +0800
Message-ID: <CAN8cciYdGP5Q9eGT+tjE_1qxkxT3JT7vPECN0CCvpZf7H5_tzA@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
 <55812F5C.8010502@metafoo.de> <s5h4mm68zfm.wl-tiwai@suse.de>
 <55818DB5.6050007@canonical.com> <5581A4CB.7080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id BA8BB2660BD
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 05:15:33 +0200 (CEST)
Received: by oigx81 with SMTP id x81so48509463oig.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 20:15:32 -0700 (PDT)
In-Reply-To: <5581A4CB.7080300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>>
>>> Well, USB-audio has another problem.  USB-audio uses the intermediate
>>> audio ring buffer, and the samples are copied to each URB buffer.  At
>>> each packet complete, the driver copies the rest of sample chunk
>>> again, and advances the hwptr when the packets.  So, the hwptr of
>>> USB-audio is in advance of the actual sample position.  But we provide
>>> the runtime delay information for user-space to correct to the more
>>> accurate sample position.  So far, so good.
>>>
>>> A missing piece in this picture is, however, the position of the
>>> not-yet-queued samples in ring buffer.  Basically you can rewrite /
>>> rewind the sample at most this point, but not farther -- such
>>> in-flight samples can't be modified any longer.  This can be seen a
>>> kind of hardware fifo with a pretty big and non-continuously variable
>>> size during operation.
>>>
>>> In that sense, get_fifo() looks like a candidate for giving such
>>> information, indeed.  But reviving the old (and rather bad working)
>>> API appears dangerous to me.  I'd prefer creating a new API function
>>> instead, if any.
>>>
>>> BTW, because of its design like above, a large (or no) period size
>>> doesn't help for saving power at all with USB-audio.  This should be
>>> considered before the further discussion...
>>
>>
>> Hmm...I was trying to understand this power save argument. I tried to
>> figure out a "typical" URB size by just plugging my headset in, and I
>> saw wMaxPacketSize being 96 and/or 192 bytes.
>> Then, MAX_PACKS is set to either 6 (or 48 for USB 2.0 devices, but this
>> is just a headset).
>>
>> Can this be correct? Does it mean that we are getting interrupts every
>> 192 * 6 bytes (i e, every 6 ms for a 48kHz/stereo/16bit stream)?
>
>
> At least that's how often the position gets updated in the worst case. I
have attached a report for a Logitech USB headset and a test program where
you can modify the buffer and period sizes. A line is logged every time
snd_pcm_avail() returns a different value.
>

How about the result using multiple of 48 frames as period size since min
period size is 48 frames (1 ms) , it seem that your tests are not using the
optimal period size
