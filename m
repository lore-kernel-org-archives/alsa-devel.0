From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: embedded sound architecture question
Date: Wed, 09 May 2007 22:47:34 +0200
Message-ID: <1178743654.29464.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 11C4A243A3
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 22:47:36 +0200 (CEST)
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

Hi ALSA devs,

I'm going to write an ALSA driver for a not yet existing AC97
controller, which is going to be "written" (VHDL), too (at the same
time). Platform/Board is a Xilinx ML403 with Virtex-4 FPGA, PowerPC 405
architecture, OPB/OCP bus, AC97 Codec LM4550.

Before presenting my question, I have to say, that I'm a beginner with
ALSA/Linux driver development.

My question is: Does the architecture described below make sense/is
reasonable with ALSA and Linux?

The problem is, that there is no DMA controller and implementing an OPB
master device which would be able to do DMA itself is not an option at
this time.
So our thoughts were: Integrate the "DMA ring buffer" (which is usually
somewhere in main memory/RAM) into the AC97 controller. Make ALSA access
this HW buffer as if it was in main memory. This way, the device (AC97
controller) has "direct access" to its buffer "memory" - this could be
called "fake DMA".
The AC97 controller would have tell us where it is while playing and
firing interrupts after one period, so that we don't write to values
which are in the current period, instead update the area where of the
past played periods etc. ... The buffer should be a "ring buffer",
right?

Mapping this "IO memory" into kernel space should be possible with
io_remap_page_range(), right?
I would have to implement the mmap() callback in my driver, to setup the
given VMA (with the above function), right?
So, ALSA library/applications will be able to use MMAP mode, which is
what we want to achieve?
[We don't want copy()/silence(). An intermediate buffer with
ack()/tasklet/workqueue + FIFO in HW would be an alternative.]

I read, that many applications don't work, if MMAP mode is not supported
and classic read/write (copy()/silence()) is used, only. Is there a
black list of apps, which don't work?

Thanks for reading & your time,
 Joachim
