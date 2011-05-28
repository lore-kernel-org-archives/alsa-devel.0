From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove redundant freq assignment for
 max98095->sysclk/max98088->sysclk
Date: Sun, 29 May 2011 01:58:12 +0800
Message-ID: <20110528175811.GB31225@opensource.wolfsonmicro.com>
References: <1306510253.19556.36.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC5CB243ED
	for <alsa-devel@alsa-project.org>;
	Sat, 28 May 2011 19:58:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306510253.19556.36.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Peter Hsiang <cdefgab1288@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2011 at 11:30:53PM +0800, Axel Lin wrote:
> Current implementation set max98095->sysclk/max98088->sysclk to freq twice.
> Set it once is enough, this patch removes the first assignment in case
> we may set invalid clock frequency to max98095->sysclk/max98088->sysclk.

Applied, thanks.
