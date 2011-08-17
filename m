From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: fix build warning in fsl_dma
Date: Wed, 17 Aug 2011 15:53:06 +0900
Message-ID: <20110817065304.GA12885@opensource.wolfsonmicro.com>
References: <1313546309-1453-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6089E1038BC
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:53:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313546309-1453-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 16, 2011 at 09:58:29PM -0400, Timur Tabi wrote:
> The previous patch to fsl_dma.c ("fix initialization of DMA buffers")
> left behind an unused local variable that causes a build warning.

Applied, thanks.
