From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Mon, 7 Oct 2013 15:58:51 +0100
Message-ID: <27085905.a7dazzfD9V@arial>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
 <1381048163.1974.5.camel@yoda.heavyware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A7E265119
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 17:03:37 +0200 (CEST)
In-Reply-To: <1381048163.1974.5.camel@yoda.heavyware>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guido Aulisi <guido.aulisi@gmail.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 07 October 2013 08:41:06 you wrote:
> Can anyone test whether the patch below works alone without the
> previous patch?  (Meanwhile, the previous patch to remove the frame
> check is fine, it's just too strict for controllers like ehci, so it's
> still fine to apply.)
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/usb/usx2y/usbusx2yaudio.c
> b/sound/usb/usx2y/usbusx2yaudio.c index 6234a51..1236ff3 100644
> --- a/sound/usb/usx2y/usbusx2yaudio.c
> +++ b/sound/usb/usx2y/usbusx2yaudio.c
> @@ -137,10 +137,12 @@ static int usX2Y_urb_play_prepare(struct
> snd_usX2Y_substream *subs, /* calculate the size of a packet */
>                 counts = cap_urb->iso_frame_desc[pack].actual_length /
> usX2Y->stride; count += counts;
> +#if 0
>                 if (counts < 43 || counts > 50) {
>                         snd_printk(KERN_ERR "should not be here with
> counts=%i\n", counts); return -EPIPE;
>                 }
> +#endif
>                 /* set up descriptor */
>                 urb->iso_frame_desc[pack].offset = pack ?
>                         urb->iso_frame_desc[pack - 1].offset +

For me, this patch alone fails in much the same way (possibly exactly the same 
way) as before the previous patch.

>From audacity (probably not much use unless you know the source code... I 
don't):

Expression 'PaAlsaStreamComponent_Initialize( &self->capture, alsaApi, 
inParams, StreamDirection_In, NULL != callback )' failed in 
'src/hostapi/alsa/pa_linux_alsa.c', line: 2092
Expression 'PaAlsaStream_Initialize( stream, alsaHostApi, inputParameters, 
outputParameters, sampleRate, framesPerBuffer, callback, streamFlags, userData 
)' failed in 'src/hostapi/alsa/pa_linux_alsa.c', line: 2764
Expression 'stream->playback.pcm' failed in 
'src/hostapi/alsa/pa_linux_alsa.c', line: 4541
Expression 'stream->playback.pcm' failed in 
'src/hostapi/alsa/pa_linux_alsa.c', line: 4541
^C


[I hit ^C because recording stalled]


nick@arial:/usr/src$ dmesg | tail
[  111.667015] usb 2-1.6.4: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  114.707156] Sequence Error!(hcd_frame=3 ep=8in;wait=1024,frame=0).
[  114.707156] Most probably some urb of usb-frame 1024 is still missing.
[  114.707156] Cause could be too long delays in usb-hcd interrupt handling.
[  574.566748] Sequence Error!(hcd_frame=3 ep=8in;wait=1024,frame=0).
[  574.566748] Most probably some urb of usb-frame 1024 is still missing.
[  574.566748] Cause could be too long delays in usb-hcd interrupt handling.
[  575.593918] Sequence Error!(hcd_frame=6 ep=8in;wait=1027,frame=3).
[  575.593918] Most probably some urb of usb-frame 1027 is still missing.
[  575.593918] Cause could be too long delays in usb-hcd interrupt handling.


Reverting to the previous patch, everything works fine:

[  170.252226] usb 2-1.6.4: USB disconnect, device number 5
[  173.012844] usb 2-1.6.4: new full-speed USB device number 7 using ehci-pci
[  173.105451] usb 2-1.6.4: New USB device found, idVendor=1604, 
idProduct=8006
[  173.105456] usb 2-1.6.4: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  175.372992] usb 2-1.6.4: USB disconnect, device number 7
[  177.109626] usb 2-1.6.4: new full-speed USB device number 8 using ehci-pci
[  177.202361] usb 2-1.6.4: New USB device found, idVendor=1604, 
idProduct=8007
[  177.202372] usb 2-1.6.4: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0


[no further messages]

Best stick with the original patch then :)

Nick/.
