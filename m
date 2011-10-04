From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Fix the no period wakeup
	implementation
Date: Tue, 4 Oct 2011 12:04:29 +0100
Message-ID: <20111004110428.GG3250@opensource.wolfsonmicro.com>
References: <1317715792-30279-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56685245FF
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:04:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317715792-30279-1-git-send-email-peter.ujfalusi@ti.com>
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

On Tue, Oct 04, 2011 at 11:09:52AM +0300, Peter Ujfalusi wrote:
> After omap_request_dma the BLOCK_IRQ is enabled as default
> configuration for the channel.
> If we are requested for no period wakeup, we need to disable
> the BLOCK_IRQ in order to not receive any interrupts.

Applied, thanks.
