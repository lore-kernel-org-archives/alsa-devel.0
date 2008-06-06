From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Update MPC8610 drivers to pick
	the right DMA	channels
Date: Fri, 6 Jun 2008 21:01:17 +0100
Message-ID: <20080606200116.GB3989@opensource.wolfsonmicro.com>
References: <1212768113-20782-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A699F103803
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 22:01:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212768113-20782-1-git-send-email-timur@freescale.com>
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

On Fri, Jun 06, 2008 at 11:01:53AM -0500, Timur Tabi wrote:
> On the Freescale MPC8610 SOC, SSI1 is hard-wired to DMA channels 0 and 1,
> and SSI2 is hard-wired to DMA channels 2 and 3.  Fix fsl_ssi.c to reflect
> that.

Applied, thanks.
