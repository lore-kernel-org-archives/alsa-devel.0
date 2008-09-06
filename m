From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA: ASoC V2: optimize init sequence
	of	Freescale MPC8610 sound drivers
Date: Sat, 6 Sep 2008 17:41:21 +0100
Message-ID: <20080906164120.GA6904@sirena.org.uk>
References: <1220647888-30550-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BD546243D0
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Sep 2008 18:41:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220647888-30550-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 03:51:28PM -0500, Timur Tabi wrote:
> In the Freescale MPC8610 sound drivers, relocate all code from the _prepare
> functions into the corresponding _hw_params functions.  These drivers assumed
> that the sample size is known in the _prepare function and not in the
> _hw_params function, but this is not true.

Applied, thanks.
