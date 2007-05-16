From: Markus Korber <korbse@gmx.at>
Subject: Re: Audio DMA buffer layout
Date: Wed, 16 May 2007 10:17:48 +0200
Message-ID: <6z7ir9p4gj.fsf@odpc25.int.ondemand.co.at>
References: <6zbqgvsfj0.fsf@odpc25.int.ondemand.co.at>
	<s5hvef25eai.wl%tiwai@suse.de>
	<6z8xbxj6hn.fsf@odpc25.int.ondemand.co.at>
	<s5hy7jwisb7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 57FBF24339
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 10:17:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Takashi Iwai:

> At Thu, 10 May 2007 12:52:20 +0200,
> Markus Korber wrote:
>>
>> Thus spake Takashi Iwai:
>>
>>> At Tue, 08 May 2007 13:47:47 +0200,
>>> Markus Korber wrote:
>>>>
>>>>
>>>> IRQ1 +----------------+
>>>>      | page_3 (right) |\
>>>>      +----------------+ > double buffer 1
>>>>      | page_2 (left)  |/
>>>> IRQ0 +----------------+
>>>>      | page_1 (right) |\
>>>>      +----------------+ > double buffer 0
>>>>      | page_0 (left)  |/
>>>>      +----------------+
>>>
>>> If I understand correctly, the samples for a channel (e.g. left) is
>>> practically split to two regions, page 0 and page 2 in the above?
>>
>> Correct.
>>
>> Furthermore, in mmap mode, I think I could use an intermediate buffer
>> (with the layout as above), where I copy the data from the (linear)
>> mmap'd buffer to, could I?  Maybe using helpers from struct
>> pcm-indirect.h?  But this is not very beautiful.
>
> Yeah, it's possible but not sexy.  That's what I meant
> "straightforwardly".

Thanks again for your answer.  I'm trying to implement the solution with
the intermediate buffer first, however, since it seems easier to me :)

Driver settings are as follows:

I use 2* in buffer_bytes_max because I copy the data from the first half
of the buffer (where the application writes to) into the second half
with the layout as shown above (this is my intermediate buffer where the
hardware works upon).  So the intermediate buffer lies right at the end
of the ALSA buffer.

,----
| static const struct snd_pcm_hardware chip_pcm_hardware =3D {
|         .info                   =3D SNDRV_PCM_INFO_MMAP |
|                                   SNDRV_PCM_INFO_MMAP_VALID |
|                                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
|                                   SNDRV_PCM_INFO_PAUSE |
|                                   SNDRV_PCM_INFO_RESUME |
|                                   SNDRV_PCM_INFO_NONINTERLEAVED,
|         ...
|         .period_bytes_min       =3D 8*1024,
|         .period_bytes_max       =3D 8*1024,
|         .periods_min            =3D 2,
|         .periods_max            =3D 2,
|         .buffer_bytes_max       =3D 2*2*8*1024,
| }
`----

And here some driver fragments:

=B7 bufnum refers to the active (i.e. currently transmitted) double buffer
  0 or 1 as defined above.
=B7 Buffer is allocated with dma_alloc_writecombine().  Does this make
  sense?
=B7 prtd->period_bytes =3D params_period_bytes(params)

So here I copy the provided source data to either double buffer 0 or 1.
,----
| static void chip_playback_copy(struct snd_pcm_substream *substream,
|                                 struct snd_pcm_indirect *rec, size_t byte=
s)
| {
|         unsigned char *src =3D substream->runtime->dma_area + rec->sw_dat=
a;
|         ...
|         DBG("Entered %s (%d -> src: %#08x, bytes: %#04x, data_l: %#04x)\n=
",
|             __FUNCTION__, bufnum, src, bytes, *(u16*)src);
|         ...
|         dst =3D bufnum =3D=3D 0 ? bus_to_virt(prtd->i2s_buffer_1) :
|                 bus_to_virt(prtd->i2s_buffer_0);
|         memcpy(dst, src, bytes/2);
| }
`----

Here I setup the hardware buffer size to be the same as the software
buffer size (0x4000).
,----
| static int chip_pcm_prepare(struct snd_pcm_substream *substream)
| {
|         ...
|         chip->playback.hw_buffer_size =3D prtd->period_bytes * 2; /* byte=
 size */
|         chip->playback.sw_buffer_size =3D snd_pcm_lib_buffer_bytes(substr=
eam);
|         chip->playback_hw_ptr =3D 0;
|         ...
| }
`----

The IRQ is generated at each double buffer boundary.  Thus I just set
the playback_hw_ptr to either 0 or hw_buffer_size/2.
,----
| static void chip_pcm_dma_irq(u32 tx_intstat, u32 rx_intstat,
|         struct snd_pcm_substream *substream)
| {
|         ...
|         if (bufnum =3D=3D 0)
|                 prtd->playback_hw_ptr =3D 0;
|         else
|                 prtd->playback_hw_ptr =3D prtd->period_bytes;
|         ...
|         if (substream)
|                 snd_pcm_period_elapsed(substream);
| =

| }
`----
,----
| static snd_pcm_uframes_t
|         chip_pcm_pointer(struct snd_pcm_substream *substream)
| {
|         return snd_pcm_indirect_playback_pointer(substream, &chip->playba=
ck,
|                                                  prtd->playback_hw_ptr);
| }
`----

The logging output from the chip_playback_copy() function shows this:
'aplay -M -D hw:0,0 /usr/share/sounds/alsa/test.wav'

(1) chip_pcm_trigger (command 0x1)
(2) chip_playback_copy (0 -> src: 0xffd00000, bytes: 0x4000, data_l: 0xff9a)
(3) chip_i2s_trigger (command 0x1)
(4) chip_playback_copy (1 -> src: 0xffd00000, bytes: 0x2000, data_l: 0x183)
(5) chip_playback_copy (0 -> src: 0xffd02000, bytes: 0x2000, data_l: 0x9c6)
(6) chip_playback_copy (1 -> src: 0xffd00000, bytes: 0x2000, data_l: 0xd719)
(7) chip_playback_copy (0 -> src: 0xffd02000, bytes: 0x2000, data_l: 0xdd1d)

My questions are: =


(1) I receive 2 copy calls (lines 4+5), where line 4 gives me 0x2000
    bytes of left channel samples and line 5 0x2000 right channel
    samples.

    Shouldn't I receive 0x1000 bytes of left AND right samples at each
    copy call and not either left or right samples from pcm-indirect?

(2) How can I prevent the usage of bus_to_virt() in chip_playback_copy,
    if I just want to copy samples from one physical address to another?

Finally, if I use SNDRV_PCM_INFO_INTERLEAVED and manually partition left
and right samples into the corresponding double buffers, everything
works fine.

Thanks for any hints.

Regards,
Markus Korber
