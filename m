From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Line6 Toneport UX1 driver
Date: Fri, 9 Jun 2006 11:30:29 +0200
Message-ID: <160c13350606090230m6d250030sd4f38d28bcde63e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1499412926=="
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

--===============1499412926==
Content-Type: multipart/alternative;
	boundary="----=_Part_20365_20026527.1149845429200"

------=_Part_20365_20026527.1149845429200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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

------=_Part_20365_20026527.1149845429200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just can't get it working... here's the code I've written:<br><br>static void snd_line6_tp_ux1_complete<div>_playback_transfer (struct urb* urb,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pt_regs* regs)
<br>{<br>&nbsp;&nbsp;&nbsp; snd_pcm_substream_t *substream = (snd_pcm_substream_t *)(urb-&gt;context);<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;
<br><br>&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_dma = runtime-&gt;dma_addr;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = usb_buffer_alloc (urb-&gt;dev, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL, &amp;urb-&gt;transfer_dma);
<br>&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, runtime-&gt;dma_area + chip-&gt;playback_pos * 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;<br><br>&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_ATOMIC);
<br><br>&nbsp;&nbsp;&nbsp; chip-&gt;playback_pos += LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 / 4;<br>&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);<br>}<br><br>don't
care about freeing, etc. The problem is that it gives me a kind of beep
sound for anything I play. No underruns, etc., just that sound!
<br>URBs' data seems to be correct and also the transfer seems to
happen with no particular problem. (no error checking right now
however).<br>Another thing is this: I've seen that you decrement the
hardware pointer when it reaches the end of a period, but when I try to
do this, it gives me back garbage values, how is this possible?
<br>What do you think I should do?<br>

</div>

------=_Part_20365_20026527.1149845429200--


--===============1499412926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1499412926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1499412926==--
