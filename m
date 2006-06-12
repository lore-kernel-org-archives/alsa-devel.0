From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Line6 Toneport UX1 driver
Date: Mon, 12 Jun 2006 09:54:09 +0100
Message-ID: <160c13350606120154s399fbf46tb9e0c77bfe347220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1357423919=="
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

--===============1357423919==
Content-Type: multipart/alternative;
	boundary="----=_Part_14903_22911511.1150102449991"

------=_Part_14903_22911511.1150102449991
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

> Stefano D'Angelo wrote:
> >    urb->transfer_dma = runtime->dma_addr;
>
> This will always play the data at the beginning of the buffer.


fixed

>    urb->transfer_buffer = usb_buffer_alloc (urb->dev,
> > LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL,
> &urb->transfer_dma);
>
> This buffer should be allocated when the URB is allocated.


fixed

>    memcpy (urb->transfer_buffer, runtime->dma_area + chip->playback_pos *
> > 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);
>
> I hope the buffer size is a multiple of PACKET_SIZE_OUT * 2.
>

yes, it is

>    urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
>
> Why the NO_TRANSFER_DMA_MAP?  You shouldn't need to do such
> optimizations in the first version of the driver.


ok, put it out

 >    snd_pcm_period_elapsed (substream);
>
> What is the period size?


period size is 96 = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 (double
buffering) / 2 (16 bit data), so everytime an urb is sent a period elapses.

Here is how I'm doing right now but I still got the same beep for everything
I play (when I used the copy () callback it kind of worked, is perphaps
possible that this USB soundcard doesn't support dma transfers?):


static void snd_line6_tp_ux1_complete_playback_transfer (struct urb* urb,
                                                         struct pt_regs*
regs)
{
    snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb->context);
    struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
    snd_pcm_runtime_t *runtime = substream->runtime;

    chip->playback_pos += LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 / 2;
    if (chip->playback_pos == runtime->buffer_size) {
        chip->playback_pos -= runtime->buffer_size;

    }

    memcpy (urb->transfer_buffer, runtime->dma_area + chip->playback_pos *
2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);

    snd_pcm_period_elapsed (substream);

    usb_submit_urb (urb, GFP_ATOMIC);
}

static int snd_line6_tp_ux1_pcm_trigger (snd_pcm_substream_t *substream,
                                         int cmd)

{
    struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
    snd_pcm_runtime_t *runtime = substream->runtime;
    static struct urb* urb;

    switch (cmd) {
    case SNDRV_PCM_TRIGGER_START:
        urb = usb_alloc_urb (2, GFP_ATOMIC);
        urb->dev = chip->dev;
        urb->pipe = usb_sndisocpipe (urb->dev, 1);
        urb->complete = snd_line6_tp_ux1_complete_playback_transfer;
        urb->context = substream;

        urb->transfer_dma = runtime->dma_addr;
        urb->transfer_buffer = usb_buffer_alloc (urb->dev,
                 LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_ATOMIC,
                 &urb->transfer_dma);
        memcpy (urb->transfer_buffer, runtime->dma_area,
                            LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);

        urb->transfer_flags = URB_ISO_ASAP; // | URB_NO_TRANSFER_DMA_MAP;
        urb->interval = 1;
        urb->number_of_packets = 2;
        urb->iso_frame_desc[0].offset = 0;
        urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
        urb->iso_frame_desc[1].length =
                                 LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;
        chip->playback_pos = 0;
        usb_submit_urb (urb, GFP_KERNEL);
            break;
    case SNDRV_PCM_TRIGGER_STOP:
        usb_buffer_free (chip->dev,

                         LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
                         urb->transfer_buffer, urb->transfer_dma);
        usb_free_urb (urb);
            break;
    default:
            return -EINVAL;
        break;
    }

    return 0;
}

Thanks, Stefano

------=_Part_14903_22911511.1150102449991
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><span>
Stefano D'Angelo wrote:</span><br><span>&gt;&nbsp;&nbsp;&nbsp;&nbsp;urb-&gt;transfer_dma = runtime-&gt;dma_addr;</span><br><span></span><br><span>This will always play the data at the beginning of the buffer.</span></blockquote><div><br>fixed
<br><span><br></span><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><span>&gt;&nbsp;&nbsp;&nbsp;&nbsp;urb-&gt;transfer_buffer = usb_buffer_alloc (urb-&gt;dev,</span>
<br><span>&gt; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL, &amp;urb-&gt;transfer_dma);</span><br><span></span><br><span>This buffer should be allocated when the URB is allocated.</span></blockquote></div><br>fixed
<br><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><span>&gt;&nbsp;&nbsp;&nbsp;&nbsp;memcpy (urb-&gt;transfer_buffer, runtime-&gt;dma_area + chip-&gt;playback_pos *
</span><br><span>&gt; 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);</span><br><span></span><br><span>I hope the buffer size is a multiple of PACKET_SIZE_OUT * 2.</span><br></blockquote><br>yes, it is<br><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">
<span>

&gt;&nbsp;&nbsp;&nbsp;&nbsp;urb-&gt;transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;</span><br><span></span><br><span>Why the NO_TRANSFER_DMA_MAP?&nbsp;&nbsp;You shouldn't need to do such</span><br><span>optimizations in the first version of the driver.
</span></blockquote><div><br>ok, put it out<br><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">&nbsp;<span>&gt;&nbsp;&nbsp;&nbsp;&nbsp;snd_pcm_period_elapsed (substream);
</span><br><span></span><br><span>What is the period size?</span></blockquote></div><br>period size is 96 = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 (double buffering) / 2 (16 bit data), so everytime an urb is sent a period elapses.
<br><br><div>Here
is how I'm doing right now but I still got the same beep for everything
I play (when I used the copy () callback it kind of worked, is perphaps
possible that this USB soundcard doesn't support dma transfers?):
</div><div><span><br></span></div><br><div><span>static void snd_line6_tp_ux1_complete_playback_transfer (struct urb* urb,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)<br>{<br>&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);
<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;<br><br></span></div><div>&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos += LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 / 2;
<br>
&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos == runtime-&gt;buffer_size) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;playback_pos -= runtime-&gt;buffer_size;</div><div><span><br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, runtime-&gt;dma_area + chip-&gt;playback_pos * 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);
<br><br></span></div><div><span>&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);<br><br></span></div><div><span>&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_ATOMIC);<br>}<br><br></span></div><div>static int snd_line6_tp_ux1_pcm_trigger (snd_pcm_substream_t *substream,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cmd)
</div><div><span><br>{<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;<br></span></div><div>&nbsp;&nbsp;&nbsp; static struct urb* urb;<br><br>
&nbsp;&nbsp;&nbsp; switch (cmd) {<br>&nbsp;&nbsp;&nbsp; case SNDRV_PCM_TRIGGER_START:
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_line6_tp_ux1_complete_playback_transfer;
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;context = substream;</div><div><span><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;transfer_dma = runtime-&gt;dma_addr;<br></span></div><div><span>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = usb_buffer_alloc (urb-&gt;dev,
<br></span></div><div>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_ATOMIC,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;urb-&gt;transfer_dma);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, runtime-&gt;dma_area,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);</div><div><span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP; // | URB_NO_TRANSFER_DMA_MAP;
<br></span></div><div>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length =
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = 0;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_KERNEL);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; case SNDRV_PCM_TRIGGER_STOP:<br>

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; usb_buffer_free (chip-&gt;dev,
</div><div><span><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br></span></div>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer, urb-&gt;transfer_dma);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; usb_free_urb (urb);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; default:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EINVAL;
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>Thanks, Stefano<br>

------=_Part_14903_22911511.1150102449991--


--===============1357423919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1357423919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1357423919==--
