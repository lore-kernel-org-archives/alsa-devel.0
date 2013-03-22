From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 03/14] ASoC: omap-pcm: No need to wrap
 snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 16:15:50 +0200
Message-ID: <20130322161550.bee49999adc99919345ade9d@bitmer.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-4-git-send-email-lars@metafoo.de>
 <514C58E8.4040605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C8BA92651AF
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 15:15:21 +0100 (CET)
In-Reply-To: <514C58E8.4040605@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Sebastien Guiriec <s-guiriec@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Mar 2013 14:13:12 +0100
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> On 03/22/2013 02:12 PM, Lars-Peter Clausen wrote:
> > If a PCM driver using the dmaengine PCM helper functions doesn't need to do
> > anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
> > directly for as the pcm_close callback and there is no need to wrap it in a
> > custom function.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> > Cc: Sebastien Guiriec <s-guiriec@ti.com>
> > ---
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
