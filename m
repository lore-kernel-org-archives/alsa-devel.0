From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 09:42:29 +0000
Message-ID: <20100218094229.GC3315@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<20100217105202.GB31765@sirena.org.uk>
	<4B7CDA65.6000301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84FF81038F3
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 10:42:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B7CDA65.6000301@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi brar <jassisinghbrar@gmail.com>, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2010 at 03:12:53PM +0900, Joonyoung Shim wrote:
> On 2/17/2010 7:52 PM, Mark Brown wrote:

> > What modifications are you looking for here?  ASoC doesn't make any

> Thing modified is the active counting of DAI(struct snd_soc_dai) and pcm
> stream(struct snd_soc_pcm_stream). Also, startup() in ops functions of 
> same DAI shouldn't be called several times when the device using same 
> DAI is opened.

Yeah, though it's not 100% clear to me that the multiple calls to
startup() are a bad thing - if the driver does need to coordinate
between multiple possible links then this gives it an opportunity to
handle that.  On the other hand it's likely to be easier for drivers
that do allocations on startup() if there are separate callbacks for
first reference and for each use.

> > can be turned on and off, for example) but these should be things that
> > could be open coded in individual drivers.

> Sorry, what does "be open coded" mean?

Explicitly written in individual drivers rather than being factored out
or otherwise using common code.
