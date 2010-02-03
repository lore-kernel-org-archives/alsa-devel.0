From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix compilation breakage in
	sound/soc/sh/fsi.c
Date: Wed, 3 Feb 2010 18:00:17 +0000
Message-ID: <20100203180016.GA25802@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85CC410386E
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 19:00:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 03, 2010 at 05:37:23PM +0100, Guennadi Liakhovetski wrote:
> ctrl_outl() has become void at some point, which breaks compilation of fsi.c.
> Make writing functions void, as their output is anyway not evaluated, and use
> __raw_writel and __raw_readl instead of deprecated ctrl_outl and ctrl_inl
> respectively.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
