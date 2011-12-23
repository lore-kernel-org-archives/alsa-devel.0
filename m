From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Fri, 23 Dec 2011 09:42:01 +0000
Message-ID: <1324633321.3965.2.camel@odin>
References: <053701ccc113$7c39bd80$74ad3880$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id 7F156243FA
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 10:42:07 +0100 (CET)
Received: by werg1 with SMTP id g1so4892719wer.2
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 01:42:04 -0800 (PST)
In-Reply-To: <053701ccc113$7c39bd80$74ad3880$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-23 at 10:37 +0900, Sangbeom Kim wrote:
> The original code does not cover the case that two DAIs(CPU) have different
> ASoC core PCM operations(like mmap, pointer...). Currently we have only one
> global soc_pcm_ops for ASoC core PCM operation. When two DAIs have different
> pointer functions, second DAI's pointer function is set for both first DAI
> and second DAI in case of original code.
> 
> This patch allocates ASoC core PCM operations dynamically for each DAIs. So
> each DAIs can have different ASoC core PCM operations. This is needed to
> support multiple DAIs.
> 

I assume that you have two different DMA controllers (with a separate
DMA platform drivers) here ?

If so, why can you not specify each DMA platform driver in your machine
driver DAI link ?

Thanks

Liam 
