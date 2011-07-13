From: Marco Sinigaglia <marco.sinigaglia@csr.com>
Subject: AC97 on S3C6410
Date: Wed, 13 Jul 2011 15:42:44 +0100
Message-ID: <4E1DAEE4.1090902@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
	[85.115.60.190]) by alsa0.perex.cz (Postfix) with ESMTP id A31B32412D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 16:43:23 +0200 (CEST)
Received: from cameurexb01.EUROPE.ROOT.PRI ([193.128.72.68])
	by rly11d.srv.mailcontrol.com (MailControl) with ESMTP id
	p6DEguRH020070
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 15:42:56 +0100
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

Hi All,

I am still trying to implement the AC97, on S3C6410, using the WM9714.
I have done some big step forward but I am now hitting another issue.

The kernel can see the WM9714:
<6>ALSA device list:
<6>  #0: SMDK (WM9713)

Anyway, after that, i cannot see anymore activity on the AC97 bus.
I got, indeed, these errors:

<3>s3c-ac97: req addr = 12, rep addr = 00
[...]
<3>s3c-ac97: req addr = 12, rep addr = 00

When I try to play something, i got this (I enabled the DEBUG on dma.c):

<7>asoc: AC97 HiFi <-> s3c-ac97 info:
<7>asoc: rate mask 0xd6
<7>asoc: min ch 2 max ch 2
<7>asoc: min rate 8000 max rate 48000
<7>dma22: s3c2410_request_dma: client=AC97 PCMOut, dev=(null)
<7>DMA8: 00000000->00000000 L 00000000 C 00000000,00000000 S 00000000
<7>s3c2410_dma_request: channel initialised, c06779c8
<7>s3c2410_dma_devconfig: channel 22, source 1, dev 7f001018, chan c06779c8
<7>s3c2410_dma_devconfig: peripheral 6
<7>s3c2410_dma_devconfig: config 0000c980
<7>DMA8: 00000000->00000000 L 00000000 C 00000000,00000000 S 0000c980
<7>s3c64xx_dma_flush: flushing channel
<7>s3c2410_dma_enqueue: buff c9dcfac0, dp 5e740000 lli (ffcd6000, 
57241000) 8192
<7>enquing onto empty channel
<7>s3c64xx_lli_to_regs: LLI ffcd6000 => regs
<7>LLI[ffcd6000] 5e740000->7f001018, NL 00000000 C 96480000,00000800
<7>LLI[ffcd6000] 5e740000->7f001018, NL 00000000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 00000000 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfac0, curr c9dcfac0, end c9dcfac0
<7>s3c2410_dma_enqueue: buff c9dcfa60, dp 5e742000 lli (ffcd6020, 
57241020) 8192
<7>enquing onto channel
<7>LLI[ffcd6000] 5e740000->7f001018, NL 57241020 C 96480000,00000800
<7>LLI[ffcd6020] 5e742000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcfa60
<7>s3c2410_dma_enqueue: buff c9dcfa40, dp 5e744000 lli (ffcd6040, 
57241040) 8192
<7>enquing onto channel
<7>LLI[ffcd6020] 5e742000->7f001018, NL 57241040 C 96480000,00000800
<7>LLI[ffcd6040] 5e744000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcfa40
<7>s3c2410_dma_enqueue: buff c9dcfa20, dp 5e746000 lli (ffcd6060, 
57241060) 8192
<7>enquing onto channel
<7>LLI[ffcd6040] 5e744000->7f001018, NL 57241060 C 96480000,00000800
<7>LLI[ffcd6060] 5e746000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcfa20
<7>s3c2410_dma_enqueue: buff c9dcfa00, dp 5e748000 lli (ffcd6080, 
57241080) 8192
<7>enquing onto channel
<7>LLI[ffcd6060] 5e746000->7f001018, NL 57241080 C 96480000,00000800
<7>LLI[ffcd6080] 5e748000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcfa00
<7>s3c2410_dma_enqueue: buff c9dcf9e0, dp 5e74a000 lli (ffcd60a0, 
572410a0) 8192
<7>enquing onto channel
<7>LLI[ffcd6080] 5e748000->7f001018, NL 572410a0 C 96480000,00000800
<7>LLI[ffcd60a0] 5e74a000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcf9e0
<7>s3c2410_dma_enqueue: buff c9dcf9c0, dp 5e74c000 lli (ffcd60c0, 
572410c0) 8192
<7>enquing onto channel
<7>LLI[ffcd60a0] 5e74a000->7f001018, NL 572410c0 C 96480000,00000800
<7>LLI[ffcd60c0] 5e74c000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcf9c0
<7>s3c2410_dma_enqueue: buff c9dcf9a0, dp 5e74e000 lli (ffcd60e0, 
572410e0) 8192
<7>enquing onto channel
<7>LLI[ffcd60c0] 5e74c000->7f001018, NL 572410e0 C 96480000,00000800
<7>LLI[ffcd60e0] 5e74e000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcf9a0
<7>s3c2410_dma_enqueue: buff c9dcf980, dp 5e750000 lli (ffcd6100, 
57241100) 8192
<7>enquing onto channel
<7>LLI[ffcd60e0] 5e74e000->7f001018, NL 57241100 C 96480000,00000800
<7>LLI[ffcd6100] 5e750000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcf980
<7>s3c2410_dma_enqueue: buff c9dcf960, dp 5e752000 lli (ffcd6120, 
57241120) 8192
<7>enquing onto channel
<7>LLI[ffcd6100] 5e750000->7f001018, NL 57241120 C 96480000,00000800
<7>LLI[ffcd6120] 5e752000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c9dcf960
<7>s3c2410_dma_enqueue: buff c7242940, dp 5e754000 lli (ffcd6140, 
57241140) 8192
<7>enquing onto channel
<7>LLI[ffcd6120] 5e752000->7f001018, NL 57241140 C 96480000,00000800
<7>LLI[ffcd6140] 5e754000->7f001018, NL 57241000 C 96480000,00000800
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<7>DMA8: buffs next c9dcfa60, curr c9dcfac0, end c7242940
<7>DMA8: 5e740000->7f001018 L 57241020 C 96480000,00000000 S 0000c980
<3> clearing interrupts
<7>s3c64xx_dma_start: clearing interrupts
<7>s3c64xx_dma_start: starting channel
<7>s3c64xx_dma_start: writing config 0000c981
<7>ALSA sound/core/pcm_lib.c:1755: playback write error (DMA or IRQ 
trouble?)
<7>ALSA sound/core/pcm_lib.c:1755: playback write error (DMA or IRQ 
trouble?)
<7>s3c64xx_dma_stop: stopping channel
<7>DMA8: 5e740010->7f001018 L 57241020 C 96480000,00000800 S 0002c981

I have the feeling that, for some reasons, the DMA is not doing its job.
I have added the following line on dma.c but it does not fix the error:
s3c64xx_dma_init1(8, DMACH_AC97_PCMOUT, IRQ_DMA1, 0x75100000);

Can someone, please, give me some feedback?

I am using kernel 2.6.35 and the head of Android.

Cheers
Marco


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
