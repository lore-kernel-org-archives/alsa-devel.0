From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: Use filter_data rather
 than dma_data for compat requests
Date: Sat, 19 Oct 2013 19:22:17 +0200
Message-ID: <5262BFC9.3020405@metafoo.de>
References: <1382189739-22732-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-103.synserver.de
 [212.40.185.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 839912608EE
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 19:22:19 +0200 (CEST)
In-Reply-To: <1382189739-22732-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 03:35 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> When using the legacy filter function channel requests we currently pass
> the audio specific struct snd_dmaengine_dai_dma_data which isn't likely to
> be helpful for actual filtering. Since there's already a field in the
> structure called filter_data clearly intended for use here convert the
> driver to use that.
> 
> All existing users of plain filter functions have been converted to use
> an explict compat function to override this behaviour.

I think this patch also needs to update sound/soc/fsl/imx-pcm-dma.c
