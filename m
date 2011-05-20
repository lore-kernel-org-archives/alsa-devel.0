From: innoway@mymelody.com
Subject: playback write error(DMA or IRQ trouble?)
Date: Fri, 20 May 2011 13:10:16 +0800
Message-ID: <20110520051016.D9F781F68CF@c-in3ws--03-04.sv2.lotuslive.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0087391928200447102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound3.messaging.lotuslive.com
	(outbound3.messaging.lotuslive.com [8.12.152.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D8CED10381F
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 07:10:21 +0200 (CEST)
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

This is a multi-part message in MIME format.

--===============0087391928200447102==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 I develop an embedded system on the Linux board with Freescale i.MX27
(ARM processor). =A0 I succeed on sound, which is transferred using
Synchronous Serial Interface (SSI). It,s fine and then I try to do test
of inserting or pulling out a USB memory stick in the USB host connector
while sounding. =A0 I get the following error message from
snd_pcm_lib_write1() of <linux src>/sound /core/pcm_lib.c after waiting
for a while (about 10sec). =A0 =A0=A0=A0 playback=A0 write error (DMA or IRQ
trouble?) =A0 and then from snd_pcm_drain() of <linux
src>/sound/core/pcm_native.c =A0 =A0=A0 playback drain error (DMA or IRQ
trouble?) =A0 (No sound during this period)

and then it is sounding again.

I want to prevent the sound from stopping even if something happens
suddenly such as the USB memory stick is plugged in or out.

I try to fix the above programs, but I don't succeed.

Can someone give me the clue? =A0 [13:21:38]:/proc# cat interrupts
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0
=A012:=A0=A0=A0=A0=A0=A0 3456=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 mxc_i2c
=A016:=A0=A0=A0=A0=A0=A0=A0 141 =A0 =A0 =A0 =A0=A0 -=A0 CSPI_IRQ
=A018:=A0=A0=A0=A0=A0=A0=A0 952=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 mxcintuart
=A026:=A0=A0=A0 1051255=A0=A0=A0=A0 -=A0 MXC Timer Tick
=A028:=A0=A0=A0=A0=A0 29446=A0=A0=A0=A0=A0=A0=A0 -=A0 PCMCIA IRQ, ide0
=A050:=A0=A0=A0=A0=A0=A0=A0=A0 33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 fec
=A054:=A0=A0=A0=A0=A0=A0=A0 793=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 ehci_hcd:us=
b1
=A056:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 a=
rc_udc
=A061:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 -=A0 LCDC
117:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 m66291=
_udc
147:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 PMIC_I=
RQ
157:=A0=A0=A0=A0 337179=A0=A0=A0=A0 -=A0 SMSC_LAN911x_ISR
176:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 fec(MI=
I)

[13:35:03]:/proc# cat dma
dma channel=A0 0: unused
dma channel=A0 1: unused
dma channel=A0 2: unused
dma channel=A0 3: unused
dma channel=A0 4: unused
dma channel=A0 5: unused
dma channel=A0 6: unused
dma channel=A0 7: unused
dma channel=A0 8: unused
dma channel=A0 9: unused
dma channel 10: unused
dma channel 11: unused
dma channel 12: unused
dma channel 13: unused
dma channel 14: unused
dma channel 15: unused =A0 Thank you

Masanori Inoue

--===============0087391928200447102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0087391928200447102==--
