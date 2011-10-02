From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: Prepare for init
 time DAI format setting
Date: Sun, 2 Oct 2011 19:51:36 +0100
Message-ID: <20111002185135.GG2857@opensource.wolfsonmicro.com>
References: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65327103828
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 20:51:37 +0200 (CEST)
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

Applied all with a note here about the fact that this was always a
limitation in the OMAP drivers.
