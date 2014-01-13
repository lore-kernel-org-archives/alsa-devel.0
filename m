From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v3] ASoC: imx: Allow using sound with DT
 descriptions only
Date: Mon, 13 Jan 2014 18:32:12 +0400
Message-ID: <20140113183212.22f73787442da8af0879d012@mail.ru>
References: <1389358827-381-1-git-send-email-shc_work@mail.ru>
 <20140113035626.GI23525@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E62261684
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 15:32:21 +0100 (CET)
In-Reply-To: <20140113035626.GI23525@S2101-09.ap.freescale.net>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On Mon, 13 Jan 2014 11:56:28 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Jan 10, 2014 at 05:00:27PM +0400, Alexander Shiyan wrote:
> > This patch allow using generic sound cards/codecs based on DT description.
...
> > -config SND_SOC_IMX_AUDMUX
> > +menuconfig SND_IMX_SOC
> > +	tristate "SoC Audio for Freescale i.MX CPUs"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	select SND_SOC_FSL_SSI if OF
> > +	select SND_SOC_IMX_AUDMUX
> > +	select SND_SOC_IMX_PCM_DMA
> 
> Just want to understand the direction of this change.  Besides
> FSL_SSI, we will have other CPU DAIs FSL_SPDIF, FSL_ESAI and FSL_SAI.
> Will we select all of them from SND_IMX_SOC, or we only do it for
> FSL_SSI?  Note, IMX_AUDMUX should be only needed for machine drivers
> that use SSI CPU DAI.

Not clear how to do it right ...
I conclude that the first version of the patch was the best, do a separate
symbol for DT and select all required options.
Rewrite in this way?

-- 
Alexander Shiyan <shc_work@mail.ru>
