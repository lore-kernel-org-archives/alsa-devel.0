From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 Toneport UX1 driver again
Date: Tue, 11 Jul 2006 17:15:00 +0200
Message-ID: <160c13350607110815v4cf22dafg1485709d21dba49b@mail.gmail.com>
References: <160c13350607110559v28640db3x7abc13946b58adca@mail.gmail.com>
	<s5hveq45llx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2061121946=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hveq45llx.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============2061121946==
Content-Type: multipart/alternative;
	boundary="----=_Part_29349_3595898.1152630900393"

------=_Part_29349_3595898.1152630900393
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/7/11, Takashi Iwai <tiwai@suse.de>:
>
> At Tue, 11 Jul 2006 14:59:40 +0200,
> Stefano D'Angelo wrote:
> >
> > 2006/7/11, Takashi Iwai <tiwai@suse.de>:
> >
> >     At Sat, 8 Jul 2006 18:14:15 +0200,
> >     Stefano D'Angelo wrote:
> >     >
> >     > Excuse me if I'm repeatedly asking the same things, but I still
> can't understand
> >     how
> >     > some stuff works probably.
> >     > I have these lines of code:
> >     >
> >     > static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {
> >     >     .info             = SNDRV_PCM_INFO_INTERLEAVED |
> >     >                         SNDRV_PCM_INFO_BLOCK_TRANSFER,
> >     >     .formats          = SNDRV_PCM_FMTBIT_S16_LE,
> >     >     .rates            = SNDRV_PCM_RATE_48000,
> >     >     .rate_min         = 48000,
> >     >     .rate_max         = 48000,
> >     >     .channels_min     = 2,
> >     >     .channels_max     = 2,
> >     >     /* double buffering */
> >     >     .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2
> * 2,
> >     >     .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> >     >     .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> >     >     .periods_min      = 1,
> >     >     .periods_max      = 2
> >     > };
> >     >
> >     > and then also:
> >     >
> >     > static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (
> >
> >                                                snd_pcm_substream_t*
> substream)
> >     > {
> >     >     struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip
> (substream);
> >     >
> >     >     printk ("pos: %d\n", chip->playback_pos);
> >     >     return chip->playback_pos;
> >     > }
> >     >
> >     > static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t
> *substream,
> >     >                                            int channel,
> snd_pcm_uframes_t pos,
> >     >                                            void *src,
> snd_pcm_uframes_t count)
> >     > {
> >     >     struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip
> (substream);
> >     >     snd_pcm_runtime_t *runtime = substream->runtime;
> >     >     static struct urb* urb;
> >     >
> >     >     int i = 0;
> >     >     static int j = 0;
> >     >
> >     >     urb = usb_alloc_urb (2, GFP_ATOMIC);
> >     >     urb->dev = chip->dev;
> >     >     urb->pipe = usb_sndisocpipe (urb->dev, 1);
> >     >     urb->complete = snd_line6_tp_ux1_complete_playback_transfer;
> >     >     urb->context = substream;
> >     >     urb->transfer_buffer = kmalloc
> (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> >     > GFP_ATOMIC);
> >     >     urb->transfer_buffer_length =
> LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2;
> >     >     urb->transfer_flags = URB_ISO_ASAP;
> >     >
> >     >     memcpy (urb->transfer_buffer, src, count * 2 * 2);
> >     >
> >     >     for (; i < LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {
> >     >         printk ("%d\n", ((s16*)urb->transfer_buffer)[i]);
> >     >     }
> >     >     printk ("---------\n");
> >     >
> >     >     urb->interval = 1;
> >     >     urb->number_of_packets = 2;
> >     >     urb->iso_frame_desc[0].offset = 0;
> >     >     urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset
> =
> >     >     urb->iso_frame_desc[1].length =
> LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;
> >     >     if (chip->playback_pos)
> >     >         chip->playback_pos = 0;
> >     >     else
> >     >         chip->playback_pos = count;
> >     >     j++;
> >     >     printk (":: %d %d %d\n", j, chip->playback_pos,
> runtime->buffer_size);
> >     >     snd_pcm_period_elapsed (substream);
> >     >     usb_submit_urb (urb, GFP_KERNEL);
> >     >
> >     >     return count;
> >     > }
> >     >
> >     > Don't care about printk()s and codying style, count in the copy
> callback is
> >     always 96,
> >     > which is the # of frames of a period, so everytime the copy
> callback is called,
> >     a
> >     > period is elapsed. Since the buffer is long 2 periods, the
> playback position
> >     pointer
> >     > should be either 0 or 96, I think (beginning or half of the
> buffer).
> >     > Now, instead of working as expected, the copy callback just works
> twice, for the
> >     first
> >     > two periods (one buffer length). Then the pointer becomes 0 and I
> can't
> >     understand why
> >     > the playback stops.
> >     > Please help! I have some people who keep on asking me about the
> driver, and it's
> >     a
> >     > pity that I can't overcome such simple problems and let them use
> their sound
> >     card!
> >
> >     Calling snd_pcm_period_elapsed() in copy callback doesn't make
> sense.
> >     The copy callback is called when the PCM core requires something to
> >     copy.
> >
> >     In general, all PCM driver callbacks are passive.  They need to do
> >     only what they are requested.   The role of copy callback is to copy
> >     the given user-space data to the hardware buffer.  The role of
> pointer
> >     callback is to return the current (DMA) transfer position in the
> ring
> >     buffer.  The role of trigger callback is to start or stop the PCM
> >     stream...
> >
> >     In the ALSA PCM model, there are some assumptions:
> >
> >     1. You have a ring buffer containing PCM data.
> >     2. DMA is running at constant rate, transferring the data in
> >        background and updating the position.
> >
> >     Usually, the DMA controller issues an interrupt when a given size of
> >     data ("period" in ALSA term) is processed.  The driver calls
> >     snd_pcm_period_elapsed() in the interrupt handler, then.
> >
> >     However, in the case of USB devices, it's a bit tricky, because the
> >     transfer is done via non-continuous packets.  To overcome this,
> >     snd-usb-audio allocates a ring-buffer via vmalloc() in hw_params
> >     callback.  The PCM core copies the user-space data to the
> ring-buffer,
> >     and the driver copies the data from the ring-buffer to each urb
> >     appropriately.
> >
> >     The first trigger-start callback prepares the urbs (with data copy
> >     from ring-buffer) and submit them.  When urb-complete callback is
> >     called, the driver updates the current position, then *here* calls
> >     snd_pcm_period_elapsed() if the pre-given period size was already
> >     processed.  Then, copy the data to urb, and re-submit it.
> >
> >     Takashi
> >
> > Thanks a lot, however I realized that just yesterday and I think I fixed
> the whole
> > thing, 48kHz 16-bits stereo output works properly now (just a little
> problem occours,
> > some overruns at the beginning of the output, but I think I know how to
> fix it).
> > Since I've got a person who owns a Line6 TonePort UX2 sound card and
> its' likely that
> > these sound cards share the same protocol, I sent him the driver code
> and he will test
> > it in the next days. So I renamed it as snd_toneport.
> > However I did this way (tell me if it is correct - just 48kHz 16-bits
> stereo support
> > now):
> >
> > [...]
> >
> > static snd_pcm_hardware_t snd_toneport_playback_hw = {
> >
> >     .info             = SNDRV_PCM_INFO_INTERLEAVED |
> >                         SNDRV_PCM_INFO_BLOCK_TRANSFER,
> >     .formats          = SNDRV_PCM_FMTBIT_S16_LE,
> >     .rates            = SNDRV_PCM_RATE_48000,
> >     .rate_min         = 48000,
> >     .rate_max         = 48000,
> >     .channels_min     = 2,
> >     .channels_max     = 2,
> >     .buffer_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2 * 10,
> >     .period_bytes_min = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
> >     .period_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
> >     .periods_min      = 1,
> >     .periods_max      = 10
> > };
> >
> > [...]
> >
> > /*
> >  * playback transfers' completition callback
> >  *
> >  * TODO: error handling and full duplex
> >  */
> > static void snd_toneport_complete_playback_transfer (struct urb* urb,
> >     struct pt_regs* regs)
> > {
> >     snd_pcm_substream_t *substream = (snd_pcm_substream_t
> *)(urb->context);
> >     struct snd_toneport *chip = snd_pcm_substream_chip (substream);
> >
> >     chip->playback_pos += TONEPORT_48000_16_PACKET_SIZE_OUT / 2;
> >     if (chip->playback_pos >= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 *
> 10)
> >         chip->playback_pos -= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 *
> >             10;
> >
> >     snd_pcm_period_elapsed (substream);
> >
> >     kfree (urb->transfer_buffer);
> >     usb_free_urb (urb);
> > }
> >
> > [...]
> >
> > /*
> >  * copy callback
> >  */
> > static int snd_toneport_playback_copy (snd_pcm_substream_t *substream,
> >
> >     int channel, snd_pcm_uframes_t pos, void *src, snd_pcm_uframes_t
> count)
> > {
> >     struct snd_toneport *chip = snd_pcm_substream_chip (substream);
> >     struct urb* urb;
> >
> >     urb = usb_alloc_urb (2, GFP_ATOMIC);
> >     urb->dev = chip->dev;
> >     urb->pipe = usb_sndisocpipe (urb->dev, 1);
> >     urb->complete = snd_toneport_complete_playback_transfer;
> >     urb->context = substream;
> >     urb->transfer_buffer = kmalloc (TONEPORT_48000_16_PACKET_SIZE_OUT *
> 2,
> >         GFP_ATOMIC);
> >     urb->transfer_buffer_length = TONEPORT_48000_16_PACKET_SIZE_OUT * 2;
> >
> >     urb->transfer_flags = URB_ISO_ASAP;
> >     memcpy (urb->transfer_buffer, src, count * 2 * 2);
> >     urb->interval = 1;
> >     urb->number_of_packets = 2;
> >     urb->iso_frame_desc[0].offset = 0;
> >     urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
> >     urb->iso_frame_desc[1].length = TONEPORT_48000_16_PACKET_SIZE_OUT;
> >     usb_submit_urb (urb, GFP_ATOMIC);
> >
> >     return count;
> > }
> >
> > [...]
> >
> > I tried without a copy callback via DMA transfers (if I'm not wrong also
> snd-usb-audio
> > does this way) but it just didn't work (maybe the card does not support
> DMA?)
> > However thanks a lot again!
>
> Did you allocate the ring-buffer in hw_params callback, not only the
> urbs?
>
> You could implement using copy callback, but in that case, the driver
> won't work with mmap mode.  So, a ring-buffer as the primary buffer
> and manual copy to urbs would be a more flexible option.
>
> Anyway, the copy callback shouldn't submit urbs by itself.  The copy
> callback is to copy the data.  That's all.  The copy can be operated
> even before starting the stream (filling the buffer first, then
> start). Hence, the urbs should be submitted in the trigger-start
> callback.
>
> Also, kmalloc/kfree at each time is inefficient.  You can reuse the
> urbs and packet data buffers.
>
>
> Takashi


No, I didn't allocate the ring-buffer, but isn't the data to copy just
present in the buffer pointed by src in the copy callback parameters?
However, I read in "Writing an ALSA driver" by you that if a sound card does
not support DMA a copy callback is necessary. I tried without... but it
didn't work, just heard long beeps, but maybe I did wrong.
But maybe there's another solution to the problem: since this card has just
some differences at initialization and playback start with normal USB cards,
maybe usb-snd-audio could be used. (To be honest I still don't know about
capture, but I suppose it is quite similar).
What do you think about that?

------=_Part_29349_3595898.1152630900393
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/7/11, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
At Tue, 11 Jul 2006 14:59:40 +0200,<br>Stefano D'Angelo wrote:<br>&gt;<br>&gt; 2006/7/11, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; At Sat, 8 Jul 2006 18:14:15 +0200,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Stefano D'Angelo wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Excuse me if I'm repeatedly asking the same things, but I still can't understand<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; how<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; some stuff works probably.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I have these lines of code:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_INFO_INTERLEAVED |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_FMTBIT_S16_LE,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_RATE_48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; /* double buffering */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 * 2,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; };<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; and then also:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;snd_pcm_substream_t* substream)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;pos: %d\n&quot;, chip-&gt;playback_pos);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; return chip-&gt;playback_pos;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t *substream,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int channel, snd_pcm_uframes_t pos,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void *src, snd_pcm_uframes_t count)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; static struct urb* urb;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; int i = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; static int j = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_line6_tp_ux1_complete_playback_transfer;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;context = substream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = kmalloc (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; GFP_ATOMIC);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer_length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, src, count * 2 * 2);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; for (; i &lt; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;%d\n&quot;, ((s16*)urb-&gt;transfer_buffer)[i]);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;---------\n&quot;);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; else
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = count;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; j++;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;:: %d %d %d\n&quot;, j, chip-&gt;playback_pos, runtime-&gt;buffer_size);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_KERNEL);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Don't care about printk()s and codying style, count in the copy callback is
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; always 96,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; which is the # of frames of a period, so everytime the copy callback is called,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; period is elapsed. Since the buffer is long 2 periods, the playback position
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; pointer<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; should be either 0 or 96, I think (beginning or half of the buffer).<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Now, instead of working as expected, the copy callback just works twice, for the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; first
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; two periods (one buffer length). Then the pointer becomes 0 and I can't<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; understand why<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; the playback stops.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Please help! I have some people who keep on asking me about the driver, and it's
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; pity that I can't overcome such simple problems and let them use their sound<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; card!<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Calling snd_pcm_period_elapsed() in copy callback doesn't make sense.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; The copy callback is called when the PCM core requires something to
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; copy.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; In general, all PCM driver callbacks are passive.&nbsp;&nbsp;They need to do<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; only what they are requested.&nbsp;&nbsp; The role of copy callback is to copy<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; the given user-space data to the hardware buffer.&nbsp;&nbsp;The role of pointer
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; callback is to return the current (DMA) transfer position in the ring<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; buffer.&nbsp;&nbsp;The role of trigger callback is to start or stop the PCM<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; stream...<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; In the ALSA PCM model, there are some assumptions:
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 1. You have a ring buffer containing PCM data.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2. DMA is running at constant rate, transferring the data in<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;background and updating the position.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Usually, the DMA controller issues an interrupt when a given size of
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; data (&quot;period&quot; in ALSA term) is processed.&nbsp;&nbsp;The driver calls<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed() in the interrupt handler, then.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; However, in the case of USB devices, it's a bit tricky, because the
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; transfer is done via non-continuous packets.&nbsp;&nbsp;To overcome this,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd-usb-audio allocates a ring-buffer via vmalloc() in hw_params<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; callback.&nbsp;&nbsp;The PCM core copies the user-space data to the ring-buffer,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; and the driver copies the data from the ring-buffer to each urb<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; appropriately.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; The first trigger-start callback prepares the urbs (with data copy<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; from ring-buffer) and submit them.&nbsp;&nbsp;When urb-complete callback is
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; called, the driver updates the current position, then *here* calls<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed() if the pre-given period size was already<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; processed.&nbsp;&nbsp;Then, copy the data to urb, and re-submit it.
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Takashi<br>&gt;<br>&gt; Thanks a lot, however I realized that just yesterday and I think I fixed the whole<br>&gt; thing, 48kHz 16-bits stereo output works properly now (just a little problem occours,
<br>&gt; some overruns at the beginning of the output, but I think I know how to fix it).<br>&gt; Since I've got a person who owns a Line6 TonePort UX2 sound card and its' likely that<br>&gt; these sound cards share the same protocol, I sent him the driver code and he will test
<br>&gt; it in the next days. So I renamed it as snd_toneport.<br>&gt; However I did this way (tell me if it is correct - just 48kHz 16-bits stereo support<br>&gt; now):<br>&gt;<br>&gt; [...]<br>&gt;<br>&gt; static snd_pcm_hardware_t snd_toneport_playback_hw = {
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_INFO_INTERLEAVED |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_FMTBIT_S16_LE,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_RATE_48000,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .buffer_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2 * 10,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_min = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 10<br>&gt; };
<br>&gt;<br>&gt; [...]<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* playback transfers' completition callback<br>&gt;&nbsp;&nbsp;*<br>&gt;&nbsp;&nbsp;* TODO: error handling and full duplex<br>&gt;&nbsp;&nbsp;*/<br>&gt; static void snd_toneport_complete_playback_transfer (struct urb* urb,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip (substream);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos += TONEPORT_48000_16_PACKET_SIZE_OUT / 2;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos &gt;= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 * 10)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos -= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 *<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; kfree (urb-&gt;transfer_buffer);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; usb_free_urb (urb);<br>&gt; }<br>&gt;<br>&gt; [...]<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* copy callback<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int snd_toneport_playback_copy (snd_pcm_substream_t *substream,
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int channel, snd_pcm_uframes_t pos, void *src, snd_pcm_uframes_t count)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip (substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct urb* urb;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_toneport_complete_playback_transfer;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;context = substream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = kmalloc (TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer_length = TONEPORT_48000_16_PACKET_SIZE_OUT * 2;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, src, count * 2 * 2);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length = TONEPORT_48000_16_PACKET_SIZE_OUT;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_ATOMIC);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>&gt; }<br>&gt;<br>&gt; [...]<br>&gt;<br>&gt; I tried without a copy callback via DMA transfers (if I'm not wrong also snd-usb-audio<br>&gt; does this way) but it just didn't work (maybe the card does not support DMA?)
<br>&gt; However thanks a lot again!<br><br>Did you allocate the ring-buffer in hw_params callback, not only the<br>urbs?<br><br>You could implement using copy callback, but in that case, the driver<br>won't work with mmap mode.&nbsp;&nbsp;So, a ring-buffer as the primary buffer
<br>and manual copy to urbs would be a more flexible option.<br><br>Anyway, the copy callback shouldn't submit urbs by itself.&nbsp;&nbsp;The copy<br>callback is to copy the data.&nbsp;&nbsp;That's all.&nbsp;&nbsp;The copy can be operated<br>even before starting the stream (filling the buffer first, then
<br>start). Hence, the urbs should be submitted in the trigger-start<br>callback.<br><br>Also, kmalloc/kfree at each time is inefficient.&nbsp;&nbsp;You can reuse the<br>urbs and packet data buffers.<br><br><br>Takashi </blockquote>
<div><br>No, I didn't allocate the ring-buffer, but isn't the data to copy just present in the buffer pointed by src in the copy callback parameters? However, I read in &quot;Writing an ALSA driver&quot; by you that if a sound card does not support DMA a copy callback is necessary. I tried without... but it didn't work, just heard long beeps, but maybe I did wrong.
<br>But maybe there's another solution to the problem: since this card has just some differences at initialization and playback start with normal USB cards, maybe usb-snd-audio could be used. (To be honest I still don't know about capture, but I suppose it is quite similar).
<br>What do you think about that?<br></div></div>

------=_Part_29349_3595898.1152630900393--


--===============2061121946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============2061121946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2061121946==--
