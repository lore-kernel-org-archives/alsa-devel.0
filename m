From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/5] ASoC: fsl: imx-pcm driver cleanup
Date: Tue, 7 May 2013 16:54:00 +0800
Message-ID: <20130507085358.GA11012@S2101-09.ap.freescale.net>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9FE2608EE
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 10:53:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 25, 2013 at 11:18:45AM +0800, Shawn Guo wrote:
> The series removes the use of imx-pcm-audio/imx-fiq-pcm-audio platform
> device, and deletes imx-pcm driver by moving the functions needed by
> imx-pcm-fiq driver into imx-pcm-fiq.c.  This can be done because
> imx-pcm-dma has moved to generic dmaengine pcm driver and does not use
> any helper from imx-pcm driver now.
> 
> Shawn Guo (5):
>   ASoC: fsl: remove use of imx-pcm-audio from fsl_ssi
>   ASoC: fsl: remove use of imx-pcm-audio from imx-ssi
>   ASoC: fsl: create function imx_pcm_fiq_exit()
>   ASoC: fsl: remove use of imx-fiq-pcm-audio from imx-ssi
>   ASoC: fsl: remove imx-pcm driver

Ping.
