From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Date: Mon, 1 Feb 2010 14:31:20 +0000
Message-ID: <20100201143120.GA26011@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
	<20100127201755.GA11601@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1001291452110.4613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA1D824422
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 15:31:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001291452110.4613@axis700.grange>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 02:57:34PM +0100, Guennadi Liakhovetski wrote:
> On Wed, 27 Jan 2010, Mark Brown wrote:

> > I'm fairly sure this and the similar logic for SYSCLK can be squashed
> > together with some suitable local variables.  Might be more legible
> > since this requires some staring at.  I didn't actually go so far as to
> > work out what the relevant code is, though.

> Well, not really. In one case f_PLLOUT can be derived directly, because 
> OPCLKDIV covers the whole its value range 1-4, whereas MCLKDIV takes 
> values 1, 3/2, 2, 3, 4, 6, 8, 12, so, you have to apply an iterative 
> process to select the best match. I've just sent a patch, that improves 

I don't follow your logic there at all, I'm afraid.  Both options have a
table of possible values for the divider (and hence the PLL output
frequencies they can use) which they need to additionally constrain
based on the PLL operating conditions.

Looking at the code I think half the issue here is that all the
constraints that are shared from the PLL and its input path aren't
factored out but are in per-output conditional cases, making those more
complex than they need to be.  The magic number heaviness of the code
and comments accentuates the issue.
