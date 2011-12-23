From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Fri, 23 Dec 2011 10:21:02 +0000
Message-ID: <20111223102101.GA2834@opensource.wolfsonmicro.com>
References: <053701ccc113$7c39bd80$74ad3880$@com>
	<1324633321.3965.2.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EE2A2441A
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 11:21:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324633321.3965.2.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 09:42:01AM +0000, Liam Girdwood wrote:

> I assume that you have two different DMA controllers (with a separate
> DMA platform drivers) here ?

> If so, why can you not specify each DMA platform driver in your machine
> driver DAI link ?

Alan Tull reported the same problem before with a patch that needed
respinning.  The issue is that we have a static soc_pcm_ops and we don't
properly indirect everything, we copy some of the ops into snd_pcm_ops
directly.  This means that if those ops end up being used then they end
up being the same for both drivers.

I was actually intending to fix this over Christmas.
