From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Tue, 29 Oct 2013 04:00:57 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131024110543.GA18506@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.co>
List-Id: alsa-devel@alsa-project.org


> > +static struct snd_pcm_hardware snd_fsl_hardware = {
> > +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		SNDRV_PCM_INFO_MMAP |
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME,
> > +	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rate_min = 8000,
> > +	.channels_min = 2,
> > +	.channels_max = 2,
> > +	.buffer_bytes_max = FSL_SAI_DMABUF_SIZE,
> > +	.period_bytes_min = 4096,
> > +	.period_bytes_max = FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> > +	.periods_min = TCD_NUMBER,
> > +	.periods_max = TCD_NUMBER,
> > +	.fifo_size = 0,
> > +};
> 
> There's a patch in -next that lets the generic dmaengine code figure out
> some settings from the dmacontroller rather than requiring the driver to
> explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> default config".  Please update your driver to use this, or let's work
> out what it doesn't do any try to fix it.
> 

I couldn't find the patch in the next and other trees.
Does this patch has been submitted to the -next tree ?
Or could you tell me how to find the patch please?

Thanks very much.
