From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc: fsl_dma_hw_free being called twice at end of
	playback
Date: Mon, 03 May 2010 16:05:55 -0500
Message-ID: <4BDF3AB3.4000803@freescale.com>
References: <4BDF3738.3070900@freescale.com>
	(sfid-20100503_215124_987373_C978C9AB)
	<8F61234B-3CA5-4553-A956-1722DD53B55F@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4912624584
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 23:05:58 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o43L5vBh006545
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2010 14:05:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o43LFc2l026548
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2010 16:15:39 -0500 (CDT)
In-Reply-To: <8F61234B-3CA5-4553-A956-1722DD53B55F@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On 3 May 2010, at 21:51, Timur Tabi <timur@freescale.com> wrote:
> 
>> In my 8610 ASoC driver, I'm seeing the DMA driver's .hw_free  
>> function being
>> called twice whenever playback ends.  I've added some printk's to  
>> demonstrate:
> 
> Is this with or without Liam's multiple CODEC work?

With.


-- 
Timur Tabi
Linux kernel developer at Freescale
