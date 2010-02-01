From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: improve MCLKDIV calculation in
 wm8978, when OPCLK is not used
Date: Mon, 1 Feb 2010 14:45:41 +0000
Message-ID: <20100201144541.GB26011@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1001291432030.4613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFA021037F5
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 15:45:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001291432030.4613@axis700.grange>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 02:51:26PM +0100, Guennadi Liakhovetski wrote:
> In case, if OPCLK is not used, and PLL is used for driving the codec, the 
> choice of PLL output frequency could result in a needlessly imprecise 
> system clock frequency. Use an iterative process to select a precise 
> configuration.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
