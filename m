From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [linuxsh-dev] AICA driver for dreamcast
Date: Mon, 29 May 2006 00:46:49 +0100
Message-ID: <1148860009.9224.36.camel@localhost.localdomain>
References: <1148841646.9224.19.camel@localhost.localdomain>
	<20060528193211.GA10078@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk
	[81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B1A0115A
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 01:46:56 +0200 (MEST)
In-Reply-To: <20060528193211.GA10078@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Cc: alsa-devel@alsa-project.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-05-28 at 22:32 +0300, Paul Mundt wrote:
> Hi Adrian,
> 
> It's getting better, but still a ways to go..
> 
The bad news is that what I thought was working code wasn't. The
dma_wait_for_completion function is still broken in the G2 DMA, so when
the correct code is inserted the kernel oops:

/ # insmod /lib/modules/2.6.16-sh/kernel/sound/drivers/aica.ko
ALSA /home/adrian/aica/aica/aica.c:630: ALSA Driver for Yamaha AICA
Super Intelligent Sound Processor
/ # cat aine-email.wav > /dev/dsp
scheduling while atomic: cat/0x00000002/1216

Call trace:
[<8c1d41f2>] schedule+0x512/0x840
[<8c0fad20>] __sdivsi3+0x0/0x9a
[<8c1d3ce0>] schedule+0x0/0x840
[<8c02f6a0>] prepare_to_wait+0x0/0xc0
[<8c14c704>] dma_wait_for_completion+0x84/0x100
[<8c01bca0>] getnstimeofday+0x0/0x40
[<8c032c4a>] ktime_get+0xa/0x20
[<8c14c704>] dma_wait_for_completion+0x84/0x100
[<8c0fad20>] __sdivsi3+0x0/0x9a
[<8c1d3ce0>] schedule+0x0/0x840
[<8c02f6a0>] prepare_to_wait+0x0/0xc0
[<8c02f8c0>] autoremove_wake_function+0x0/0x40
[<8c02f8c0>] autoremove_wake_function+0x0/0x40
[<8c05ed2a>] vfs_write+0x6a/0x180
[<8c05ef14>] sys_write+0x34/0xa0
[<8c0051bc>] syscall_call+0xc/0xe
[<8c05eee0>] sys_write+0x0/0xa0
