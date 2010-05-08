From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem about developing WM8974 audio driver
	for	MX27ipcam
Date: Sat, 8 May 2010 12:08:48 +0100
Message-ID: <20100508110847.GA4687@sirena.org.uk>
References: <1273287845.12672.36.camel@UT43>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 60CC61038F5
	for <alsa-devel@alsa-project.org>;
	Sat,  8 May 2010 13:08:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1273287845.12672.36.camel@UT43>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jie Jiang <jjinfo@nudt.edu.cn>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Sat, May 08, 2010 at 11:04:05AM +0800, Jie Jiang wrote:

> After installing all necessary driver modules, when I trying to playback
> some wav file using "cat xx.wav > /dev/dsp" command, I got the following
> error message:
> "ALSA pcm_lib.c:1709: playback write error (DMA or IRQ trouble?)".

> This seems to be caused by the full of the transmitting buffer since I
> can check that "hw_ptr=0x800/buffer_size=0x4000/appl_ptr=0x4800". The
> hw_ptw doesn't update anymore. It seems that there is something wrong
> with the DMA operation. Actually, the DMA dest. address is the SSI1's
> TX0 FIFO.  On the other hand, SSI1's SFCSR=0x440844, which indicates
> that there are 8 bytes data in the TX0 FIFO, which will not generate DMA
> request as the FIFO empty watermark is 4. It is very possible that the
> SSI1 does not shift data from the FIFO, which causes no DMA request
> generated and thus DMA freezes.

As you've diagnosed below this normally indicates that the clocking for
the bus isn't set up correctly and the clocks aren't reaching the bus
and therefore DMA controller on the CPU.

> Who can shed some light on the  map between mx27 AUDMUX port and GPIO
> pins?  Any more possible reasons which will freeze DMA transfer?

Bad clocking is the main one.  What I do when diagnosing similar
problems is either try to route the data and clocks out to another
external port on the AUDMUX (so you can see what's actually getting
through) or write code to read back the device settings and translate
them into human readable form (you can see some debugfs files I did for
the i.MX3x AUDMUX in mainline) which often helps discover incorrect
settings.

Sasha Hauer, who did the mainline drivers for i.MX, may also be able to
help - I've CCed him.
