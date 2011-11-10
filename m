From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Thu, 10 Nov 2011 15:25:00 +0000
Message-ID: <20111110152500.GJ3832@opensource.wolfsonmicro.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
	<20111110114310.GA3832@opensource.wolfsonmicro.com>
	<4EBBEA51.90707@freescale.com>
	<20111110151619.GI3832@opensource.wolfsonmicro.com>
	<4EBBEBC3.8060406@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6588424332
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 16:25:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EBBEBC3.8060406@freescale.com>
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

On Thu, Nov 10, 2011 at 09:20:35AM -0600, r80115 wrote:

> I see.  This is sounding like a significant rewrite.  I'll have to
> revisit this then.  Thanks for catching that.

It should be pretty trivial - just a for loop over all rtds, or even
simpler should be to just embed the ops within the rtd.
