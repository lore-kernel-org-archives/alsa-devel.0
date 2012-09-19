From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: imx-pcm-dma: check kzalloc
 return value in function snd_imx_open
Date: Tue, 18 Sep 2012 22:52:53 -0400
Message-ID: <20120919025253.GK8832@opensource.wolfsonmicro.com>
References: <1347960006-23681-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9079526514A
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:52:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347960006-23681-1-git-send-email-richard.zhao@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2012 at 05:20:05PM +0800, Richard Zhao wrote:
> It fixed smatch warning:
> sound/soc/fsl/imx-pcm-dma.c:112 snd_imx_open() error: potential null dereference 'dma_data'.  (kzalloc returns null)

Applied both, thanks.
