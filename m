From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Thu, 10 Nov 2011 15:16:19 +0000
Message-ID: <20111110151619.GI3832@opensource.wolfsonmicro.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
	<20111110114310.GA3832@opensource.wolfsonmicro.com>
	<4EBBEA51.90707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC78E2434E
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 16:16:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EBBEA51.90707@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: r80115 <alan.tull@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 09:14:25AM -0600, r80115 wrote:
> On 11/10/2011 5:43 AM, Mark Brown wrote:

> >This is going to leak - rtd is an array per PCM, not a single value, so
> >we need to free the ops for each element.  This is so we can have
> >multiple DMA controllers in a single card.

> >Actually what would be even easier would be to just embed the ops in the
> >struct, we need to allocate one per runtime anyway and it makes for less
> >allocation and cleanup code.

> In soc-pcm.c we allocate:
> soc_pcm_ops = kzalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);

> and set it to the pointer

> rtd->ops = soc_pcm_ops;

> So that's what is freed there.

You're not getting the point here.  The point is that you're only
freeing a single copy of the ops no matter how many are allocated.
