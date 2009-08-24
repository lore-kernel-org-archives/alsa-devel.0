From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform:
	Fix	s3c2410_dma_started called at wrong time
Date: Mon, 24 Aug 2009 13:05:31 +0100
Message-ID: <20090824120530.GA9090@sirena.org.uk>
References: <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
	<1251027433.732.42.camel@sl>
	<20090824101733.GA3591@rakim.wolfsonmicro.main>
	<1251114880.3676.41.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 123AB24389
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 14:05:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251114880.3676.41.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 24, 2009 at 07:54:40PM +0800, Shine Liu wrote:

> If not, more filed will be needed in struct s3c2410_dma_client to place
> the arguments. I think it's redundant for the generic DMA driver.

But why are you changing the core DMA code in the first place?  The ASoC
drivers have split front end and DMA code but this is not the normal
case for a DMA client.
