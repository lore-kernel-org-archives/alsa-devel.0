From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Thu, 28 Jun 2012 13:18:16 +0100
Message-ID: <20120628121816.GB21029@sirena.org.uk>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
	<4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E0A8103F4A
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 14:18:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hobo3zl79.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, swarren@nvidia.com, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 28, 2012 at 02:15:38PM +0200, Takashi Iwai wrote:
> Lars-Peter Clausen wrote:

> > to the ALSA core. Now that there is a generic dma_mmap_writecombine it may
> > make sense to integrate this with snd_pcm_lib_default_mmap.

> Agreed.

> Also, it must be portable.  So far, only ARM has
> dma_mmap_writecombine(), thus the build on other arch would fail as
> is.

Oh, dear - this means we don't actually have a generic API at all.  Is
there any effort being made to make this generally available?
