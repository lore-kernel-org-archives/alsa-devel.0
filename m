From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: Prepare for init
 time DAI format setting
Date: Fri, 30 Sep 2011 15:00:38 +0100
Message-ID: <20110930140038.GG2085@sirena.org.uk>
References: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 53F1C1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 16:00:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 04:07:44PM +0300, Jarkko Nikula wrote:
> Before commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the
> dai_link") expectation for omap-mcbsp was that snd_soc_dai_set_fmt is to be
> called first in machine hw_params callback before other CPU DAI functions.
> Thus it was enough that only omap_mcbsp_dai_set_dai_fmt cleared the
> mcbsp->regs structure.

> Now this doesn't hold anymore since machine drivers can set the DAI format
> only once on init time and thus mcbsp->regs may get out of sync when other

Note that it's only been convention that stopped this happening in the
past, there's never been anything stopping drivers doing this in the
link init function.
