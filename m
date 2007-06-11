From: Timur Tabi <timur@freescale.com>
Subject: Trouble understanding ALSA's DMA buffers
Date: Mon, 11 Jun 2007 14:57:53 -0500
Message-ID: <466DA941.40309@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D6F510381F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 21:58:02 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5BJvs2C027641
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 12:57:59 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5BJvrJ4008027
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 14:57:54 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm writing an ALSA SOC driver for an I2S-based device, and I'm having a really hard time 
understanding how ALSA uses the DMA buffers.  And yes, I've read the documentation and 
studied some sample source code.

I used to write audio drivers for a living, but that was many years ago, and it wasn't for 
Linux.  Perhaps the concepts in my head are outdated, but I just don't see enough 
explanation as to how DMA buffers are supposed to work.

Back then, audio drivers used "ping pong" DMA buffers.  A single DMA buffer is allocated, 
and the audio hardware is programmed to read from that buffer in a loop.  That is, it 
would automatically restart reading from the beginning of the buffer without any 
reprogramming.  The hardware would also be programmed to issue an interrupt when it got to 
the end of the buffer, and when it got to the half-way point.

To start playback, you first filled the whole buffer with audio data, and then told the 
hardware to start playing.  After the hardware got to the half-way point, it would issue 
an interrupt.  You would then tell the OS you need more data, and you'd get it.  You then 
copy that data into the first half of the buffer *while* the hardware was playing the 
second half.  Later, the hardware would interrupt you when it got to the end of the 
buffer.  You'd then copy more data to the 2nd half while the hardware is playing the first
half.

And so - hardware plays one half while you copy data to the other half.  Hence, "ping pong".

So how do I implement this in ALSA?  The "Writing an ALSA Driver" document doesn't even 
contain the words "ping" or "pong".

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
