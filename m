From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Line6 Toneport UX1 driver again
Date: Sat, 8 Jul 2006 18:14:15 +0200
Message-ID: <160c13350607080914t3db9724cnb5920e7a133d2f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120498811=="
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

--===============2120498811==
Content-Type: multipart/alternative;
	boundary="----=_Part_8348_32661238.1152375255962"

------=_Part_8348_32661238.1152375255962
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Excuse me if I'm repeatedly asking the same things, but I still can't
understand how some stuff works probably.
I have these lines of code:

static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {
    .info             = SNDRV_PCM_INFO_INTERLEAVED |
                        SNDRV_PCM_INFO_BLOCK_TRANSFER,
    .formats          = SNDRV_PCM_FMTBIT_S16_LE,
    .rates            = SNDRV_PCM_RATE_48000,
    .rate_min         = 48000,
    .rate_max         = 48000,
    .channels_min     = 2,
    .channels_max     = 2,
    /* double buffering */
    .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 * 2,
    .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
    .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
    .periods_min      = 1,
    .periods_max      = 2
};

and then also:

static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (
                                               snd_pcm_substream_t*
substream)
{
    struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);

    printk ("pos: %d\n", chip->playback_pos);
    return chip->playback_pos;
}

static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t *substream,
                                           int channel, snd_pcm_uframes_t
pos,
                                           void *src, snd_pcm_uframes_t
count)
{
    struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
    snd_pcm_runtime_t *runtime = substream->runtime;
    static struct urb* urb;

    int i = 0;
    static int j = 0;

    urb = usb_alloc_urb (2, GFP_ATOMIC);
    urb->dev = chip->dev;
    urb->pipe = usb_sndisocpipe (urb->dev, 1);
    urb->complete = snd_line6_tp_ux1_complete_playback_transfer;
    urb->context = substream;
    urb->transfer_buffer = kmalloc (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT *
2, GFP_ATOMIC);
    urb->transfer_buffer_length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2;
    urb->transfer_flags = URB_ISO_ASAP;

    memcpy (urb->transfer_buffer, src, count * 2 * 2);

    for (; i < LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {
        printk ("%d\n", ((s16*)urb->transfer_buffer)[i]);
    }
    printk ("---------\n");

    urb->interval = 1;
    urb->number_of_packets = 2;
    urb->iso_frame_desc[0].offset = 0;
    urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
    urb->iso_frame_desc[1].length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;
    if (chip->playback_pos)
        chip->playback_pos = 0;
    else
        chip->playback_pos = count;
    j++;
    printk (":: %d %d %d\n", j, chip->playback_pos, runtime->buffer_size);
    snd_pcm_period_elapsed (substream);
    usb_submit_urb (urb, GFP_KERNEL);

    return count;
}

Don't care about printk()s and codying style, count in the copy callback is
always 96, which is the # of frames of a period, so everytime the copy
callback is called, a period is elapsed. Since the buffer is long 2 periods,
the playback position pointer should be either 0 or 96, I think (beginning
or half of the buffer).
Now, instead of working as expected, the copy callback just works twice, for
the first two periods (one buffer length). Then the pointer becomes 0 and I
can't understand why the playback stops.
Please help! I have some people who keep on asking me about the driver, and
it's a pity that I can't overcome such simple problems and let them use
their sound card!
Thanks,
Stefano

------=_Part_8348_32661238.1152375255962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Excuse me if I'm repeatedly asking the same things, but I still can't understand how some stuff works probably.<br>I have these lines of code:<br><br>static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {<br>&nbsp;&nbsp;&nbsp; .info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_INFO_INTERLEAVED |
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_INFO_BLOCK_TRANSFER,<br>&nbsp;&nbsp;&nbsp; .formats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_FMTBIT_S16_LE,<br>&nbsp;&nbsp;&nbsp; .rates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SNDRV_PCM_RATE_48000,<br>&nbsp;&nbsp;&nbsp; .rate_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,<br>&nbsp;&nbsp;&nbsp; .rate_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 48000,
<br>&nbsp;&nbsp;&nbsp; .channels_min&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&nbsp;&nbsp;&nbsp; .channels_max&nbsp;&nbsp;&nbsp;&nbsp; = 2,<br>&nbsp;&nbsp;&nbsp; /* double buffering */<br>&nbsp;&nbsp;&nbsp; .buffer_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2 * 2,<br>&nbsp;&nbsp;&nbsp; .period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,
<br>&nbsp;&nbsp;&nbsp; .period_bytes_max = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2,<br>&nbsp;&nbsp;&nbsp; .periods_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1,<br>&nbsp;&nbsp;&nbsp; .periods_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 2<br>};<br><br>and then also:<br><br>static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_substream_t* substream)<br>{<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br><br>&nbsp;&nbsp;&nbsp; printk (&quot;pos: %d\n&quot;, chip-&gt;playback_pos);
<br>&nbsp;&nbsp;&nbsp; return chip-&gt;playback_pos;<br>}<br><br>static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t *substream,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int channel, snd_pcm_uframes_t pos,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *src, snd_pcm_uframes_t count)
<br>{<br>&nbsp;&nbsp;&nbsp; struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);<br>&nbsp;&nbsp;&nbsp; snd_pcm_runtime_t *runtime = substream-&gt;runtime;<br>&nbsp;&nbsp;&nbsp; static struct urb* urb;<br><br>&nbsp;&nbsp;&nbsp; int i = 0;<br>&nbsp;&nbsp;&nbsp; static int j = 0;<br>
<br>&nbsp;&nbsp;&nbsp; urb = usb_alloc_urb (2, GFP_ATOMIC);<br>&nbsp;&nbsp;&nbsp; urb-&gt;dev = chip-&gt;dev;<br>&nbsp;&nbsp;&nbsp; urb-&gt;pipe = usb_sndisocpipe (urb-&gt;dev, 1);<br>&nbsp;&nbsp;&nbsp; urb-&gt;complete = snd_line6_tp_ux1_complete_playback_transfer;<br>&nbsp;&nbsp;&nbsp; urb-&gt;context = substream;
<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer = kmalloc (LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_ATOMIC);<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_buffer_length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2;<br>&nbsp;&nbsp;&nbsp; urb-&gt;transfer_flags = URB_ISO_ASAP;
<br><br>&nbsp;&nbsp;&nbsp; memcpy (urb-&gt;transfer_buffer, src, count * 2 * 2);<br><br>&nbsp;&nbsp;&nbsp; for (; i &lt; LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT; i++) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk (&quot;%d\n&quot;, ((s16*)urb-&gt;transfer_buffer)[i]);<br>&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; printk (&quot;---------\n&quot;);<br><br>&nbsp;&nbsp;&nbsp; urb-&gt;interval = 1;<br>&nbsp;&nbsp;&nbsp; urb-&gt;number_of_packets = 2;<br>&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].offset = 0;<br>&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[0].length = urb-&gt;iso_frame_desc[1].offset =
<br>&nbsp;&nbsp;&nbsp; urb-&gt;iso_frame_desc[1].length = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT;<br>&nbsp;&nbsp;&nbsp; if (chip-&gt;playback_pos)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = 0;<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;playback_pos = count;<br>&nbsp;&nbsp;&nbsp; j++;<br>
&nbsp;&nbsp;&nbsp; printk (&quot;:: %d %d %d\n&quot;, j, chip-&gt;playback_pos, runtime-&gt;buffer_size);<br>&nbsp;&nbsp;&nbsp; snd_pcm_period_elapsed (substream);<br>&nbsp;&nbsp;&nbsp; usb_submit_urb (urb, GFP_KERNEL);<br><br>&nbsp;&nbsp;&nbsp; return count;<br>}<br><br>Don't care about printk()s and codying style, count in the copy callback is always 96, which is the # of frames of a period, so everytime the copy callback is called, a period is elapsed. Since the buffer is long 2 periods, the playback position pointer should be either 0 or 96, I think (beginning or half of the buffer).
<br>Now, instead of working as expected, the copy callback just works twice, for the first two periods (one buffer length). Then the pointer becomes 0 and I can't understand why the playback stops.<br>Please help! I have some people who keep on asking me about the driver, and it's a pity that I can't overcome such simple problems and let them use their sound card!
<br>Thanks,<br>Stefano<br>

------=_Part_8348_32661238.1152375255962--


--===============2120498811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2120498811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2120498811==--
