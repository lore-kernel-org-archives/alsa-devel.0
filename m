From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Line6 Toneport UX1 driver
Date: Fri, 09 Jun 2006 15:00:19 +0200
Message-ID: <20060609130019.GA14601@turing.informatik.uni-halle.de>
References: <160c13350606090230m6d250030sd4f38d28bcde63e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <160c13350606090230m6d250030sd4f38d28bcde63e6@mail.gmail.com>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stefano D'Angelo <zanga.mail@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Stefano D'Angelo wrote:
>    urb->transfer_dma = runtime->dma_addr;

This will always play the data at the beginning of the buffer.

>    urb->transfer_buffer = usb_buffer_alloc (urb->dev,
> LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2, GFP_KERNEL, &urb->transfer_dma);

This buffer should be allocated when the URB is allocated.

>    memcpy (urb->transfer_buffer, runtime->dma_area + chip->playback_pos *
> 2, LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT * 2);

I hope the buffer size is a multiple of PACKET_SIZE_OUT * 2.

>    urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;

Why the NO_TRANSFER_DMA_MAP?  You shouldn't need to do such
optimizations in the first version of the driver.

>    snd_pcm_period_elapsed (substream);

What is the period size?


Regards,
Clemens
