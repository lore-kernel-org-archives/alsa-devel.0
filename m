From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv3 1/7] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Thu, 19 Dec 2013 03:16:44 +0000
Message-ID: <00b7bf44664b4d9e8a7317d73f039cef@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-2-git-send-email-Li.Xiubo@freescale.com>
 <20131218182731.GE31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 by alsa0.perex.cz (Postfix) with ESMTP id C4DEB2652C7
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 04:16:48 +0100 (CET)
In-Reply-To: <20131218182731.GE31886@sirena.org.uk>
Content-Language: en-US
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>, "oskar@scara.com" <os>
List-Id: alsa-devel@alsa-project.org

> On Tue, Dec 17, 2013 at 11:24:38AM +0800, Xiubo Li wrote:
> 
> > This adds Freescale SAI ASoC Audio support.
> > This implementation is only compatible with device tree definition.
> 
> This is mostly good, there are two small issues below but I've applied it
> since they don't really affect the driver as a whole.  Please send followup
> patches to fix the issues below.
> 
> > +static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai) {
> > +	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
> > +
> > +	cpu_dai->playback_dma_data = &sai->dma_params_tx;
> > +	cpu_dai->capture_dma_data = &sai->dma_params_rx;
> 
> You should use snd_soc_dai_init_dma_data() for this.
>

Yes, I will use it.
 
> > +static int fsl_sai_dai_remove(struct snd_soc_dai *cpu_dai) {
> > +	cpu_dai->playback_dma_data = NULL;
> > +	cpu_dai->capture_dma_data = NULL;
> > +
> > +	snd_soc_dai_set_drvdata(cpu_dai, NULL);
> > +
> > +	return 0;
> > +}
> 
> This is all unneeded and this function should be removed entirely.

I will remove this and other unneeded functions like this.

Best Regards,
Xiubo
