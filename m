From: Paul Davis <pbd@op.net>
Subject: Re: AW: general audio card Q
Date: Wed, 31 Jul 2002 09:06:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207311304.PAA19637@alsa.alsa-project.org>
References: <F85N6E5BgSeWjD0NG1x000194d2@hotmail.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA19637
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2002 15:04:43 +0200
In-Reply-To: Your message of "Wed, 31 Jul 2002 01:07:57 CDT."
             <F85N6E5BgSeWjD0NG1x000194d2@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Thanks for your reply and the education. My main reason behind asking
>this question is that I am using the RME PST card presently to do
>CPU controlled transfer of data to the memory mapped buffers in those
>cards. I am interested in using the CPU to do the transfer since
>I have heard that DMA or busmastering produces many millisecond latency
>in sound data playback. Such latency would be unacceptable in my app.
>BTW I am using RTAI to schedule tasks.

well, you've heard wrong. mostly.

all that is needed to reduce latencies to the absolute minimum (the
PCI bus limit of 64 bytes) is an accurate way to read the hardware
pointer on the interface at any time. some interfaces have this, some
don't. without it, you are limited to relying on interrupt-driven
transfer, which is where the latency comes in, regardless of whether
DMA is used or not.

the only additional latency comes from the transfer size used by the
interface. some interfaces don't go down to the PCI bus limit, but
only ever use DMA to move somewhat larger chunks. even then, the size
is pretty small - typically smaller than the typical lower limit for
the interrupt interval: 1-2msec (64 frames at 48kHz).

>I see in the ESS docs that many (maybe all) of their chipsets do
>something similar to the RME PST card except that the ESS does
>not use mapped-memory buffers. Instead it appears the use a single
>FIFO which generates interrupts as the data in the FIFO moves past
>the half-full (half empty :-) mark). These fifos are much smaller
>than the RME buffers if I recall correctly. The ESS docs refer to
>this as "ping-pong" transfer of sound data. I naive have called
>both the RME and ESS "ping-pong" methods double-buffering. My error.

no, this *is* double buffering, at least as the
windows/macos/ASIO/EASI world refers to it. 2 interrupts (periods) per
buffer.

>So I guess I should say that I am looking for cards that can use
>the ping-pong method in addition to the RME and ESS chipsets.

almost every card supported by ALSA can do this. the question is: how
big is the "FIFO"?

>Where does the DMA latency arise?

i think you're really confused about all this. there are two
orthogonal questions:

	   1) how does data move from/to the host memory to/from the
              interface?
           2) when does data move from/to the host memory to/from the
              interface? 

the first question has 3 possible answers (perhaps other, but none
that i know of):

  * the interface maps a section of host memory, and accesses it
      via the PCI bus (DMA)
  * the host maps a section of interface memory, and accesses it
      via the PCI bus
  * the host uses specific instructions to move data to/from the interface
      (for example, via some FIFO on the interface that is accessed
       via IO-space registers)

the second has two possible answers that i know of:

  * data transfer occurs on receipt of an interrupt from the interface
  * data transfer occurs at various times based on the amount
     of space/data available in the buffer, indicated by the
     location of the interface's hardware pointer

the hardware pointer is used even for interrupts, since its possible
that an interrupt was missed, and assuming that you know the
space/data available is a bad idea.

I hope this makes it clearer.

--p




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
