From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin: fix DAI/SPORT config
	dependency issues
Date: Thu, 13 Jan 2011 14:16:27 +0000
Message-ID: <20110113141627.GG11840@opensource.wolfsonmicro.com>
References: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34838103B34
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 15:16:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 08:04:28PM -0500, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
> While I2S/TDM/AC97 DAI is built-in, others are compiled as modules,
> SND_BF5XX_SOC_SPORT will be module, then DAI can't get some symbols.
> Except that, SND_BF5XX_AC97 depends on SND_BF5XX_SOC_AC97 too.

Applied, thanks.
