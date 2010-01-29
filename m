From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: AM3517: ASoC driver not getting
	compiled
Date: Fri, 29 Jan 2010 14:03:38 +0000
Message-ID: <20100129140337.GD4768@rakim.wolfsonmicro.main>
References: <1264760362-25465-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0915110390E
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:03:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264760362-25465-1-git-send-email-anuj.aggarwal@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 03:49:22PM +0530, Anuj Aggarwal wrote:
> Commit 761c9d45 (ASoC: Fix build of OMAP sound drivers) changes
> CONFIG_MACH_OMAP3517EVM -> CONFIG_SND_OMAP_SOC_OMAP3517EVM in the
> Makefile. Whereas the config option defined in Kconfig is
> SND_OMAP_SOC_AM3517EVM. Because of this, ASoC driver for AM3517
> was not getting compiled.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Applied, thanks.
