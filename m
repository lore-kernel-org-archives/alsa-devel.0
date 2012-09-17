From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 33/34] ARM: imx: remove header file
	mach/irqs.h
Date: Mon, 17 Sep 2012 11:32:52 +0000
Message-ID: <201209171132.52380.arnd@arndb.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D4C8264FF8
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 13:33:11 +0200 (CEST)
In-Reply-To: <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Monday 17 September 2012, Shawn Guo wrote:
> @@ -269,6 +268,8 @@ static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
>         return 0;
>  }
>  
> +extern int mxc_set_irq_fiq(unsigned int irq, unsigned int type);
> +
>  static void imx_pcm_fiq_free(struct snd_pcm *pcm)
>  {
>         mxc_set_irq_fiq(ssi_irq, 0);

Hmm, this is quite hacky, I can see why you left it all the way
to the end of the otherwise excellent series ;-)

We already have some fiq specific stuff in the
include/linux/platform_data/asoc-imx-ssi.h header file,
so I think it's best to put this declaration there, too.

If we want to eventually clean up the fiq usage in this driver,
I think we should extend the DT binding for the interrupt controller
to describe the fiq correctly so it can all be done transparently.

	Arnd
