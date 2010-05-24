From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix uninitialised variable
	in	siu_dai.c
Date: Mon, 24 May 2010 20:33:23 +0100
Message-ID: <20100524193323.GB29620@sirena.org.uk>
References: <Pine.LNX.4.64.1005241051190.2611@axis700.grange>
	<1274697751.3064.87.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6593B10383A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 21:33:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274697751.3064.87.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, May 24, 2010 at 11:42:31AM +0100, Liam Girdwood wrote:
> On Mon, 2010-05-24 at 10:55 +0200, Guennadi Liakhovetski wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Strangely, the compiler doesn't warn about this one, but I really don't 
> > see how this can be correct. Am I being blind?
> 
> No, I think the compiler is at fault here.

Applied, thanks.
