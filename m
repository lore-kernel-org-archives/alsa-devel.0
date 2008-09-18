From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Does LKML accept non-ASOC audio driver?
Date: Thu, 18 Sep 2008 10:21:37 +0100
Message-ID: <20080918092135.GA4203@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
	<20080917153029.GD7679@sirena.org.uk> <48D130BD.3060005@atmel.com>
	<20080917163537.GF7679@sirena.org.uk>
	<BAY110-W332FD6EFAA8BBE246EDD7DC94F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EABD224886
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 11:21:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BAY110-W332FD6EFAA8BBE246EDD7DC94F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <xcahua@hotmail.com>
Cc: alsa-devel@alsa-project.org, cooloney@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2008 at 09:16:08AM +0000, Cliff Cai wrote:

> We(blackfin arch) have several audio codec drivers which are written in alsa style,actually they are hard to transfer to asoc. 

What are the problems with this - is it a case of the hardware not
fitting the model well or are there other difficulties with the ASoC
framework?

> I also saw that there are several arch-based directories in sound/, e.g.sound/arm,
> does this mean non-asoc driver is also accepted currently?

Yes, ASoC only needs to be used in situations where it makes sense to do
so.  If the hardware doesn't have separate codec and DMA controllers,
for example, then it wouldn't make much sense to try to shoehorn it into
ASoC.
