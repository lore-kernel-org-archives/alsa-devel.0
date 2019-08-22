From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Date: Thu, 22 Aug 2019 09:23:39 +0200
Message-ID: <20190822072338.GA30465@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822071835.GA30262@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 22, 2019 at 09:18:35AM +0200, Guennadi Liakhovetski wrote:

[snip]

> >  static int hda_sdw_init(struct snd_sof_dev *sdev)
> >  {
> >  	acpi_handle handle;
> > @@ -67,6 +131,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
> >  	res.mmio_base = sdev->bar[HDA_DSP_BAR];
> >  	res.irq = sdev->ipc_irq;
> >  	res.parent = sdev->dev;
> > +	res.ops = &sdw_callback;
> > +	res.arg = sdev;
> >  
> >  	sdw = sdw_intel_init(handle, &res);
> >  	if (!sdw) {
> 
> Hm, looks like this function is using spaces for indentation... Let me check 
> if this is coming from an earlier patch

Ouch, it's mutt or whatever editor it's using... Sorry for the noise.

Thanks
Guennadi
