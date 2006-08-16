From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 TonePort
Date: Wed, 16 Aug 2006 22:46:13 +0200
Message-ID: <160c13350608161346u18303d42lf75e03d0f4cc0761@mail.gmail.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
	<1155316913.11766.268179999@webmail.messagingengine.com>
	<160c13350608111307w5a0778ffm4aa01046c95f1132@mail.gmail.com>
	<d9def9db0608111644s22ab3361ob68011034fb8d502@mail.gmail.com>
	<160c13350608140146u5ab2d3ddu38990ec20160974@mail.gmail.com>
	<d9def9db0608140822o175061a8qe46868bfc4d61169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0404769780=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <d9def9db0608140822o175061a8qe46868bfc4d61169@mail.gmail.com>
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

--===============0404769780==
Content-Type: multipart/alternative;
	boundary="----=_Part_151692_14765250.1155761173607"

------=_Part_151692_14765250.1155761173607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, but I know it works when you "fill" the endpoint... I had it working but
with playback callback. That way, however, I hadn't got mmap and that's why
now I'm going crazy!

2006/8/14, Markus Rechberger <mrechberger@gmail.com>:
>
> Hi,
>
>     .buffer_bytes_max    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2,
>     .period_bytes_min    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2,
>     .period_bytes_max    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2,
>
> I don't know what value TONEPORT_48000_24_PACKET_SIZE_OUT is _BUT_
> I had to take care about this in my driver too.
> The max packet size is 128 bytes, but I'm only allowed to fill 18-20
> bytes.
> Theoretically I could submit 2560 bytes within one urb but as soon as
> I submit more than 384 bytes or less I get a buzz or choppy sound.
> Have a look at the windows usbsnoop logs again.
>
> Here's the code of my usb audio driver:
> http://kurzlink.de/sBMLkXGXe
>
> Markus
>
> On 8/14/06, Stefano D'Angelo <zanga.mail@gmail.com> wrote:
> > Clemens you were right of course, what I was saying was just bull shit
> (and
> > I'm sorry).
> > However the problem remains... I really don't know what's wrong with my
> code
> > so I post the "interesting parts" here. Please help, I DO need this card
> to
> > work!
> >
> > static snd_pcm_hardware_t snd_toneport_playback_hw = {
> >     .info            = SNDRV_PCM_INFO_MMAP |
> >                   SNDRV_PCM_INFO_INTERLEAVED |
> >                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
> >                   SNDRV_PCM_INFO_MMAP_VALID,
> >     .formats        = SNDRV_PCM_FMTBIT_S16_LE |
> >                   SNDRV_PCM_FMTBIT_S24_3LE,
> >     .rates            = SNDRV_PCM_RATE_44100 |
> >                   SNDRV_PCM_RATE_48000,
> >     .rate_min        = 44100,
> >     .rate_max        = 48000,
> >     .channels_min        = 2,
> >     .channels_max        = 2,
> >     .buffer_bytes_max    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2,
> >     .period_bytes_min    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2,
> >     .period_bytes_max    = TONEPORT_48000_24_PACKET_SIZE_OUT * 2,
> >     .periods_min        = 1,
> >     .periods_max        = 2
> > };
> >
> > Here period_bytes_min are is as the maximum period size to use just one
> PCM.
> >
> > #define snd_toneport_period_elapsed(old, new) \
> >     (new >= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2) || \
> >     ((old < TONEPORT_48000_24_PACKET_SIZE_OUT * 2) && \
> >      (new >= TONEPORT_48000_24_PACKET_SIZE_OUT * 2))
> >
> > This one should test if a period is elapsed based on the old playback
> > position (I see other drivers call such pointers hwptr) and the new one
> > (before this last is "normalized").
> >
> > /*
> >  * null urb trasfer's completition callback
> >  */
> > static void snd_toneport_playback_complete_first(struct urb* urb,
> >         struct pt_regs* regs)
> > {
> >     snd_pcm_substream_t *substream = (snd_pcm_substream_t
> *)(urb->context);
> >     snd_pcm_runtime_t *runtime = substream->runtime;
> >     struct snd_toneport *chip = snd_pcm_substream_chip(substream);
> >
> >     memcpy(urb->transfer_buffer, runtime->dma_area,
> >             chip->playback_packet_size * 2);
> >
> >     urb->complete = snd_toneport_playback_complete;
> >
> >     usb_submit_urb(urb, GFP_ATOMIC);
> > }
> >
> > /*
> >  * playback transfers' completition callback
> >  */
> > static void snd_toneport_playback_complete(struct urb* urb,
> >         struct pt_regs* regs)
> > {
> >     snd_pcm_substream_t *substream = (snd_pcm_substream_t
> *)(urb->context);
> >     snd_pcm_runtime_t *runtime = substream->runtime;
> >     struct snd_toneport *chip = snd_pcm_substream_chip(substream);
> >     int new_pos = chip->playback_pos + chip->playback_packet_size * 2;
> >     int offs;
> >
> >     if (new_pos <= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2) {
> >         memcpy(urb->transfer_buffer,
> >                 runtime->dma_area + chip->playback_pos,
> >                 chip->playback_packet_size * 2);
> >     } else {
> >         offs = TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2 -
> >             chip->playback_pos;
> >         memcpy(urb->transfer_buffer,
> >                 runtime->dma_area + chip->playback_pos,
> >                 offs);
> >         memcpy(urb->transfer_buffer + new_pos,
> >                 runtime->dma_area,
> >                 chip->playback_packet_size * 2 - offs);
> >     }
> >
> >     if (snd_toneport_period_elapsed(chip->playback_pos, new_pos)) {
> >         if (new_pos >= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2)
> >             new_pos -= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2;
> >         chip->playback_pos = new_pos;
> >         snd_pcm_period_elapsed(substream);
> >     } else {
> >         chip->playback_pos = new_pos;
> >     }
> >
> >     if (chip->status & TONEPORT_STATUS_PLAYBACK)
> >         usb_submit_urb(urb, GFP_ATOMIC);
> > }
> >
> > /*
> >  * hw_params callback
> >  *
> >  * TODO: capture and full duplex
> >  */
> > static int snd_toneport_pcm_hw_params(snd_pcm_substream_t *substream,
> >         snd_pcm_hw_params_t *hw_params)
> > {
> >     struct snd_toneport *chip = snd_pcm_substream_chip(substream);
> >     unsigned char msg[] = TONEPORT_MSG_3;
> >     int alt, err;
> >
> >     alt = (params_format(hw_params) == SNDRV_PCM_FORMAT_S16_LE) ? 1 : 3;
> >     if ((params_rate(hw_params) == 44100))
> >         alt++;
> >
> >     if ((err = usb_set_interface(chip->dev, 0, alt)) < 0)
> >         return err;
> >     chip->altsetting = alt;
> >
> >     if ((err = snd_toneport_submit_control_transfer(chip->dev, msg)) <
> 0)
> >         return err;
> >
> >     chip->playback_packet_size = out_sizes[alt - 1];
> >     if (!chip->playback_urb) {
> >         chip->playback_urb = usb_alloc_urb(2, GFP_KERNEL);
> >         chip->playback_urb->dev = chip->dev;
> >         chip->playback_urb->pipe = usb_sndisocpipe(chip->dev, 1);
> >         chip->playback_urb->context = substream;
> >         chip->playback_urb->transfer_flags = URB_ISO_ASAP |
> >             URB_NO_TRANSFER_DMA_MAP;
> >         chip->playback_urb->interval = 1;
> >         chip->playback_urb->number_of_packets = 2;
> >         chip->playback_urb->iso_frame_desc[0].offset = 0;
> >     } else {
> >         usb_buffer_free(chip->dev, chip->playback_packet_size * 2,
> >                 chip->playback_urb->transfer_buffer,
> >                 chip->playback_urb->transfer_dma);
> >     }
> >     if (!(chip->playback_urb->transfer_buffer =
> >         usb_buffer_alloc(chip->dev, chip->playback_packet_size * 2,
> >             GFP_KERNEL, &chip->playback_urb->transfer_dma)))
> >         return -ENOMEM;
> >     chip->playback_urb->transfer_buffer_length =
> >         chip->playback_packet_size * 2;
> >     chip->playback_urb->iso_frame_desc[0].length =
> >         chip->playback_urb->iso_frame_desc[1].offset =
> >         chip->playback_urb->iso_frame_desc[1].length =
> >         chip->playback_packet_size;
> >
> >     return snd_pcm_lib_malloc_pages(substream,
> >             TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2);
> > }
> >
> > /*
> >  * trigger callback
> >  */
> > static int snd_toneport_pcm_trigger(snd_pcm_substream_t *substream, int
> cmd)
> > {
> >     struct snd_toneport *chip = snd_pcm_substream_chip(substream);
> >
> >     switch (cmd) {
> >     case SNDRV_PCM_TRIGGER_START:
> >         memset(chip->playback_urb->transfer_buffer, 0,
> >                 chip->playback_packet_size * 2);
> >         chip->playback_pos = 0;
> >         chip->status |= TONEPORT_STATUS_PLAYBACK;
> >         chip->playback_urb->complete =
> >             snd_toneport_playback_complete_first;
> >         return usb_submit_urb(chip->playback_urb, GFP_ATOMIC);
> >         break;
> >     case SNDRV_PCM_TRIGGER_STOP:
> >         chip->status &= ~TONEPORT_STATUS_PLAYBACK;
> >         break;
> >     default:
> >             return -EINVAL;
> >         break;
> >     }
> >
> >     return 0;
> > }
> >
> > /*
> >  * pointer callback
> >  */
> > static snd_pcm_uframes_t snd_toneport_pcm_pointer(
> >         snd_pcm_substream_t* substream)
> > {
> >     struct snd_toneport *chip = snd_pcm_substream_chip(substream);
> >
> >     return bytes_to_frames(substream->runtime, chip->playback_pos);
> > }
> >
> > As you can see I chose to store the playback position in bytes instead
> of
> > frames because I have 6-bytes frames and 4-bytes frames (depends on the
> > format).
> > Also TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2 is the alsa buffer size.
> > Thanks,
> >
> > Stefano
> >
> >
>
>
> --
> Markus Rechberger
>

------=_Part_151692_14765250.1155761173607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, but I know it works when you &quot;fill&quot; the endpoint... I had it working but with playback callback. That way, however, I hadn't got mmap and that's why now I'm going crazy!<br><br><div><span class="gmail_quote">
2006/8/14, Markus Rechberger &lt;<a href="mailto:mrechberger@gmail.com">mrechberger@gmail.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;.buffer_bytes_max&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2,<br>&nbsp;&nbsp;&nbsp;&nbsp;.period_bytes_min&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2,<br>&nbsp;&nbsp;&nbsp;&nbsp;.period_bytes_max&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2,<br>
<br>I don't know what value TONEPORT_48000_24_PACKET_SIZE_OUT is _BUT_<br>I had to take care about this in my driver too.<br>The max packet size is 128 bytes, but I'm only allowed to fill 18-20 bytes.<br>Theoretically I could submit 2560 bytes within one urb but as soon as
<br>I submit more than 384 bytes or less I get a buzz or choppy sound.<br>Have a look at the windows usbsnoop logs again.<br><br>Here's the code of my usb audio driver:<br><a href="http://kurzlink.de/sBMLkXGXe">http://kurzlink.de/sBMLkXGXe
</a><br><br>Markus<br><br>On 8/14/06, Stefano D'Angelo &lt;<a href="mailto:zanga.mail@gmail.com">zanga.mail@gmail.com</a>&gt; wrote:<br>&gt; Clemens you were right of course, what I was saying was just bull shit (and<br>&gt; I'm sorry).
<br>&gt; However the problem remains... I really don't know what's wrong with my code<br>&gt; so I post the &quot;interesting parts&quot; here. Please help, I DO need this card to<br>&gt; work!<br>&gt;<br>&gt; static snd_pcm_hardware_t snd_toneport_playback_hw = {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_INFO_MMAP |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_INTERLEAVED |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_MMAP_VALID,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_FMTBIT_S16_LE |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_FMTBIT_S24_3LE,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_RATE_44100 |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_RATE_48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 44100,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .buffer_bytes_max&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_min&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_max&nbsp;&nbsp;&nbsp;&nbsp;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2<br>&gt; };<br>&gt;<br>&gt; Here period_bytes_min are is as the maximum period size to use just one PCM.
<br>&gt;<br>&gt; #define snd_toneport_period_elapsed(old, new) \<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; (new &gt;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2) || \<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; ((old &lt; TONEPORT_48000_24_PACKET_SIZE_OUT * 2) &amp;&amp; \<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(new &gt;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2))
<br>&gt;<br>&gt; This one should test if a period is elapsed based on the old playback<br>&gt; position (I see other drivers call such pointers hwptr) and the new one<br>&gt; (before this last is &quot;normalized&quot;).<br>
&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* null urb trasfer's completition callback<br>&gt;&nbsp;&nbsp;*/<br>&gt; static void snd_toneport_playback_complete_first(struct urb* urb,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip(substream);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(urb-&gt;transfer_buffer, runtime-&gt;dma_area,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size * 2);
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_toneport_playback_complete;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; usb_submit_urb(urb, GFP_ATOMIC);<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* playback transfers' completition callback<br>&gt;&nbsp;&nbsp;*/<br>
&gt; static void snd_toneport_playback_complete(struct urb* urb,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip(substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int new_pos = chip-&gt;playback_pos + chip-&gt;playback_packet_size * 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int offs;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (new_pos &lt;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2) {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(urb-&gt;transfer_buffer,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runtime-&gt;dma_area + chip-&gt;playback_pos,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size * 2);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offs = TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2 -
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(urb-&gt;transfer_buffer,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runtime-&gt;dma_area + chip-&gt;playback_pos,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offs);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(urb-&gt;transfer_buffer + new_pos,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runtime-&gt;dma_area,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size * 2 - offs);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (snd_toneport_period_elapsed(chip-&gt;playback_pos, new_pos)) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_pos &gt;= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_pos -= TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = new_pos;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed(substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = new_pos;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;status &amp; TONEPORT_STATUS_PLAYBACK)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usb_submit_urb(urb, GFP_ATOMIC);<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* hw_params callback<br>&gt;&nbsp;&nbsp;*<br>&gt;&nbsp;&nbsp;* TODO: capture and full duplex
<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int snd_toneport_pcm_hw_params(snd_pcm_substream_t *substream,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_hw_params_t *hw_params)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip(substream);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char msg[] = TONEPORT_MSG_3;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int alt, err;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; alt = (params_format(hw_params) == SNDRV_PCM_FORMAT_S16_LE) ? 1 : 3;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((params_rate(hw_params) == 44100))<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alt++;
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((err = usb_set_interface(chip-&gt;dev, 0, alt)) &lt; 0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;altsetting = alt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if ((err = snd_toneport_submit_control_transfer(chip-&gt;dev, msg)) &lt; 0)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size = out_sizes[alt - 1];<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip-&gt;playback_urb) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb = usb_alloc_urb(2, GFP_KERNEL);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;dev = chip-&gt;dev;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;pipe = usb_sndisocpipe(chip-&gt;dev, 1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;context = substream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;transfer_flags = URB_ISO_ASAP |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; URB_NO_TRANSFER_DMA_MAP;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;interval = 1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;number_of_packets = 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;iso_frame_desc[0].offset = 0;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usb_buffer_free(chip-&gt;dev, chip-&gt;playback_packet_size * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;transfer_buffer,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;transfer_dma);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!(chip-&gt;playback_urb-&gt;transfer_buffer =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usb_buffer_alloc(chip-&gt;dev, chip-&gt;playback_packet_size * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL, &amp;chip-&gt;playback_urb-&gt;transfer_dma)))
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;transfer_buffer_length =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size * 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;iso_frame_desc[0].length =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;iso_frame_desc[1].offset =
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;iso_frame_desc[1].length =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return snd_pcm_lib_malloc_pages(substream,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2);
<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* trigger callback<br>&gt;&nbsp;&nbsp;*/<br>&gt; static int snd_toneport_pcm_trigger(snd_pcm_substream_t *substream, int cmd)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip(substream);
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; switch (cmd) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; case SNDRV_PCM_TRIGGER_START:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(chip-&gt;playback_urb-&gt;transfer_buffer, 0,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_packet_size * 2);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = 0;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;status |= TONEPORT_STATUS_PLAYBACK;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_urb-&gt;complete =<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_toneport_playback_complete_first;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return usb_submit_urb(chip-&gt;playback_urb, GFP_ATOMIC);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; case SNDRV_PCM_TRIGGER_STOP:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;status &amp;= ~TONEPORT_STATUS_PLAYBACK;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&gt; }<br>&gt;<br>&gt; /*<br>&gt;&nbsp;&nbsp;* pointer callback<br>&gt;&nbsp;&nbsp;*/<br>&gt; static snd_pcm_uframes_t snd_toneport_pcm_pointer(<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_substream_t* substream)<br>
&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip(substream);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return bytes_to_frames(substream-&gt;runtime, chip-&gt;playback_pos);<br>&gt; }<br>&gt;<br>&gt; As you can see I chose to store the playback position in bytes instead of
<br>&gt; frames because I have 6-bytes frames and 4-bytes frames (depends on the<br>&gt; format).<br>&gt; Also TONEPORT_48000_24_PACKET_SIZE_OUT * 2 * 2 is the alsa buffer size.<br>&gt; Thanks,<br>&gt;<br>&gt; Stefano<br>
&gt;<br>&gt;<br><br><br>--<br>Markus Rechberger<br></blockquote></div><br>

------=_Part_151692_14765250.1155761173607--


--===============0404769780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0404769780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0404769780==--
