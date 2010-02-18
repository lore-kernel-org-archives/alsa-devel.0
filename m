From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 09:35:00 +0000
Message-ID: <20100218093459.GB3315@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 588D31038E8
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 10:35:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2010 at 11:14:57AM +0900, jassi brar wrote:
> On Wed, Feb 17, 2010 at 10:14 PM, Mark Brown
> > On Wed, Feb 17, 2010 at 09:15:56PM +0900, jassi brar wrote:

> >> The workaround to enable a cpu_dai to be used in multiple dai_links isn't

> > What workaround?

> The same as that for codec_dai.
> cpu_dai is used exact the same way as codec_dai except for runtime
> pointer assignment in soc_pcm_open as i mentioned already.

Could you please be more specific about what the workaround you are
referring to is?  I'm genuinely not clear what you mean here.

> So, it seems, the member 'struct snd_pcm_runtime *'  of 'struct snd_soc_dai'
> is mostly unused. We can easily move it to 'struct snd_soc_dai_link' or
> even drop it altogether to reduce redundancy(I prefer).

May as well drop it once the Atmel drivers no longer need it.
