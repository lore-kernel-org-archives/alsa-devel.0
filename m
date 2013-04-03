From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/8] ASoC: tegra: Don't claim to support
 PCM pause and resume
Date: Wed, 03 Apr 2013 10:56:10 -0600
Message-ID: <515C5F2A.4090204@wwwdotorg.org>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979607-15286-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DAC6265CC5
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 18:56:15 +0200 (CEST)
In-Reply-To: <1364979607-15286-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 03:00 AM, Lars-Peter Clausen wrote:
> The tegra dmaengine driver does not support pausing and resuming a DMA stream.
> The tegra PCM driver still claims to support pause and resume though and

Tegra really should be capitalized in free-form text, since it's a name,
but I suppose that's a nit.

> implements them by stopping and restarting the stream. This is not what an
> application using pause/resume would expect. Usually applications have support
> for working around PCMs which do not support suspend and resume, so don't set
> the SNDRV_PCM_INFO_PAUSE and SNDRV_PCM_INFO_RESUME flags for the tegra PCM and
> use the default snd_dmaengine_pcm_trigger callback.

Since Laxman posted the same patch,
Acked-by: Stephen Warren <swarren@nvidia.com>
