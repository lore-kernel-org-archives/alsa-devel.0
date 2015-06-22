From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Tue, 23 Jun 2015 07:52:10 +0900
Message-ID: <5588919A.5090500@sakamocchi.jp>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
 <5587AE77.1020709@metafoo.de> <5587D845.4040309@ladisch.de>
 <CAN8ccibQvDmdydn3QjHH==mNNizWuH+FOwRMu_BFRYGAfu9ukw@mail.gmail.com>
 <5587FB52.9070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 784722604E2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 00:52:17 +0200 (CEST)
In-Reply-To: <5587FB52.9070401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Raymond Yau <superquad.vortex2@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On jUN 22 2015 21:10, Alexander E. Patrakov wrote:
> 22.06.2015 16:54, Raymond Yau wrote:
>>>>> Are all soc audio driver use cyclic dma ?
>>>>
>>>> I'm not sure I understand the question. All audio drivers use some
>>>> kind of cyclic DMA.
>>>
>>> The ALSA API requires the driver to provide a cyclic sample buffer (or
>>> something that behaves like one).
>>>
>>> However, not all hardware works this way.  USB and FireWire require the
>>> driver to continually queue new packets, whose size and timing are
>>> determined by the bus clock and are not directly related to the ALSA
>>> ring buffer.  These drivers use double buffering; the actual DMA happens
>>> from those packets, not from the ring buffer.
>>>
>>
>> If those queued packets/urb cannot be rewind, snd_pcm_rewindable should
>> return zero for those driver

No need at all for ALSA firewire drivers, because PCM frames which is
not transferred are still rewindable.

Current ALSA firewire stack implementation, 16 packets are queued in one
callback from software interrupt context. In IEEE 1394 bus, 8,000
packets are transmitted per second. Therefore, one callback processes
PCM frames around 2 msec.
(Actually, in IEC 61883-6, two ways to transfer PCM frames in
these packets, thus one callback cannot processes PCM frames 'just' 2 msec.)

Let's consider about actual time, for example, in my system:
 * Software interrupt interval takes 1.986-2.015msec
 * The processing of one callback takes 0.024-0.026msec

(Intel DH77DF, Core i3-2120T, 4GB RAM, VT6315 as 1394 OHCI controller)

During processing one callback, pcm frames are copied to packet buffer.
The 'hw_ptr' is updated every time the number of copied pcm
frames is across period boundary. Therefore, the 'hw_ptr' suddenly jumps
by one period. This is a reason to use 'SNDRV_PCM_INFO_BLOCK_TRANSFER'.

While, snd-firewire-lib has internal representation to count the number
of transferred PCM frames. The 'struct snd_pcm_ops.pointer()' returns
the counter in the representation. This counter is updated during the
callback processing, while it's not updated between the callback.
Therefore, the counter changes during 0.024-0.026msec and calm
during 1.986-2.015msec. In short, the counter doesn't move continuously.
Roughly, this may be observed as the returned value of 'struct
snd_pcm_ops.pointer()' changes every 1.986-2.015msec. This
is a reason to use 'SNDRV_PCM_INFO_BATCH'.

(I think we use these two flags as the same way as Lars explained:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093750.html)

(In my understanding, 'SNDRV_PCM_INFO_BATCH' means that 'struct
snd_pcm_ops.pointer()' returns correct value in PCM period/buffer but
the value doesn't change constantly against actual time frame.
Therefore, several periods must be included in the buffer.)

Well, here, I describe two aspects; one is for period size and
across-boundary, another is for rewindability.

* period size and across-boundary:
All of ALSA firewire drivers has a restriction that the minimum size of
period is equivalent to 5 msec. Our intension is that at least one
callback from software interrupt context occurs during processing PCM
frames equivalent to the size of period.
('5' msec is for safe. '3' msec may be OK, I think.)

* rewindability
During the 0.024-0.026msec, snd_pcm_rewindable() returns the value based
on currect pointer position in the internal representation in
snd-firewire-lib, while the value is immediately changed and the
retrieved value becomes old. During the 1.986-2.015msec,
snd_pcm_rewindable returns the fastened value because no PCM frames are
processed for transmission.


By the way, abour the packetization and PCM frame processing, I've
written a report:
https://github.com/takaswie/alsa-firewire-report

If you want to post your questions about ALSA firewire stack, please
read this report and consider about your issues before posting it,
Raymond. Of cource, I'm welcome to receive any questions or indications
about the content of my report.


Regards

Takashi Sakamoto
