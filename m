From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC][PATCH] pxa2xx-ac97: switch AC unit to
	correct state before	probing
Date: Tue, 11 Nov 2008 10:47:40 +0000
Message-ID: <20081111104739.GB7019@sirena.org.uk>
References: <20081110191124.GA2140@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8685A1037ED
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 11:47:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081110191124.GA2140@doriath.ww600.siemens.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 10:11:24PM +0300, Dmitry Baryshkov wrote:

> AC97 irq, I see a unending storm of irq requests. I've come with the
> following patch (against 2.6.27, if the idea is OK, I'll rebase against
> 2.6.28-rc).

That's going to cause the pxa25x to use the full timeout for the reset
since it uses the interrupt to detect completion.  This should just
introduce a delay (which we shouldn't do) and may break something.  I'd
expect that simply switching pxa25x to polling GSR for completion like
everything else does would deal with it but testing would be nice if
anyone has a board...

Otherwise it looks OK - we're not using the interrupt for anything else
until after we've reset things so it's a sensible solution.
