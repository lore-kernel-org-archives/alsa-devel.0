From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Trouble understanding ALSA's DMA buffers
Date: Tue, 12 Jun 2007 01:59:45 +0530
Message-ID: <8d6898730706111329y666c7abdv5b464cbe4e9bb3b@mail.gmail.com>
References: <466DA941.40309@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 14FFF103824
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 22:29:46 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2368350wag
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 13:29:45 -0700 (PDT)
In-Reply-To: <466DA941.40309@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Now ALSA (audio ) buffer is divided into periods, i.e. a chain of small packets.

periods size is configurable. Data transfer to the codec starts only
after reaching start_threshold point (start_threshold is in periods),
this time DMA trigger is called.

This trigger onwards application will get notification from the kernel
saying that period buffer is empty you can write into it.Till the end
of music file.

Nobin Mathew



On 6/12/07, Timur Tabi <timur@freescale.com> wrote:
> I'm writing an ALSA SOC driver for an I2S-based device, and I'm having a really hard time
> understanding how ALSA uses the DMA buffers.  And yes, I've read the documentation and
> studied some sample source code.
>
> I used to write audio drivers for a living, but that was many years ago, and it wasn't for
> Linux.  Perhaps the concepts in my head are outdated, but I just don't see enough
> explanation as to how DMA buffers are supposed to work.
>
> Back then, audio drivers used "ping pong" DMA buffers.  A single DMA buffer is allocated,
> and the audio hardware is programmed to read from that buffer in a loop.  That is, it
> would automatically restart reading from the beginning of the buffer without any
> reprogramming.  The hardware would also be programmed to issue an interrupt when it got to
> the end of the buffer, and when it got to the half-way point.
>
> To start playback, you first filled the whole buffer with audio data, and then told the
> hardware to start playing.  After the hardware got to the half-way point, it would issue
> an interrupt.  You would then tell the OS you need more data, and you'd get it.  You then
> copy that data into the first half of the buffer *while* the hardware was playing the
> second half.  Later, the hardware would interrupt you when it got to the end of the
> buffer.  You'd then copy more data to the 2nd half while the hardware is playing the first
> half.
>
> And so - hardware plays one half while you copy data to the other half.  Hence, "ping pong".
>
> So how do I implement this in ALSA?  The "Writing an ALSA Driver" document doesn't even
> contain the words "ping" or "pong".
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
