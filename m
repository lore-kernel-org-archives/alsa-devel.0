From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP
	clock	support for TI DM646X processor
Date: Mon, 16 Mar 2009 15:20:29 +0000
Message-ID: <20090316152028.GF16539@sirena.org.uk>
References: <1237205125-30211-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C0C02434B
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:20:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237205125-30211-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 08:05:25AM -0400, Naresh Medisetty wrote:

> +	CLK("soc-audio.0", NULL, &mcasp0_clk),
> +	CLK("soc-audio.1", NULL, &mcasp1_clk),

Assuming this is a shorthand for defining two platform devices for two
ASoC cards I'd suggest that you instead move towards registering clocks
for the DAIs and probing them as platform devices - take a look at how
the PXA AC97 driver now does this for an example.  The soc-audio device
will hopefully get removed at some point and you can't guarantee that
the user won't want to put the two DAIs into a single sound card.
