From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 04/14] ASoC: tegra_pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 09:44:29 -0600
Message-ID: <514C7C5D.6030303@wwwdotorg.org>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C11C2651A0
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 16:44:34 +0100 (CET)
In-Reply-To: <1363957934-20059-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Laxman Dewangan <ldewangan@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/22/2013 07:12 AM, Lars-Peter Clausen wrote:
> If a PCM driver using the dmaengine PCM helper functions doesn't need to do
> anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
> directly for as the pcm_close callback and there is no need to wrap it in a
> custom function.

Acked-by: Stephen Warren <swarren@nvidia.com>
