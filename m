From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Reasonable sound hardware parameters?
Date: Sat, 26 May 2007 08:50:29 +0200
Message-ID: <1180162229.5468.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9D1A724364
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2007 08:50:31 +0200 (CEST)
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

as I already described in one of my last posts on the list, I'm going to
write a ALSA driver for a sound controller which will also be "written"
at the same time (VHDL for FPGA) - on top of an embedded system (Xilinx
ML403 EvalBoard, PowerPC 405). We will do playback feature only.

The point is, that we will have _no_ real DMA and we don't want to use
the copy/silence or ack/workqueue (with intermediate buffer). So we
decided to move the ring buffer, which usually exists in RAM into the
sound controller and handle it as some kind of device IO memory, which
should be mmap'able (kernel function io_remap_pfn_range()). So, the
important goal is, to have mmap feature in the ALSA driver.

First question: To implement mmap on such kind of device IO memory, I
have to use snd_pcm_lib_mmap_iomem() as mmap() callback - like it is
used in the rme32 driver, right?

Second question: Do the following parameters make sense regarding the
size of the HW ring buffer and period sizes:

.buffer_bytes_max=16*1024;
.period_bytes_max=8*1024;
.period_bytes_min=?? resonable value ??
.periods_min=2;
.periods_max=?? resonable value ??

Furthermore, the sound controller will fire an interrupt after one
period is played.
Are there any arguments against these values? Any comments?

Thanks,
 Joachim
