From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 Toneport UX1 driver again
Date: Tue, 11 Jul 2006 14:59:40 +0200
Message-ID: <160c13350607110559v28640db3x7abc13946b58adca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1853466436=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--===============1853466436==
Content-Type: multipart/alternative;
	boundary="----=_Part_26087_2453946.1152622780758"

------=_Part_26087_2453946.1152622780758
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/7/11, Takashi Iwai <tiwai@suse.de>:

> At Sat, 8 Jul 2006 18:14:15 +0200,
> Stefano D'Angelo wrote:
> >
> > Excuse me if I'm repeatedly asking the same things, but I still can't
> understand how
> > some stuff works probably.
> > I have these lines of code:
> >
> > static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {
> >     .info             = SNDRV_PCM_INFO_INTERLEAVED |
> >                         SNDRV_PCM_INFO_BLOCK_TRANSFER,
> >     .formats          = SNDRV_PCM_FMTBIT_S16_LE,
> >     .rates            = SNDRV_PCM_RATE_48000,
> >     .rate_min         = 48000,
> >     .rate_max         = 48000,
> >     .channels_min     = 2,
> >     .channels_max     = 2,
> >     /* double buffering */
> >     .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 * 2,
> >     .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> >     .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> >     .periods_min      = 1,
> >     .periods_max      = 2
> > };
> >
> > and then also:
> >
> > static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (
> >                                                snd_pcm_substream_t*
> substream)
> > {
> >     struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
> >
> >     printk ("pos: %d\n", chip->playback_pos);
> >     return chip->playback_pos;
> > }
> >
> > static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t
> *substream,
> >                                            int channel,
> snd_pcm_uframes_t pos,
> >                                            void *src, snd_pcm_uframes_t
> count)
> > {
> >     struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
> >     snd_pcm_runtime_t *runtime = substream->runtime;
> >     static struct urb* urb;
> >
> >     int i = 0;
> >     static int j = 0;
> >
> >     urb = usb_alloc_urb (2, GFP_ATOMIC);
> >     urb->dev = chip->dev;
> >     urb->pipe = usb_sndisocpipe (urb->dev, 1);
> >     urb->complete = snd_line6_tp_ux1_complete_playback_transfer;
> >     urb->context = substream;
> >     urb->transfer_buffer = kmalloc
> (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
> > GFP_ATOMIC);
> >     urb->transfer_buffer_length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT
> * 2;
> >     urb->transfer_flags = URB_ISO_ASAP;
> >
> >     memcpy (urb->transfer_buffer, src, count * 2 * 2);
> >
> >     for (; i < LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {
> >         printk ("%d\n", ((s16*)urb->transfer_buffer)[i]);
> >     }
> >     printk ("---------\n");
> >
> >     urb->interval = 1;
> >     urb->number_of_packets = 2;
> >     urb->iso_frame_desc[0].offset = 0;
> >     urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
> >     urb->iso_frame_desc[1].length =
> LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;
> >     if (chip->playback_pos)
> >         chip->playback_pos = 0;
> >     else
> >         chip->playback_pos = count;
> >     j++;
> >     printk (":: %d %d %d\n", j, chip->playback_pos,
> runtime->buffer_size);
> >     snd_pcm_period_elapsed (substream);
> >     usb_submit_urb (urb, GFP_KERNEL);
> >
> >     return count;
> > }
> >
> > Don't care about printk()s and codying style, count in the copy callback
> is always 96,
> > which is the # of frames of a period, so everytime the copy callback is
> called, a
> > period is elapsed. Since the buffer is long 2 periods, the playback
> position pointer
> > should be either 0 or 96, I think (beginning or half of the buffer).
> > Now, instead of working as expected, the copy callback just works twice,
> for the first
> > two periods (one buffer length). Then the pointer becomes 0 and I can't
> understand why
> > the playback stops.
> > Please help! I have some people who keep on asking me about the driver,
> and it's a
> > pity that I can't overcome such simple problems and let them use their
> sound card!
>
> Calling snd_pcm_period_elapsed() in copy callback doesn't make sense.
> The copy callback is called when the PCM core requires something to
> copy.
>
> In general, all PCM driver callbacks are passive.  They need to do
> only what they are requested.   The role of copy callback is to copy
> the given user-space data to the hardware buffer.  The role of pointer
> callback is to return the current (DMA) transfer position in the ring
> buffer.  The role of trigger callback is to start or stop the PCM
> stream...
>
> In the ALSA PCM model, there are some assumptions:
>
> 1. You have a ring buffer containing PCM data.
> 2. DMA is running at constant rate, transferring the data in
>    background and updating the position.
>
> Usually, the DMA controller issues an interrupt when a given size of
> data ("period" in ALSA term) is processed.  The driver calls
> snd_pcm_period_elapsed() in the interrupt handler, then.
>
> However, in the case of USB devices, it's a bit tricky, because the
> transfer is done via non-continuous packets.  To overcome this,
> snd-usb-audio allocates a ring-buffer via vmalloc() in hw_params
> callback.  The PCM core copies the user-space data to the ring-buffer,
> and the driver copies the data from the ring-buffer to each urb
> appropriately.
>
> The first trigger-start callback prepares the urbs (with data copy
> from ring-buffer) and submit them.  When urb-complete callback is
> called, the driver updates the current position, then *here* calls
> snd_pcm_period_elapsed() if the pre-given period size was already
> processed.  Then, copy the data to urb, and re-submit it.
>
>
> Takashi
>

Thanks a lot, however I realized that just yesterday and I think I fixed the
whole thing, 48kHz 16-bits stereo output works properly now (just a little
problem occours, some overruns at the beginning of the output, but I think I
know how to fix it).
Since I've got a person who owns a Line6 TonePort UX2 sound card and its'
likely that these sound cards share the same protocol, I sent him the driver
code and he will test it in the next days. So I renamed it as snd_toneport.
However I did this way (tell me if it is correct - just 48kHz 16-bits stereo
support now):

[...]

static snd_pcm_hardware_t snd_toneport_playback_hw = {

    .info             = SNDRV_PCM_INFO_INTERLEAVED |
                        SNDRV_PCM_INFO_BLOCK_TRANSFER,
    .formats          = SNDRV_PCM_FMTBIT_S16_LE,
    .rates            = SNDRV_PCM_RATE_48000,
    .rate_min         = 48000,
    .rate_max         = 48000,
    .channels_min     = 2,
    .channels_max     = 2,
    .buffer_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2 * 10,
    .period_bytes_min = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
    .period_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
    .periods_min      = 1,
    .periods_max      = 10
};

[...]

/*
 * playback transfers' completition callback
 *
 * TODO: error handling and full duplex
 */
static void snd_toneport_complete_playback_transfer (struct urb* urb,
    struct pt_regs* regs)
{
    snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb->context);
    struct snd_toneport *chip = snd_pcm_substream_chip (substream);

    chip->playback_pos += TONEPORT_48000_16_PACKET_SIZE_OUT / 2;
    if (chip->playback_pos >= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 * 10)
        chip->playback_pos -= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 *
            10;

    snd_pcm_period_elapsed (substream);

    kfree (urb->transfer_buffer);
    usb_free_urb (urb);
}

[...]

/*
 * copy callback
 */
static int snd_toneport_playback_copy (snd_pcm_substream_t *substream,

    int channel, snd_pcm_uframes_t pos, void *src, snd_pcm_uframes_t count)
{
    struct snd_toneport *chip = snd_pcm_substream_chip (substream);
    struct urb* urb;


    urb = usb_alloc_urb (2, GFP_ATOMIC);
    urb->dev = chip->dev;
    urb->pipe = usb_sndisocpipe (urb->dev, 1);
    urb->complete = snd_toneport_complete_playback_transfer;
    urb->context = substream;
    urb->transfer_buffer = kmalloc (TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
        GFP_ATOMIC);
    urb->transfer_buffer_length = TONEPORT_48000_16_PACKET_SIZE_OUT * 2;

    urb->transfer_flags = URB_ISO_ASAP;
    memcpy (urb->transfer_buffer, src, count * 2 * 2);
    urb->interval = 1;
    urb->number_of_packets = 2;
    urb->iso_frame_desc[0].offset = 0;
    urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
    urb->iso_frame_desc[1].length = TONEPORT_48000_16_PACKET_SIZE_OUT;
    usb_submit_urb (urb, GFP_ATOMIC);

    return count;
}

[...]

I tried without a copy callback via DMA transfers (if I'm not wrong also
snd-usb-audio does this way) but it just didn't work (maybe the card does
not support DMA?)
However thanks a lot again!

Stefano

------=_Part_26087_2453946.1152622780758
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>2006/7/11, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">tiwai@suse.de</a>&gt;:</div><div><span class="q" id="q_10c5da95686556fe_1"><div><span class="gmail_quote">
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
At Sat, 8 Jul 2006 18:14:15 +0200,<br>Stefano D'Angelo wrote:<br>&gt;<br>&gt; Excuse me if I'm repeatedly asking the same things, but I still can't understand how<br>&gt; some stuff works probably.<br>&gt; I have these lines of code:
<br>&gt;<br>&gt; static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_INFO_INTERLEAVED |<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_FMTBIT_S16_LE,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= SNDRV_PCM_RATE_48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; /* double buffering */
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2<br>&gt; };<br>&gt;<br>&gt; and then also:<br>&gt;<br>&gt; static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;snd_pcm_substream_t* substream)
<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;pos: %d\n&quot;, chip-&gt;playback_pos);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return chip-&gt;playback_pos;<br>&gt; }<br>

&gt;<br>&gt; static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t *substream,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int channel, snd_pcm_uframes_t pos,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void *src, snd_pcm_uframes_t count)
<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; static struct urb* urb;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; int i = 0;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; static int j = 0;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_line6_tp_ux1_complete_playback_transfer;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;context = substream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = kmalloc (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br>&gt; GFP_ATOMIC);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer_length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, src, count * 2 * 2);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (; i &lt; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;%d\n&quot;, ((s16*)urb-&gt;transfer_buffer)[i]);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;---------\n&quot;);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; else<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = count;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; j++;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; printk (&quot;:: %d %d %d\n&quot;, j, chip-&gt;playback_pos, runtime-&gt;buffer_size);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_KERNEL);<br>&gt;<br>

&gt;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>&gt; }<br>&gt;<br>&gt; Don't care about printk()s and codying style, count in the copy callback is always 96,<br>&gt; which is the # of frames of a period, so everytime the copy callback is called, a
<br>&gt; period is elapsed. Since the buffer is long 2 periods, the playback position pointer<br>&gt; should be either 0 or 96, I think (beginning or half of the buffer).<br>&gt; Now, instead of working as expected, the copy callback just works twice, for the first
<br>&gt; two periods (one buffer length). Then the pointer becomes 0 and I can't understand why<br>&gt; the playback stops.<br>&gt; Please help! I have some people who keep on asking me about the driver, and it's a<br>&gt; pity that I can't overcome such simple problems and let them use their sound card!
<br><br>Calling snd_pcm_period_elapsed() in copy callback doesn't make sense.<br>The copy callback is called when the PCM core requires something to<br>copy.<br><br>In general, all PCM driver callbacks are passive.&nbsp;&nbsp;They need to do
<br>only what they are requested.&nbsp;&nbsp; The role of copy callback is to copy<br>the given user-space data to the hardware buffer.&nbsp;&nbsp;The role of pointer<br>callback is to return the current (DMA) transfer position in the ring<br>

buffer.&nbsp;&nbsp;The role of trigger callback is to start or stop the PCM<br>stream...<br><br>In the ALSA PCM model, there are some assumptions:<br><br>1. You have a ring buffer containing PCM data.<br>2. DMA is running at constant rate, transferring the data in
<br>&nbsp;&nbsp; background and updating the position.<br><br>Usually, the DMA controller issues an interrupt when a given size of<br>data (&quot;period&quot; in ALSA term) is processed.&nbsp;&nbsp;The driver calls<br>snd_pcm_period_elapsed() in the interrupt handler, then.
<br><br>However, in the case of USB devices, it's a bit tricky, because the<br>transfer is done via non-continuous packets.&nbsp;&nbsp;To overcome this,<br>snd-usb-audio allocates a ring-buffer via vmalloc() in hw_params<br>callback.&nbsp;&nbsp;The PCM core copies the user-space data to the ring-buffer,
<br>and the driver copies the data from the ring-buffer to each urb<br>appropriately.<br><br>The first trigger-start callback prepares the urbs (with data copy<br>from ring-buffer) and submit them.&nbsp;&nbsp;When urb-complete callback is
<br>called, the driver updates the current position, then *here* calls<br>snd_pcm_period_elapsed() if the pre-given period size was already<br>processed.&nbsp;&nbsp;Then, copy the data to urb, and re-submit it.<br><br><br>Takashi<br>

</blockquote></div><br></span></div><div>Thanks a lot, however I
realized that just yesterday and I think I fixed the whole thing, 48kHz
16-bits stereo output works properly now (just a little problem
occours, some overruns at the beginning of the output, but I think I
know how to fix it).
<br>Since I've got a person who owns a Line6 TonePort UX2 sound card
and its' likely that these sound cards share the same protocol, I sent
him the driver code and he will test it in the next days. So I renamed
it as snd_toneport.
<br>However I did this way (tell me if it is correct - just 48kHz 16-bits stereo support now):<br><br>[...]<br><br>static snd_pcm_hardware_t snd_toneport_playback_hw = {</div><div><span class="q"><br>&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_INFO_INTERLEAVED |
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER,<br>&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_FMTBIT_S16_LE,<br>&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_RATE_48000,<br>&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,
<br>&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br></span></div><div>&nbsp;&nbsp;&nbsp; .buffer_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2 * 10,<br>&nbsp;&nbsp;&nbsp; .period_bytes_min = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,<br>&nbsp;&nbsp;&nbsp; .period_bytes_max = TONEPORT_48000_16_PACKET_SIZE_OUT * 2,
<br>&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1,<br>&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 10<br>};<br><br>[...]<br><br>/*<br>&nbsp;* playback transfers' completition callback<br>&nbsp;*<br>&nbsp;* TODO: error handling and full duplex<br>&nbsp;*/<br>static void snd_toneport_complete_playback_transfer (struct urb* urb,
<br>&nbsp;&nbsp;&nbsp; struct pt_regs* regs)<br>{<br>&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);<br>&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip (substream);<br><br>&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos += TONEPORT_48000_16_PACKET_SIZE_OUT / 2;
<br>&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos &gt;= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 * 10)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;playback_pos -= TONEPORT_48000_16_PACKET_SIZE_OUT / 2 *<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 10;</div><div><span class="q"><br>&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);
<br><br></span></div><div>&nbsp;&nbsp;&nbsp; kfree (urb-&gt;transfer_buffer);<br>&nbsp;&nbsp;&nbsp; usb_free_urb (urb);<br>}<br><br>[...]<br><br>/*<br>&nbsp;* copy callback<br>&nbsp;*/<br>static int snd_toneport_playback_copy (snd_pcm_substream_t *substream,</div>
<div><span class="q"><br>&nbsp;&nbsp;&nbsp; int channel, snd_pcm_uframes_t pos, void *src, snd_pcm_uframes_t count)
<br>{<br></span></div><div>&nbsp;&nbsp;&nbsp; struct snd_toneport *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; struct urb* urb;</div><div><span class="q"><br><br>&nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);<br>&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;
<br>&nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);
<br></span></div><div>&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_toneport_complete_playback_transfer;<br>&nbsp;&nbsp;&nbsp; urb-&gt;context = substream;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = kmalloc (TONEPORT_48000_16_PACKET_SIZE_OUT * 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; GFP_ATOMIC);
<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer_length = TONEPORT_48000_16_PACKET_SIZE_OUT * 2;
</div><div><span class="q"><br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP;<br>&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, src, count * 2 * 2);<br></span></div><div><span class="q">&nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;
<br>&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>
&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =<br></span></div><div>&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length = TONEPORT_48000_16_PACKET_SIZE_OUT;<br>&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_ATOMIC);<br><br>&nbsp;&nbsp;&nbsp; return count;
<br>}
<br><br>[...]<br><br>I tried without a copy callback via DMA transfers
(if I'm not wrong also snd-usb-audio does this way) but it just didn't
work (maybe the card does not support DMA?)<br>However thanks a lot again!<br></div><span class="sg"><br>
Stefano</span>

------=_Part_26087_2453946.1152622780758--


--===============1853466436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1853466436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1853466436==--
