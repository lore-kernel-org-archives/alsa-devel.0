From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Simplify checks for
 McBSP IP with FIFO
Date: Tue, 17 Jan 2012 15:42:53 +0000
Message-ID: <20120117154252.GH2944@opensource.wolfsonmicro.com>
References: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
	<1326806170-7425-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 724D024429
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 16:42:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326806170-7425-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 02:16:09PM +0100, Peter Ujfalusi wrote:
> From OMAP3 onwards the McBSP ports have FIFO. To avoid adding supported
> SoC families to the list we can just rule out the omap24xx SoCs.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
