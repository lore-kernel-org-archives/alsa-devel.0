From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: [RFC] ALSA vs. dedicated char device for a USB Audio
	Class gadget driver
Date: Thu, 14 May 2009 15:45:01 +0200
Message-ID: <200905141545.01798.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.irobotique.be (perceval.irobotique.be [92.243.18.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6639510397A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 15:41:24 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi everybody.

Linux provides a USB Audio Class (UAC) driver on the USB host side, but a UAC 
gadget driver on the USB device side is currently missing.

Considering plugging in this hole, I'm looking at userspace <-> kernelspace 
APIs.

In a nutshell (let's consider recording, where the device appears to the host 
as a USB microphone), the kernel driver needs to be fed with audio data from a 
userspace application and stream those data on USB. Audio data can come from a 
real microphone (through an ALSA driver), a file, a network socket, ... the 
driver will not care.

I need an API to transfer audio data from userspace to kernelspace. I 
initially thought about ALSA, but it turns out some assumptions made by ALSA 
are not fulfilled by my system. One of the most serious problems is that the 
UAC gadget driver doesn't have any audio clock. The only hardware clock 
available is the USB device controller interrupts generated at the USB 
transfer rate, and those are much faster than the audio sample rate. This will 
cause buffer underruns that I need to handle.

I can thing of 3 solutions to solve this issue, and I'd like your opinion on 
them.

1. Get the userspace application to provide a clock to the driver. This could 
be done by writing to a /proc file, a special char device, or even by adding 
an ioctl to ALSA. Every time the driver receives a clock tick it would 
transfer one period of data.

2. Find out how much data is available in the ALSA ring buffer. I could then 
throttle USB interrupts when no data is available in the buffer and try again 
later. ALSA maintains a read and a write pointer (hw_ptr and appl_ptr) that 
can be accessed through the snd_pcm_*_avail() functions. However, I'm not sure 
how to handle proper locking, and I don't understand how runtime->boundary 
interacts with those functions. I've also heard that there's a free-running 
mode that will make those functions return bogus values. I'd appreciate help 
on this.

3. Use another API (dedicated character device, socket, ...) to transfer audio 
data from userspace to kernelspace. ALSA is way too big for my requirements (2 
layers of abstraction, architectured around assumptions that make sense for 
real sound cards but not for my hardware, ...). On the other hand, it would be 
handy to use existing ALSA applications to driver the device.

I'd appreciate comments regarding the API choice. How do you all expect to 
push data from a userspace application to a UAC driver on the device side ? If 
ALSA is *the* way, is one of the above solutions practical or is there a 
better way ?

Best regards,

Laurent Pinchart
