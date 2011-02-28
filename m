From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Tegra: Fix error handling in DMA
	channel alloc
Date: Mon, 28 Feb 2011 15:10:00 +0000
Message-ID: <20110228151000.GB26619@opensource.wolfsonmicro.com>
References: <1298430994-20999-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EBF42455E
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 16:09:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298430994-20999-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 22, 2011 at 08:16:34PM -0700, Stephen Warren wrote:
> tegra_dma_allocate_channel() returns NULL on errors, not an error pointer.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.
