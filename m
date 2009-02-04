From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: pxa-ssp: fix SSP port request
Date: Wed, 4 Feb 2009 13:19:49 +0000
Message-ID: <20090204131948.GF29849@sirena.org.uk>
References: <1233692306-13211-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 47EBC243D2
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 14:19:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233692306-13211-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 09:18:26PM +0100, Philipp Zabel wrote:
> PXA2xx/3xx SSP ports start from 1, not 0. Thus, the probe function
> requested the wrong SSP port. Correcting this unveiled another bug
> where ssp_init tries to request the already-requested SSP port again.
> So this patch replaces the ssp_init/exit calls with their internals
> from mach-pxa/ssp.c, leaving out the redundant ssp_request and the
> unneeded IRQ request. Effectively, that leaves us with not much more
> than enabling/disabling the SSP clock.

Applied, thanks.
