From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: remove bogus SLEEP mode from wm8978
	driver
Date: Fri, 29 Jan 2010 14:22:40 +0000
Message-ID: <20100129142240.GB5824@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1001281627540.4356@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAD1D103900
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:22:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001281627540.4356@axis700.grange>
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

On Thu, Jan 28, 2010 at 04:28:55PM +0100, Guennadi Liakhovetski wrote:
> Tests showed, that bit 6 of the WM8978_POWER_MANAGEMENT_2 register of wm8978
> affects codec clocks. Being useless for suspend / resume, it cannot be used in
> bias-level control either. Remove this bit handling.

Applied, thanks but I had to manually merge the patch - not sure what
the conflict was, I suspect there may be a whitespace issue or
something.
