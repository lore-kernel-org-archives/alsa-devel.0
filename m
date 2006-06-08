From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Fwd:  USB sound card driver - Line6 Toneport UX1
Date: Fri, 9 Jun 2006 01:02:41 +0200
Message-ID: <160c13350606081602g379c2368n35b799767c43d2ce@mail.gmail.com>
References: <160c13350606080943v3171dc13je7160710b847de29@mail.gmail.com>
	<20060608175748.GB5868@turing.informatik.uni-halle.de>
	<160c13350606081602l697bd395t892a23b92ed8deab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035942650=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <160c13350606081602l697bd395t892a23b92ed8deab@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============2035942650==
Content-Type: multipart/alternative;
	boundary="----=_Part_13055_27676710.1149807761425"

------=_Part_13055_27676710.1149807761425
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---------- Forwarded message ----------
From: Stefano D'Angelo <zanga.mail@gmail.com>
Date: 9-giu-2006 1.02
Subject: Re: [Alsa-devel] USB sound card driver - Line6 Toneport UX1
To: Clemens Ladisch <clemens@ladisch.de>



2006/6/8, Clemens Ladisch <clemens@ladisch.de>:

> Stefano D'Angelo wrote:
> > where do I actually have to submit urbs?  In which callback?
>
> The first time in the trigger callback, then in the URB's completion
> callback.
>
>
> HTH
> Clemens
>

I just can't get it working... here's the code I've written:

static void snd_line6_tp_ux1_complete_playback_transfer (struct urb* urb,
                                                         struct pt_regs*
regs)
{
    snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb->context);
    struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
    snd_pcm_runtime_t *runtime = substream->runtime;

    urb->dev = chip->dev;
    urb->transfer_dma = runtime->dma_addr;
    urb->transfer_buffer = usb_buffer_alloc (urb->dev,
LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL, &urb->transfer_dma);
    memcpy (urb->transfer_buffer, runtime->dma_area + chip->playback_pos *
2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);
    urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;

    usb_submit_urb (urb, GFP_ATOMIC);

    chip->playback_pos += LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 / 4;
    snd_pcm_period_elapsed (substream);
}

don't care about freeing, etc. The problem is that it gives me a kind of
beep sound for anything I play. No underruns, etc., just that sound!
URBs' data seems to be correct and also the transfer seems to happen with no
particular problem. (no error checking right now however).
Another thing is this: I've seen that you decrement the hardware pointer
when it reaches the end of a period, but when I try to do this, it gives me
back garbage values, how is this possible?
What do you think I should do?

------=_Part_13055_27676710.1149807761425
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>---------- Forwarded message ----------<br><span class="gmail_quote">From: <b class="gmail_sendername">Stefano D'Angelo</b> &lt;<a href="mailto:zanga.mail@gmail.com">zanga.mail@gmail.com</a>&gt;<br>Date: 9-giu-2006 
1.02<br>Subject: Re: [Alsa-devel] USB sound card driver - Line6 Toneport UX1<br>To: Clemens Ladisch &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt;<br><br></span><div><br><br><div><span class="gmail_quote">
2006/6/8, Clemens Ladisch &lt;<a href="mailto:clemens@ladisch.de" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">clemens@ladisch.de</a>&gt;:</span></div><div><span class="e" id="q_10bb5e1aa88fb86d_1">
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Stefano D'Angelo wrote:<br>&gt; where do I actually have to submit urbs?&nbsp;&nbsp;In which callback?<br><br>The first time in the trigger callback, then in the URB's completion<br>callback.<br><br><br>HTH<br>Clemens<br></blockquote>
</span></div><div>
</div><br>I just can't get it working... here's the code I've written:<br><br>static void snd_line6_tp_ux1_complete_playback_transfer (struct urb* urb,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)
<br>{<br>&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;
<br><br>&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_dma = runtime-&gt;dma_addr;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = usb_buffer_alloc (urb-&gt;dev, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL, &amp;urb-&gt;transfer_dma);
<br>&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, runtime-&gt;dma_area + chip-&gt;playback_pos * 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;<br><br>&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_ATOMIC);
<br><br>&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos += LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 / 4;<br>&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);<br>}<br><br>don't care about freeing, etc. The problem is that it gives me a kind of beep sound for anything I play. No underruns, etc., just that sound!
<br>URBs' data seems to be correct and also the transfer seems to happen with no particular problem. (no error checking right now however).<br>Another thing is this: I've seen that you decrement the hardware pointer when it reaches the end of a period, but when I try to do this, it gives me back garbage values, how is this possible?
<br>What do you think I should do?<br>

</div>

------=_Part_13055_27676710.1149807761425--


--===============2035942650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2035942650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2035942650==--
