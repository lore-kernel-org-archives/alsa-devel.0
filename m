From: Rongjun Ying <Rongjun.Ying@csr.com>
Subject: Re: [PATCH v3 1/5] ASoC: sirf: add sirf platform
 driver which provides DMA
Date: Wed, 8 Jan 2014 09:01:15 +0000
Message-ID: <86130EF012BDF348AA0D464A4F449478012AC86DD2@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
 <20140106170715.GK31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
 [85.115.60.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FE1B2610D7
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 10:01:30 +0100 (CET)
In-Reply-To: <20140106170715.GK31886@sirena.org.uk>
Content-Language: zh-CN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, RongJun Ying <rjying@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, January 07, 2014 1:07 AM
> To: RongJun Ying
> Cc: Liam Girdwood; Jaroslav Kysela; Takashi Iwai; alsa-devel@alsa-
> project.org; DL-SHA-WorkGroupLinux; Rongjun Ying
> Subject: Re: [PATCH v3 1/5] ASoC: sirf: add sirf platform driver which
> provides DMA
> 
> On Fri, Jan 03, 2014 at 02:05:00PM +0800, RongJun Ying wrote:
> 
> > index 0000000..1637089
> > --- /dev/null
> > +++ b/sound/soc/sirf/Kconfig
> > @@ -0,0 +1,4 @@
> > +config SND_SIRF_SOC
> > +	tristate "Platform DMA driver for the SiRF SoC chips"
> > +	depends on ARCH_SIRF && SND_SOC
> > +	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> No need for the SND_SOC dependency, the subdirectories are only
> enumerated if it is selected, and looking at the code I don't see a
> build time dependency on ARCH_SIRF so it should be ARCH_SIRF ||
> COMPILE_TEST.
> 
> > +static struct dma_chan *sirf_pcm_request_chan(struct
> snd_soc_pcm_runtime *rtd,
> > +	struct snd_pcm_substream *substream) {
> > +	struct snd_dmaengine_dai_dma_data *dma_data;
> > +
> > +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> > +
> > +	return dma_request_slave_channel(rtd->cpu_dai->dev,
> > +			dma_data->chan_name);
> > +}
> > +
> > +static const struct snd_dmaengine_pcm_config
> sirf_dmaengine_pcm_config = {
> > +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> > +	.compat_request_channel = sirf_pcm_request_chan,
> 
> Do you need the compat_request_chan - I'd expect a newish ARM system to
> be DT only and the code doesn't look like it's doing anything that the
> core couldn't handle?
> 
> > +static struct platform_driver sirf_pcm_driver = {
> > +	.driver = {
> > +		.name = "sirf-pcm-audio",
> > +		.owner = THIS_MODULE,
> > +	},
> > +	.probe = sirf_pcm_probe,
> > +};
> 
> This doesn't look to ever access any hardware directly so it probably
> shouldn't be a standalone driver as Lars-Peter says.
> 
> > +static int __init sirf_pcm_init(void) {
> > +	int ret = 0;
> > +
> > +	ret = platform_driver_register(&sirf_pcm_driver);
> > +	if (ret)
> > +		pr_err("failed to register platform driver\n");
> > +	return ret;
> > +}
> 
> module_platform_driver() if there is some real hardware here.

Do you mean to add pcm device into dts?

pcm {
   compatible = "sirf,pcm-audio";
}

-------------------
BR
RongJun Ying


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
