From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Rename ALC5632 MICBIAS to common
	name convention.
Date: Tue, 13 Dec 2011 09:36:08 +0800
Message-ID: <20111213013606.GB15314@opensource.wolfsonmicro.com>
References: <1323719025-18304-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83FD710386C
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 02:36:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323719025-18304-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 09:43:45PM +0200, Leon Romanovsky wrote:

> -SND_SOC_DAPM_SUPPLY("Mic Bias1", ALC5632_PWR_MANAG_ADD1, 3, 0, NULL, 0),
> -SND_SOC_DAPM_SUPPLY("Mic Bias2", ALC5632_PWR_MANAG_ADD1, 2, 0, NULL, 0),
> +SND_SOC_DAPM_SUPPLY("MICBIAS1", ALC5632_PWR_MANAG_ADD1, 3, 0, NULL, 0),
> +SND_SOC_DAPM_SUPPLY("MICBIAS2", ALC5632_PWR_MANAG_ADD1, 2, 0, NULL, 0),

What does the datasheet say the pins are called?
