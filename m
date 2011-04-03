From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: PXA: Fix oops in
	__pxa2xx_pcm_prepare
Date: Sun, 3 Apr 2011 18:55:16 +0900
Message-ID: <20110403095503.GA17580@opensource.wolfsonmicro.com>
References: <1301686530-8560-1-git-send-email-anarsoul@gmail.com>
	<1301730887-7755-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7667243EB
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 11:55:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301730887-7755-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 10:54:47AM +0300, Vasily Khoruzhick wrote:
> pxa2xx_pcm_hw_free frees dma channel and sets prtd->dma_ch to -1,
> but does not set prtd->params to NULL, so if pxa2xx_pcm_hw_params will
> be called immediately, it leaves prtd->dma_ch initialized with -1,
> and it results in oops in __pxa2xx_pcm_prepare. This bug is triggered
> via SDL.
> 
> This patch adds check for prtd->dma_ch to __pxa2xx_pcm_prepare and
> cleans prtd->params, so now it works properly.

Applied, thanks.
