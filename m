From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 14:30:26 +0200
Message-ID: <4FEC4E62.3020101@metafoo.de>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
	<4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de>
	<20120628121816.GB21029@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-120.synserver.de (smtp-out-130.synserver.de
	[212.40.185.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 390A010402B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 14:26:38 +0200 (CEST)
In-Reply-To: <20120628121816.GB21029@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, lrg@ti.com, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 06/28/2012 02:18 PM, Mark Brown wrote:
> On Thu, Jun 28, 2012 at 02:15:38PM +0200, Takashi Iwai wrote:
>> Lars-Peter Clausen wrote:
> 
>>> to the ALSA core. Now that there is a generic dma_mmap_writecombine it may
>>> make sense to integrate this with snd_pcm_lib_default_mmap.
> 
>> Agreed.
> 
>> Also, it must be portable.  So far, only ARM has
>> dma_mmap_writecombine(), thus the build on other arch would fail as
>> is.
> 
> Oh, dear - this means we don't actually have a generic API at all.  Is
> there any effort being made to make this generally available?

Yes there is, and in fact in next/master there is generic
dma_mmap_writecombine. I'm not quite sure how it behaves on non ARM archs
though. But in theory it should fallback to a normal coherent mapping. Marek
did a lot of work on this, I've put him on Cc.

- Lars
