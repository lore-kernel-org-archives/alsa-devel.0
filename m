From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 19:47:01 +1100
Message-ID: <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <562D376E.7000308@ladisch.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D31261519
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 09:47:03 +0100 (CET)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id 18996C06BF
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 19:47:02 +1100 (AEDT)
In-Reply-To: <562D376E.7000308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> > * Is my use of snd_pcm_set_params() missing something and if so what?
> 
> No.  But it does not set exactly the same parameters as the manual
> hw_params calls.
> 
> Please check for differences with snd_pcm_hw_params_dump()

That showed some differences. The params when its working:

    ACCESS:  RW_INTERLEAVED
    FORMAT:  S32_LE
    SUBFORMAT:  STD
    SAMPLE_BITS: 32
    FRAME_BITS: 64
    CHANNELS: 2
    RATE: 44100
    PERIOD_TIME: (5011 5012)
    PERIOD_SIZE: 221
    PERIOD_BYTES: 1768
    PERIODS: (593 594)
    BUFFER_TIME: (2972154 2972155)
    BUFFER_SIZE: 131072
    BUFFER_BYTES: 1048576
    TICK_TIME: 0

and the one that doesn't:

    ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
    FORMAT:  S32_LE
    SUBFORMAT:  STD
    SAMPLE_BITS: 32
    FRAME_BITS: 64
    CHANNELS: 2
    RATE: [44100 96000]
    PERIOD_TIME: [125 1486078)
    PERIOD_SIZE: [8 65536]
    PERIOD_BYTES: [64 524288]
    PERIODS: [2 1024]
    BUFFER_TIME: (166 2972155)
    BUFFER_SIZE: [16 131072]
    BUFFER_BYTES: [128 1048576]
    TICK_TIME: ALL

which seems rather odd!

> Which driver? 

snd_usb_audio

> Any messages in the system log?

Just the connect message when the device is plugged in:

    usb 1-1: new high-speed USB device number 43 using xhci_hcd
    usb 1-1: New USB device found, idVendor=1235, idProduct=8016
    usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
    usb 1-1: Product: Scarlett 2i2 USB
    usb 1-1: Manufacturer: Focusrite


> If less than the full number of frames have been read, you get a return
> value that is not an error code but a positive number.

Its definitely an error message. I changed the code to:


    if ((err = snd_pcm_readi (capture_handle, buffer, buffer_frames)) < 0) {
        printf ("Read from audio interface failed (%d, %s)\n", err, snd_strerror (err));
        break;
    }

and that results in:

    Read from audio interface failed (-5, Input/output error)

Cheers,
Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
