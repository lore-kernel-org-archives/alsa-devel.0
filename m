From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Convert non-SoC PXA2xx AC97 driver to
	clock API
Date: Thu, 21 Feb 2008 15:53:55 +0000
Message-ID: <20080221155355.GB9341@rakim.wolfsonmicro.main>
References: <20080219160341.GA6387@rakim.wolfsonmicro.main>
	<1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080221152741.GB19670@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6AC324395
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 16:53:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080221152741.GB19670@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, eric miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2008 at 03:27:41PM +0000, Russell King - ARM Linux wrote:

> Same comments as previous patch.

...

> This might disable the clock more times than its been enabled, particularly
> if the getting of ac97_clk fails.

Indeed - there's no need to disable it at all since it's only enabled
during a reset.

Thanks, I'll resubmit with these fixed.
