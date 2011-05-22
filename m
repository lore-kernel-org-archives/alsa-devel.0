From: innoway@mymelody.com
Subject: Re: playback write error(DMA or IRQ trouble?)
Date: Sun, 22 May 2011 14:46:01 +0800
Message-ID: <20110522064601.1A59B1601D8@c-in3ws--03-05.sv2.lotuslive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound3.messaging.lotuslive.com
	(outbound3.messaging.lotuslive.com [8.12.152.115])
	by alsa0.perex.cz (Postfix) with ESMTP id C8ECF24439
	for <alsa-devel@alsa-project.org>;
	Sun, 22 May 2011 08:46:05 +0200 (CEST)
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
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 I'll try to fix the programs from this Monday and I think I have to
learn alsa system more deeply because I 'm a newcomer about it. Thank you

  2011/5/20 <innoway@mymelody.com>:
  > I develop an embedded system on the Linux board with Freescale
  i.MX27
  > (ARM processor). I succeed on sound, which is transferred using
  > Synchronous Serial Interface (SSI). It,s fine and then I try to do
  test
  > of inserting or pulling out a USB memory stick in the USB host
  connector
  > while sounding. I get the following error message from
  > snd_pcm_lib_write1() of <linux src>/sound /core/pcm_lib.c after
  waiting
  > for a while (about 10sec). playback write error (DMA or IRQ
  > trouble?) and then from snd_pcm_drain() of <linux
  > src>/sound/core/pcm_native.c playback drain error (DMA or IRQ
  > trouble?) (No sound during this period)
  >
  > and then it is sounding again.
  >
  > I want to prevent the sound from stopping even if something happens
  > suddenly such as the USB memory stick is plugged in or out.
  >
  > I try to fix the above programs, but I don't succeed.
  >
  > Can someone give me the clue? [13:21:38]:/proc# cat interrupts
  > CPU0
  > 12: 3456 - mxc_i2c
  > 16: 141 - CSPI_IRQ
  > 18: 952 - mxcintuart
  > 26: 1051255 - MXC Timer Tick
  > 28: 29446 - PCMCIA IRQ, ide0
  > 50: 33 - fec
  > 54: 793 - ehci_hcd:usb1
  > 56: 1 - arc_udc
  > 61: 0 - LCDC
  > 117: 0 - m66291_udc
  > 147: 0 - PMIC_IRQ
  > 157: 337179 - SMSC_LAN911x_ISR
  > 176: 0 - fec(MII)
  >
  > [13:35:03]:/proc# cat dma
  > dma channel 0: unused
  > dma channel 1: unused
  > dma channel 2: unused
  > dma channel 3: unused
  > dma channel 4: unused
  > dma channel 5: unused
  > dma channel 6: unused
  > dma channel 7: unused
  > dma channel 8: unused
  > dma channel 9: unused
  > dma channel 10: unused
  > dma channel 11: unused
  > dma channel 12: unused
  > dma channel 13: unused
  > dma channel 14: unused
  > dma channel 15: unused Thank you
  >
  > Masanori Inoue
  >

  This error also occur in snd-hda-intel

  echo 32768 > /proc/asound/Intel/pcm0p/sub0/prealloc

  speaker-test which use maximum buffer size also have (DMA or IRQ
  error
  in system log

  THis seem to be related to the schedule_timeout

  tout = schedule_timeout(msecs_to_jiffies(10000));

  I guess this is why PA server treat avail > 10 seconds is invalid
  _______________________________________________
  Alsa-devel mailing list
  Alsa-devel@alsa-project.org
  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
