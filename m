From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Fri, 22 Mar 2013 16:39:09 +0800
Message-ID: <20130322083906.GE6281@S2101-09.ap.freescale.net>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-3-git-send-email-shawn.guo@linaro.org>
 <20130321095718.GO10326@intel.com>
 <20130321145258.GC23109@S2101-09.ap.freescale.net>
 <514C1139.6050309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 97D7C26627F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 09:38:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <514C1139.6050309@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2013 at 09:07:21AM +0100, Sebastien Guiriec wrote:
> Now I will wait Lars serie to check again on OMAP and let Mark
> comment on the best approach. Whereas update current API like you
> propose or wait Lars series and move on according to the different
> comments done on open function. As OMAP audio DMA binding are
> depending on the chosen solution.

This the case for everyone else who is moving their audio driver to
generic DMA bindings.  For mxs platform that I'm working on, audio
becomes the only one not moving to generic DMA bindings.

Shawn
